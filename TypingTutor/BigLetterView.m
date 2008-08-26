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
	bgColor = [[NSColor yellowColor] retain];
	string = @" ";
	return self;
}
- (void)dealloc
{
	[bgColor release];
	[string release];
	[super dealloc];
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
	
	if (([[self window] firstResponder] == self) &&
		([NSGraphicsContext currentContextDrawingToScreen])){
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
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
	NSLog(@"the string is now %@", string);
}

@end
