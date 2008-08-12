//
//  AppController.h
//  SpeakLine
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *textField;
	NSSpeechSynthesizer *speechSynth;
}

- (IBAction) sayIt:(id) sender;
- (IBAction) stopIt:(id) sender;

@end
