// 
//  Department.m
//  Departments
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "Department.h"
#import "Employee.h"

@implementation Department 

@dynamic deptName;
@dynamic manager;
@dynamic employees;


- (void)addEmployeesObject:(Employee *)value
{
	NSLog(@"Dept %@ adding employee %@", [self deptName], [value fullName]);
	
	NSSet *s = [NSSet setWithObject:value];
	[self willChangeValueForKey:@"employees"
				withSetMutation:NSKeyValueUnionSetMutation
				   usingObjects:s];
	[[self employees] addObject:value];
	
	[self didChangeValueForKey:@"employees"
			   withSetMutation:NSKeyValueUnionSetMutation
				  usingObjects:s];
}

- (void)removeEmployeesObject:(Employee *)value
{
	NSLog(@"Dept %@ removing employee %@", [self deptName], [value fullName]);
	
	Employee *manager = [self manager];
	if (manager == value) {
		[self setManager:nil];
	}
	NSSet *s = [NSSet setWithObject:value];
	[self willChangeValueForKey:@"employees"
				withSetMutation:NSKeyValueMinusSetMutation
				   usingObjects:s];
	[[self employees] removeObject:value];
	[self didChangeValueForKey:@"employees"
			   withSetMutation:NSKeyValueMinusSetMutation
				  usingObjects:s];
}
@end
