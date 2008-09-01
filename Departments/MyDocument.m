//
//  MyDocument.m
//  Departments
//
//  Created by Jacob Good on 8/31/08.
//  Copyright Jacob Good 2008 . All rights reserved.
//

#import "MyDocument.h"
#import "DepartmentViewController.h"
#import "EmployeeViewController.h"

@implementation MyDocument

- (void)prepareViewControllers
{
	viewControllers = [[NSMutableArray alloc] init];
	
	ManagingViewController *vc;
	vc = [[DepartmentViewController alloc] init];
	[vc setManagedObjectContext:[self managedObjectContext]];
	[viewControllers addObject:vc];
	[vc release];
	
	vc = [[EmployeeViewController alloc] init];
	[vc setManagedObjectContext:[self managedObjectContext]];
	[viewControllers addObject:vc];
	[vc release];
	
}

- (id)init 
{
    if (![super init]) 
		return nil;
	
	[self prepareViewControllers];
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
	NSMenu *menu = [popUp menu];
	int i, itemCount;
	itemCount = [viewControllers count];
	
	for (i = 0; i < itemCount; i++) {
		NSViewController *vc = [viewControllers objectAtIndex:i];
		
		NSMenuItem *mi = [[NSMenuItem alloc] initWithTitle:[vc title]
													action:@selector(changeViewController:)
											 keyEquivalent:@""];
		[mi setTag:i];
		[menu addItem:mi];
		NSLog(@"added %@ to %@", mi, menu);
		[mi release];
	}
	[self displayViewController:[viewControllers objectAtIndex:0]];
	[popUp selectItemAtIndex:0];
}
- (void)dealloc
{
	[viewControllers release];
	[super dealloc];
}

- (void)displayViewController:(ManagingViewController *)vc
{
	// End editing
	NSWindow *w = [box window];
	BOOL ended = [w makeFirstResponder:w];
	if (!ended) {
		NSBeep();
		return;
	}
	
	NSView *v = [vc view];
	// From here to...
	
	NSSize currentSize = [[box contentView] frame].size;
	
	NSSize newSize = [v frame].size;
	
	float deltaWidth = newSize.width - currentSize.width;
	float deltaHeight = newSize.height - currentSize.height;
	
	NSRect windowFrame = [w frame];
	windowFrame.size.height += deltaHeight;
	windowFrame.origin.y -= deltaHeight;
	windowFrame.size.width += deltaWidth;
	
	[box setContentView:nil];
	[w setFrame:windowFrame
		display:YES
		animate:YES];
	
	// ... here is just for animation
	[box setContentView:v];
	
	// Put the view controller in the responder chain
	[v setNextResponder:vc];
	[vc setNextResponder:box];
}

#pragma mark Action methods

- (IBAction)changeViewController:(id)sender
{
	int i = [sender tag];
	ManagingViewController *vc = [viewControllers objectAtIndex:i];
	[self displayViewController:vc];
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}



@end