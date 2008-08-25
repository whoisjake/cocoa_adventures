//
//  StretchView.m
//  ImageFun
//
//  Created by Jacob Good on 8/24/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "StretchView.h"


@implementation StretchView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
	
		srandom(time(NULL));
		
		path = [[NSBezierPath alloc] init];
		[path setLineWidth:3.0];
		NSPoint p = [self randomPoint];
		[path moveToPoint:p];
		int i;
		
		for (i = 0; i < 15; i++) {
			p = [self randomPoint];
			[path lineToPoint:p];
		}
		
		[path closePath];
		opacity = 1.0;
	}
    return self;
}

- (void)dealloc
{
	[path release];
	[image release];
	[super dealloc];
}

- (NSPoint)randomPoint
{
	NSPoint result;
	NSRect r = [self bounds];
	result.x = r.origin.x + random() % (int)r.size.width;
	result.y = r.origin.y + random() % (int)r.size.height;
	return result;
}

- (void)drawRect:(NSRect)rect {
    NSRect bounds = [self bounds];
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
	
	[[NSColor whiteColor] set];
	[path fill];
	
	if (image) {
		NSRect imageRect;
		imageRect.origin = NSZeroPoint;
		imageRect.size = [image size];
		NSRect drawingRect = [self currentRect];
		[image drawInRect:drawingRect
				 fromRect:imageRect 
				operation:NSCompositeSourceOver 
				 fraction:opacity];
	}
}

#pragma mrk Accessors

- (void)setImage:(NSImage *)newImage
{
	[newImage retain];
	[image release];
	image = newImage;
	
	NSSize imageSize = [newImage size];
	downPoint = NSZeroPoint;
	currentPoint.x = downPoint.x + imageSize.width;
	currentPoint.y = downPoint.y + imageSize.height;
	[self setNeedsDisplay:YES];
}

- (float)opacity
{
	return opacity;
}

- (void)setOpacity:(float)x
{
	opacity = x;
	[self setNeedsDisplay:YES];
}

#pragma mark Events

- (void)mouseDown:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	downPoint = [self convertPoint:p fromView:nil];
	currentPoint = downPoint;
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	currentPoint = [self convertPoint:p fromView:nil];
	[self autoscroll:event];
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	currentPoint = [self convertPoint:p fromView:nil];
	[self setNeedsDisplay:YES];
}

- (NSRect)currentRect
{
	float minX = MIN(downPoint.x, currentPoint.x);
	float maxX = MAX(downPoint.x, currentPoint.x);
	float minY = MIN(downPoint.y, currentPoint.y);
	float maxY = MAX(downPoint.y, currentPoint.y);
	return NSMakeRect(minX,minY,maxX-minX,maxY-minY);
}

@end
