//
//  EmployeeViewController.m
//  Departments
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "EmployeeViewController.h"

@implementation EmployeeViewController

- (id)init
{
	if (![super initWithNibName:@"EmployeeView" bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Employees"];
	return self;
}

- (void)keyDown:(NSEvent *)e
{
	if ([e keyCode] == 51)
		[employeeController remove:nil];
	else
		[super keyDown:e];
}

@end
