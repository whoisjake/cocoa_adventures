//
//  AppController.h
//  ToDoList
//
//  Created by Jacob Good on 8/13/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *inputField;
	IBOutlet NSButton *addButton;
	IBOutlet NSTableView *taskListView;
	NSMutableArray *taskList;
}

- (IBAction) addTask:(id)sender;

@end
