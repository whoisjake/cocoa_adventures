//
//  PeopleView.h
//  RaiseMan
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PeopleView : NSView {
	NSArray *people;
	NSMutableDictionary *attributes;
	float lineHeight;
	NSRect pageRect;
	int linesPerPage;
	int currentPage;
}
- (id)initWithPeople:(NSArray *)array;
@end
