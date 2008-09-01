//
//  MyDocument.h
//  ZIPspector
//
//  Created by Jacob Good on 9/1/08.
//  Copyright Jacob Good 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	IBOutlet NSTableView *tableView;
	NSArray *filenames;
}
@end
