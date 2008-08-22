//
//  AppController.h
//  RaiseMan
//
//  Created by Jacob Good on 8/22/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
}

- (IBAction)showPreferencePanel:(id)sender;

@end
