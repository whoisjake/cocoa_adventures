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

+ (void)initialize
{
	// Create a dictionary
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	// Archive the color object
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
	
	// Put defaults in the dictionary
	[defaultValues setObject:colorAsData forKey:BNRTableBgColorKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];
	
	// Register the dictionary of defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	NSLog(@"registered defaults: %@", defaultValues);
}

- (BOOL)applicationShouldOpenUntilitedFile:(NSApplication *)sender
{
	NSLog(@"applicationShouldOpenUntitledFile:");
	return [[NSUserDefaults standardUserDefaults] boolForKey:BNREmptyDocKey];
}

- (IBAction)showPreferencePanel:(id)sender
{
	// IS preferenceController nil?
	if (!preferenceController)
		preferenceController = [[PreferenceController alloc] init];
	
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

@end
