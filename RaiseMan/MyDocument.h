//
//  MyDocument.h
//  RaiseMan
//
//  Created by Jacob Good on 8/14/08.
//  Copyright Jacob Good 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
}

- (void) setEmployees:(NSMutableArray *)a;

@end
