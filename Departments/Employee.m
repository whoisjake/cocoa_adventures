// 
//  Employee.m
//  Departments
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "Employee.h"


@implementation Employee 

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
	if ([key isEqual:@"fullName"]) {
		return [NSSet setWithObjects:@"firstName", @"lastName", nil];
	} else {
		return [super keyPathsForValuesAffectingValueForKey:key];
	}
}

@dynamic firstName;
@dynamic lastName;
@dynamic department;

- (NSString *)fullName
{
	NSString *first = [self firstName];
	NSString *last = [self lastName];
	if (!first) {
		return last;
	}
	if (!last) {
		return first;
	}
	return [NSString stringWithFormat:@"%@ %@", first, last];
}

@end
