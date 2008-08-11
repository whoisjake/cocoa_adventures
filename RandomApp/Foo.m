//
//  Foo.m
//  RandomApp
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "Foo.h"

@implementation Foo

- (IBAction)generate:(id)sender
{
	// Generate a random number between 1 and 100 inclusive
	int generated;
	generated = (random() % 100) + 1;
	
	NSLog(@"generated = %d", generated);
	
	// Ask the text field to change when it is displaying
	[textField setIntValue:generated];
}

- (IBAction)seed:(id)sender
{
	// Seed the random number generator with the time
	srandom(time(NULL));
	[textField setStringValue:@"Generator Seeded"];
}

- (void)awakeFromNib
{
	NSCalendarDate *now;
	now = [NSCalendarDate calendarDate];
	[textField setObjectValue:now];
}

@end
