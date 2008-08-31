//
//  MyDocument.h
//  Departments
//
//  Created by Jacob Good on 8/31/08.
//  Copyright Jacob Good 2008 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ManagingViewController;
@interface MyDocument : NSPersistentDocument {
	IBOutlet NSBox *box;
	IBOutlet NSPopUpButton *popUp;
	NSMutableArray *viewControllers;
}
- (IBAction)changeViewController:(id)sender;
- (void)displayViewController:(ManagingViewController *)vc;
@end
