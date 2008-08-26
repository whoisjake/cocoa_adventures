//
//  BigLetterView.h
//  TypingTutor
//
//  Created by Jacob Good on 8/25/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BigLetterView : NSView {
	NSColor *bgColor;
	NSString *string;
	NSMutableDictionary *attributes;
}

@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;
- (IBAction)savePDF:(id)sender;

@end
