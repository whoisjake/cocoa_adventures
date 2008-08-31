//
//  PeopleView.m
//  RaiseMan
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "PeopleView.h"
#import "Person.h"

@implementation PeopleView

- (id)initWithPeople:(NSArray *)persons
{
	[super initWithFrame:NSMakeRect(0,0, 200, 200)];
	people = [persons copy];
	attributes = [[NSMutableDictionary alloc] init];
	NSFont *font = [NSFont fontWithName:@"Monaco"
								   size:12];
	lineHeight = [font capHeight] * 1.7;
	
	[attributes setObject:font
				   forKey:NSFontAttributeName];
	return self;
}

- (void)dealloc
{
	[people release];
	[attributes release];
	[super dealloc];
}

#pragma mark Pagination

- (BOOL)knowsPageRange:(NSRangePointer)range
{
	range->location = 1;
	
	NSPrintOperation *po = [NSPrintOperation currentOperation];
	NSPrintInfo *pi = [po printInfo];
	
	// Where can I draw?
	pageRect = [pi imageablePageBounds];
	
	// How many lines will fit on a page?
	linesPerPage = pageRect.size.height / lineHeight;
	
	// How many pages will it take?
	range->length = [people count] / linesPerPage;
	if ([people count] % linesPerPage) {
		range->length = range->length + 1;
	}
	return YES;
}

- (NSRect)rectForPage:(int)i
{
	// Note the current page
	currentPage = (i - 1);
	
	// Return the pageRect
	return pageRect;
}

#pragma mark Drawing

- (BOOL)isFlipped
{
	return YES;
}

- (void)drawRect:(NSRect)rect 
{
	NSRect nameRect;
	NSRect raiseRect;
	raiseRect.size.height = nameRect.size.height = lineHeight;
	nameRect.origin.x = pageRect.origin.x;
	nameRect.size.width = 200.0;
	raiseRect.origin.x = NSMaxX(nameRect);
	raiseRect.size.width = 100.0;
	
	int i;
	for (i = 0; i < linesPerPage; i++) {
		int index = (currentPage * linesPerPage) + i;
		if (index >= [people count]) {
			break;
		}
		Person *p = [people objectAtIndex:index];
		
		raiseRect.origin.y = nameRect.origin.y = pageRect.origin.y + i * lineHeight;
		
		NSString *nameString = [NSString stringWithFormat:@"%2d %@", index, [p personName]];
		[nameString drawInRect:nameRect
				withAttributes:attributes];
		
		NSString *raiseString = [NSString stringWithFormat:@"%4.1f%%", 100.0 * [p expectedRaise]];
		[raiseString drawInRect:raiseRect
				 withAttributes:attributes];
		
		
	}
}

@end
