//
//  AppController.m
//  KVCFun
//
//  Created by Jacob Good on 8/13/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id) init
{
	[super init];
	
	[self setValue:[NSNumber numberWithInt:5]
			forKey:@"fido"];
	NSNumber *n = [self valueForKey:@"fido"];
	NSLog(@"fido = %@", n);
	return self;
}

@synthesize fido;

- (IBAction) incrementFido:(id)sender
{
	[self setFido:[self fido] + 1];
}

@end
