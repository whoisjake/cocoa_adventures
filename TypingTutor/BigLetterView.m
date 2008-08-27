//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Jacob Good on 8/25/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "BigLetterView.h"

@implementation BigLetterView

- (id)initWithFrame:(NSRect)frame {
    [super initWithFrame:frame];
	NSLog(@"initWithFrame:");
	[self prepareAttributes];
	bgColor = [[NSColor yellowColor] retain];
	string = @" ";
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
		if ([value length] == 1)
		{
			[self setString:value];
			return YES;
		}
	}
	return NO;
}

@end
