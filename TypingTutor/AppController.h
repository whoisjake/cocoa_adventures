//
//  AppController.h
//  TypingTutor
//
//  Created by Jacob Good on 8/28/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BigLetterView;

@interface AppController : NSObject {
	IBOutlet BigLetterView *inLetterView;
	IBOutlet BigLetterView *outLetterView;
	IBOutlet NSWindow *speedSheet;
	
	NSArray *letters;
	int lastIndex;
	
	NSTimer *timer;
	int count;
	int stepSize;
}

- (IBAction)stopGo:(id)sender;
- (IBAction)showSpeedSheet:(id)sender;
- (IBAction)endSpeedSheet:(id)sender;
- (void)incrementCount;
- (void)resetCount;
- (void)showAnotherLetter;

@end
