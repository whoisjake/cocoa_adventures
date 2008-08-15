//
//  MyDocument.h
//  RaiseManChallenge
//
//  Created by Jacob Good on 8/14/08.
//  Copyright Jacob Good 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
}

- (IBAction) createEmployee:(id) sender;
- (IBAction) deleteSelectedEmployees:(id) sender;

@end
