//
//  DepartmentViewController.m
//  Departments
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "DepartmentViewController.h"


@implementation DepartmentViewController

- (id)init
{
	if (![super initWithNibName:@"DepartmentView" bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Departments"];
	return self;
}

@end
