//
//  ManagingViewController.m
//  Departments
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "ManagingViewController.h"

@implementation ManagingViewController
@synthesize managedObjectContext;

- (void)dealloc
{
	[managedObjectContext release];
	[super dealloc];
}

@end
