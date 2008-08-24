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
    
	}
    return self;
}

- (void)dealloc
{
	[path release];
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
}

@end
