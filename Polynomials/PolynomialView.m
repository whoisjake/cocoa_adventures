//
//  PolynomialView.m
//  Polynomials
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "PolynomialView.h"
#import "Polynomial.h"
#import <QuartzCore/QuartzCore.h>

#define MARGIN (10)

@implementation PolynomialView

- (id)initWithFrame:(NSRect)frame {
    [super initWithFrame:frame];
    polynomials = [[NSMutableArray alloc] init];
    blasted = NO;
    return self;
}


#pragma mark resizing


- (void)resizeAndRedrawPolynomialLayers
{
    CGRect b = [[self layer] bounds]; 
    b = CGRectInset(b, MARGIN, MARGIN);
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    NSArray *polynomialLayers = [[self layer] sublayers];
    for (CALayer *layer in polynomialLayers) {
        b.origin = [layer frame].origin;
        [layer setFrame:b];
        [layer setNeedsDisplay];
    }        
    [NSAnimationContext endGrouping];
	
}

- (void)setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    if (![self inLiveResize]) {
        [self resizeAndRedrawPolynomialLayers];
    }
}


- (void)viewDidEndLiveResize
{
    [self resizeAndRedrawPolynomialLayers];
}


#pragma mark Actions

- (IBAction)blastem:(id)sender
{
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:3.0f];
    NSArray *polynomialLayers = [[self layer] sublayers];
	
    for (CALayer *layer in polynomialLayers) {
        CGPoint p;
        if (blasted) {
            p.x = MARGIN;
            p.y = MARGIN;
        } else {
            NSPoint r = [self randomOffViewPosition];
            p = *(CGPoint *)&r;
        }
        [layer setPosition:p];
    }
    [NSAnimationContext endGrouping];
    [self willChangeValueForKey:@"blasted"];
    blasted = !blasted;
    [self didChangeValueForKey:@"blasted"];
	
}
- (NSPoint)randomOffViewPosition
{
    NSRect bounds = [self bounds];
    float radius = hypot(bounds.size.width, bounds.size.height);
	
    float angle = 2.0 * M_PI * (random() % 360 / 360.0);
    NSPoint p;
    p.x = radius * cos (angle);
    p.y = radius * sin (angle); 
    return p;
}


- (IBAction)createNewPolynomial:(id)sender
{    
    Polynomial *p = [[Polynomial alloc] init];
    [polynomials addObject:p];
    CALayer *layer = [CALayer layer];
    CGRect b = [[self layer] bounds]; 
    b = CGRectInset(b, MARGIN, MARGIN);
    
    CGPoint zeroPoint;
    zeroPoint.x = 0;
    zeroPoint.y = 0;    
    [layer setAnchorPoint:zeroPoint];
    
    [layer setFrame:b];
    [layer setDelegate:p];
    [layer setCornerRadius:12];
    [layer setBorderColor:[p color]];
    [layer setBorderWidth:3.5];
    
    [[self layer] addSublayer:layer];
    [layer display];
    CABasicAnimation *anim 
    = [CABasicAnimation animationWithKeyPath:@"position"];
    [anim setFromValue:[NSValue valueWithPoint:[self randomOffViewPosition]]];
    [anim setToValue:[NSValue valueWithPoint:NSMakePoint(MARGIN,MARGIN)]];
    [anim setDuration:1.0];
    CAMediaTimingFunction *f
    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [anim setTimingFunction:f];
    [layer addAnimation:anim forKey:@"whatever"];
}
- (IBAction)deleteRandomPolynomial:(id)sender
{
    NSArray *polynomialLayers = [[self layer] sublayers];
	
    if ([polynomialLayers count] == 0) {
        NSBeep();
        return;
    }
    int i = random() % [polynomialLayers count];
    NSPoint toPoint = [self randomOffViewPosition];
    CALayer *layerToPull = [polynomialLayers objectAtIndex:i];
    CABasicAnimation *anim 
    = [CABasicAnimation animationWithKeyPath:@"position"];
    [anim setValue:layerToPull forKey:@"representedPolynomialLayer"];
    [anim setFromValue:[NSValue valueWithPoint:NSMakePoint(MARGIN,MARGIN)]];
    [anim setToValue:[NSValue valueWithPoint:toPoint]];
    [anim setDuration:1.0];
    CAMediaTimingFunction *f
    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [anim setTimingFunction:f];
    [anim setDelegate:self];
    [layerToPull addAnimation:anim forKey:@"whatever"];
    [layerToPull setPosition:CGPointMake(toPoint.x, toPoint.y)];
	
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
{
    // FIXME: layer flashes at Position 0,0 before removal
    CALayer *layerToPull = [anim valueForKey:@"representedPolynomialLayer"];
    Polynomial *p = [layerToPull delegate];
    [polynomials removeObjectIdenticalTo:p];
    [layerToPull removeFromSuperlayer];
}
#pragma mark Drawing

- (void)drawRect:(NSRect)rect 
{
    NSRect bounds = [self bounds];
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:bounds];
}

@end
