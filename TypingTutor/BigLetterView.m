//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Jacob Good on 8/25/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "BigLetterView.h"
#import "FirstLetter.h"

@implementation BigLetterView

- (id)initWithFrame:(NSRect)frame {
    [super initWithFrame:frame];
	NSLog(@"initWithFrame:");
	[self prepareAttributes];
	bgColor = [[NSColor yellowColor] retain];
	string = @" ";
	[self registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];
	return self;
}

- (void)dealloc
{
	[bgColor release];
	[string release];
	[attributes release];
	[super dealloc];
}

- (void)prepareAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	
	[attributes setObject:[NSFont fontWithName:@"Helvetica" size:75]
				   forKey:NSFontAttributeName];
	
	[attributes setObject:[NSColor redColor]
				   forKey:NSForegroundColorAttributeName];
}

#pragma mark CutNPaste

- (IBAction)cut:(id)sender
{
	[self copy:sender];
	[self setString:@""];
}

- (IBAction)copy:(id)sender
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[self writeToPasteboard:pb];
}

- (IBAction)paste:(id)sender
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	if (![self readFromPasteboard:pb])
	{
		NSBeep();
	}
}

#pragma mark DragNDrop

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
	return NSDragOperationCopy | NSDragOperationDelete;
}

- (void)mouseDown:(NSEvent *)event
{
	[event retain];
	[mouseDownEvent release];
	mouseDownEvent = event;
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint down = [mouseDownEvent locationInWindow];
	NSPoint drag = [event locationInWindow];
	float distance = hypot(down.x - drag.x, down.y - drag.y);
	
	if (distance < 3)
		return;
	
	if ([string length] == 0)
		return;
	
	NSSize s = [string sizeWithAttributes:attributes];
	NSImage *anImage = [[NSImage alloc] initWithSize:s];
	NSRect imageBounds;
	imageBounds.origin = NSZeroPoint;
	imageBounds.size = s;
	
	[anImage lockFocus];
	[self drawStringCenteredIn:imageBounds];
	[anImage unlockFocus];
	
	NSPoint p = [self convertPoint:down fromView:nil];
	p.x = p.x - s.width/2;
	p.y = p.y - s.height/2;
	
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
	[self writeToPasteboard:pb];
	
	[self dragImage:anImage
				 at:p
			 offset:NSMakeSize(0,0)
			  event:mouseDownEvent
		 pasteboard:pb
			 source:self
		  slideBack:YES];
	
	[anImage release];
}

- (void)draggedImage:(NSImage *)image
			 endedAt:(NSPoint)screenPoint
		   operation:(NSDragOperation)operation
{
	if (operation == NSDragOperationDelete)
		[self setString:@""];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	NSLog(@"draggingEntered:");
	if ([sender draggingSource] == self)
		return NSDragOperationNone;
	
	highlighted = YES;
	[self setNeedsDisplay:YES];
	return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	NSLog(@"draggingExited");
	highlighted = NO;
	[self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
	return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard *pb = [sender draggingPasteboard];
	if (![self readFromPasteboard:pb])
	{
		NSLog(@"Error: Could not read from dragging pasteboard");
		return NO;
	}
	return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
	NSLog(@"concludeDragOperation");
	highlighted = NO;
	[self setNeedsDisplay:YES];
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
	NSDragOperation op = [sender draggingSourceOperationMask];
	NSLog(@"operation mask = %d", op);
	if ([sender draggingSource] == self)
		return NSDragOperationNone;
	return NSDragOperationCopy;
}

#pragma mark Drawing

- (BOOL)isOpaque
{
	return YES;
}

- (void)drawRect:(NSRect)rect 
{
    NSRect bounds = [self bounds];
	[bgColor set];
	[NSBezierPath fillRect:bounds];
	
	if (highlighted) {
		NSGradient *gr;
		gr = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor]	endingColor:bgColor];
		[gr drawInRect:bounds relativeCenterPosition:NSZeroPoint];
		[gr release];
	}
	else {
		[bgColor set];
		[NSBezierPath fillRect:bounds];
	}
	
	[self drawStringCenteredIn:bounds];
	
	if (([[self window] firstResponder] == self) &&
		([NSGraphicsContext currentContextDrawingToScreen])){
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
}

- (void)drawStringCenteredIn:(NSRect)r
{
	NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
	strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
	[string drawAtPoint:strOrigin withAttributes:attributes];
}

#pragma mark Keyboard Events

- (BOOL)acceptsFirstResponder
{
	NSLog(@"Accepting");
	return YES;
}

- (BOOL)resignFirstResponder
{
	NSLog(@"Resigning");
	[self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
	return YES;
}

- (BOOL)becomeFirstResponder
{
	NSLog(@"Becoming");
	[self setNeedsDisplay:YES];
	return YES;
}

- (void)keyDown:(NSEvent *)e
{
	[self interpretKeyEvents:[NSArray arrayWithObject:e]];
}

- (void)insertText:(NSString *)s
{
	[self setString:s];
}

- (void)insertTab:(id)sender
{
	[[self window] selectNextKeyView:nil];
}

- (void)insertBacktab:(id)sender
{
	[[self window] selectPreviousKeyView:nil];
}

- (void)deleteBackward:(id)sender
{
	[self setString:@" "];
}


#pragma mark Accessors

- (NSColor *)bgColor
{
	return bgColor;
}

- (void)setBgColor:(NSColor *)c
{
	[c retain];
	[bgColor release];
	bgColor = c;
	[self setNeedsDisplay:YES];
}

- (NSString *)string
{
	return string;
}

- (void)setString:(NSString *)s
{
	s = [s copy];
	[string release];
	string = s;
	[self setNeedsDisplay:YES];
	NSLog(@"the string is now %@", string);
}

- (IBAction)savePDF:(id)sender
{
	NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setRequiredFileType:@"pdf"];
	[panel beginSheetForDirectory:nil 
							 file:nil 
				   modalForWindow:[self window]
					modalDelegate:self 
				   didEndSelector:@selector(didEnd:returnCode:contextInfo:) 
					  contextInfo:NULL];
}

- (void) didEnd:(NSSavePanel *)sheet
	 returnCode:(int)code
	contextInfo:(void *)contextInfo
{
	if (code != NSOKButton)
		return;
	
	NSRect r = [self bounds];
	NSData *data = [self dataWithPDFInsideRect:r];
	NSString *path = [sheet filename];
	NSError *error;
	BOOL successful = [data writeToFile:path
								options:0
								  error:&error];
	
	if(!successful)
	{
		NSAlert *a = [NSAlert alertWithError:error];
		[a runModal];
	}
}

- (void)writeToPasteboard:(NSPasteboard *)pb
{
	[pb declareTypes:[NSArray arrayWithObject:NSStringPboardType]
			   owner:self];
	[pb setString:string forType:NSStringPboardType];
}

- (BOOL)readFromPasteboard:(NSPasteboard *)pb
{
	NSArray *types = [pb types];
	if ([types containsObject:NSStringPboardType])
	{
		NSString *value = [pb stringForType:NSStringPboardType];
		[self setString:[value BNR_firstLetter]];
		return YES;
	}
	return NO;
}

@end
