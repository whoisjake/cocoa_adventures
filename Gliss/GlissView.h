//
//  GlissView.h
//  Gliss
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GlissView : NSOpenGLView {
	IBOutlet NSMatrix *sliderMatrix;
	int displayList;
	float lightX, theta, radius;
}
- (IBAction)changeParameter:(id)sender;
@end

