//
//  AppController.m
//  RaiseMan
//
//  Created by Jacob Good on 8/22/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender
{
	// IS preferenceController nil?
	if (!preferenceController)
		preferenceController = [[PreferenceController alloc] init];
	
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

@end
