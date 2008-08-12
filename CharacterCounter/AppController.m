//
//  AppController.m
//  CharacterCounter
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (IBAction) countIt:(id) sender
{
	NSString *target = [inputField stringValue];
	int len = [target length];
	if (len < 0)
	{
		[countLabel setStringValue:@"??"];
		return;
	}
	
	NSString *resultString = [[NSString alloc] initWithFormat:
							  @"'%@' has %d characters.",target,len];
	[countLabel setStringValue:resultString];
}

@end
