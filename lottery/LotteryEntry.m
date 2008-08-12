//
//  LotteryEntry.m
//  lottery
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "LotteryEntry.h"

@implementation LotteryEntry

- (id) init
{
	return [self initWithEntryDate:[NSCalendarDate calendarDate]];
}

- (id) initWithEntryDate:(NSCalendarDate *) theDate
{
	if (![super init])
		return nil;
	
	NSAssert(theDate != nil, @"Argument must be non-nil");
	entryDate = [theDate retain];
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
	return self;
}

- (void) dealloc
{
	NSLog(@"deallocing %@", self);
	[entryDate release];
	[super dealloc];
}

- (void) setEntryDate:(NSCalendarDate *) date
{
	[date retain];
	[entryDate release];
	entryDate = date;
}

- (NSCalendarDate *) entryDate
{
	return entryDate;
}

- (int) firstNumber
{
	return firstNumber;
}

- (int) secondNumber
{
	return secondNumber;
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"%@ = %d and %d",
			[self entryDate], [self firstNumber], [self secondNumber]];
}

@end
