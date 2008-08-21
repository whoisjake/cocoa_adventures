//
//  CarArrayController.m
//  CarLot
//
//  Created by Jacob Good on 8/20/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "CarArrayController.h"


@implementation CarArrayController

- (id)newObject
{
	id newObject = [super newObject];
	NSDate *now = [NSDate date];
	[newObject setValue:now forKey:@"datePurchased"];
	return newObject;
}

@end
