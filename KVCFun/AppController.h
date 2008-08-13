//
//  AppController.h
//  KVCFun
//
//  Created by Jacob Good on 8/13/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	int fido;
}
@property(readwrite, assign) int fido;
- (IBAction) incrementFido:(id)sender;
@end
