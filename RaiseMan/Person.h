//
//  Person.h
//  RaiseMan
//
//  Created by Jacob Good on 8/14/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject <NSCoding> {
	NSString *personName;
	float expectedRaise;
}

@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;

@end
