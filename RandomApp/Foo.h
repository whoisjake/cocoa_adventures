//
//  Foo.h
//  RandomApp
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Foo : NSObject {
	IBOutlet NSTextField	*textField;
}
- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;

@end
