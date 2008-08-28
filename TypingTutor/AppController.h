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
	
	NSArray *letters;
	int lastIndex;
	
	NSTimer *timer;
	int count;
}

- (IBAction)stopGo:(id)sender;
- (void)incrementCount;
- (void)resetCount;
- (void)showAnotherLetter;

@end
