//
//  PreferenceController.h
//  RaiseMan
//
//  Created by Jacob Good on 8/22/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell *colorWell;
	IBOutlet NSButton *checkbox;
}

- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;

@end
