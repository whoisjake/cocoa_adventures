//
//  FirstLetter.m
//  TypingTutor
//
//  Created by Jacob Good on 8/27/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "FirstLetter.h"


@implementation NSString (FirstLetter)

- (NSString *)BNR_firstLetter
{
	if ([self length] < 2) {
		return self;
	}
	
	NSRange r;
	r.location = 0;
	r.length = 1;
	return [self substringWithRange:r];
}

@end
