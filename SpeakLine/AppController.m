//
//  AppController.m
//  SpeakLine
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id) init
{
	[super init];
	
	// Logs can help the beginner understand what
	// is happening and hunt down bugs.
	NSLog(@"init");
	
	// Create a new instanceof NSSpeechSynthesizer
	// with the default voice.
	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
	return self;
}

- (IBAction) sayIt:(id)sender
{
	NSString *string = [textField stringValue];
	
	// Is the string zero-length?
	if ([string length] == 0) {
		NSLog(@"string from %@ is of zero-length", textField);
		return;
	}
	
	[speechSynth startSpeakingString:string];
	NSLog(@"Have started to say: %@", string);
}

- (IBAction) stopIt:(id)sender
{
	NSLog(@"stopping");
	[speechSynth stopSpeaking];
}

@end
