//
//  PolynomialView.h
//  Polynomials
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PolynomialView : NSView {
    NSMutableArray *polynomials;
	BOOL blasted;
}
- (IBAction)createNewPolynomial:(id)sender;
- (IBAction)deleteRandomPolynomial:(id)sender;
- (IBAction)blastem:(id)sender;
- (NSPoint)randomOffViewPosition;
@end
