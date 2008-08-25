//
//  StretchView.h
//  ImageFun
//
//  Created by Jacob Good on 8/24/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface StretchView : NSView {
	NSBezierPath *path;
	NSImage *image;
	NSPoint downPoint;
	NSPoint currentPoint;
	float opacity;
}
@property (readwrite) float opacity;
- (void)setImage:(NSImage *)newImage;
- (NSPoint)randomPoint;
- (NSRect)currentRect;

@end
