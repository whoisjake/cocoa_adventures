//
//  Person.m
//  RaiseMan
//
//  Created by Jacob Good on 8/14/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id) init
{
	[super init];
	expectedRaise = 0.05;
	personName = @"New Person";
	return self;
}

- (id) initWithCoder:(NSCoder *)coder
{
	[super init];
	personName = [[coder decodeObjectForKey:@"personName"] retain];
	expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
	return self;
}

- (void) dealloc
{
	[personName release];
	[super dealloc];
}

- (void) setNilValueForKey:(NSString *) key
{
	if ([key isEqual:@"expectedRaise"]) {
		[self setExpectedRaise:0.0];
	} else {
		[super setNilValueForKey:key];
	}
}

- (void) encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:personName forKey:@"personName"];
	[coder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

@synthesize personName;
@synthesize expectedRaise;

@end
