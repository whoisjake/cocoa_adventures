//
//  AppController.m
//  MakeADelegate
//
//  Created by Jacob Good on 8/13/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"

@implementation AppController

- (NSSize) windowWillResize:(NSWindow *)sender
					 toSize:(NSSize)frameSize
{
	NSSize newSize;
	newSize.width = frameSize.width;
	newSize.height = newSize.width * 2;
	NSLog(@"old size %f x %f... new size %f x %f", frameSize.height, frameSize.width, newSize.height, newSize.width);
	return newSize;
}

@end
