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

- (id)init 
{
    self = [super init];
    if (self != nil) {
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
    return self;
}

- (void)dealloc
{
	[viewControllers release];
	[super dealloc];
}

- (void)displayViewController:(ManagingViewController *)vc
{
	// Try to end editing
	NSWindow *w = [box window];
	BOOL ended = [w makeFirstResponder:w];
	if (!ended) {
		NSBeep();
		return;
	}
	
	// put view in box
	NSView *v = [vc view];
	
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
	
	[box setContentView:v];
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    
	NSMenu *menu = [popUp menu];
	int i, itemCount;
	itemCount = [viewControllers count];
	
	for (i = 0; i < itemCount; i++)
	{
		NSViewController *vc = [viewControllers objectAtIndex:i];
		NSMenuItem *mi = [[NSMenuItem alloc] initWithTitle:[vc title] action:@selector(changeViewController:) keyEquivalent:@""];
		[mi setTag:i];
		[menu addItem:mi];
		[mi release];
	}
	
	// Show first controller
	[self displayViewController:[viewControllers objectAtIndex:0]];
	[popUp selectItemAtIndex:0];
}

- (IBAction)changeViewController:(id)sender
{
	int i = [sender tag];
	ManagingViewController *vc = [viewControllers objectAtIndex:i];
	[self displayViewController:vc];
}

@end
