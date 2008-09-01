//
//  Polynomial.h
//  Polynomials
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Polynomial : NSObject {
	__strong CGFloat *terms;
	int termCount;
	__strong CGColorRef color;
}
- (float)valueAt:(float)x;
- (void)drawInRect:(CGRect)b
		 inContext:(CGContextRef)ctx;
- (CGColorRef)color;

@end
