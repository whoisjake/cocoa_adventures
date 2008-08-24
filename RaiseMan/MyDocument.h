//
//  MyDocument.h
//  RaiseMan
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
	IBOutlet NSArrayController *employeeController;
}

- (IBAction) createEmployee:(id)sender;
- (IBAction) removeEmployee:(id)sender;
- (void) setEmployees:(NSMutableArray *)a;
- (void) removeObjectFromEmployeesAtIndex:(int)index;
- (void) insertObject:(Person *)p inEmployeesAtIndex:(int)index;
- (void) startObservingPerson:(Person *)p;
- (void) stopObservingPerson:(Person *)p;

@end
