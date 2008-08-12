//
//  AppController.h
//  CharacterCounter
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *inputField;
	IBOutlet NSTextField *countLabel;
}

- (IBAction) countIt:(id) sender;

@end
