//
//  AppController.h
//  ImageFun
//
//  Created by Jacob Good on 8/25/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class StretchView;

@interface AppController : NSObject {
	IBOutlet StretchView *stretchView;
}

- (IBAction)showOpenPanel:(id)sender;

@end
