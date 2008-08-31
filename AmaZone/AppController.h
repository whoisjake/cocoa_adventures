//
//  AppController.h
//  AmaZone
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSProgressIndicator *progress;
	IBOutlet NSTextField *searchField;
	IBOutlet NSTableView *tableView;
	NSXMLDocument *doc;
	NSArray *itemNodes;
}
- (IBAction)fetchBooks:(id)sender;
@end
