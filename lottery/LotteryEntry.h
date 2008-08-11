//
//  LotteryEntry.h
//  lottery
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LotteryEntry : NSObject {
	NSCalendarDate *entryDate;
	int firstNumber;
	int secondNumber;
}
- (id) initWithEntryDate:(NSCalendarDate *) theDate;
- (void) setEntryDate:(NSCalendarDate *) date;
- (NSCalendarDate *) entryDate;
- (int) firstNumber;
- (int) secondNumber;
@end
