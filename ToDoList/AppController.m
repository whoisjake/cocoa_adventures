//
//  AppController.m
//  ToDoList
//
//  Created by Jacob Good on 8/13/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id) init
{
	[super init];
	taskList = [[NSMutableArray alloc] init];
	return self;
}

- (int) numberOfRowsInTableView:(NSTableView *)tv
{
	return [taskList count];
}

- (id) tableView:(NSTableView *)tv
	objectValueForTableColumn:(NSTableColumn *)tableColumn
	row:(int) row
{
	return [taskList objectAtIndex:row];
}

- (IBAction) addTask:(id)sender
{
	NSString *task = [inputField stringValue];
	
	if ([task length] == 0) {
		NSLog(@"Can't add a blank task.");
		return;
	}
	
	[taskList addObject:task];
	[inputField setStringValue:@""];
	[taskListView reloadData];
	NSLog(@"Adding Task '%@'", task);
}
	 
- (void)tableView:(NSTableView *)tableView 
   setObjectValue:(id)object 
   forTableColumn:(NSTableColumn *)tableColumn 
              row:(NSInteger)row
{
    [taskList replaceObjectAtIndex:row
                     withObject:object];
}

@end
