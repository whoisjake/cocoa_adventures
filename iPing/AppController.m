//
//  AppController.m
//  iPing
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"


@implementation AppController


- (IBAction)startStopPing:(id)sender
{
    if (task) {
        [task interrupt];
    } else {
        task = [[NSTask alloc] init];
        [task setLaunchPath:@"/sbin/ping"];
        NSArray *args = [NSArray arrayWithObjects:@"-c10",[hostField stringValue], nil];
        [task setArguments:args];
        
        // Release the old pipe
        [pipe release];
        pipe = [[NSPipe alloc] init];
        
        [task setStandardOutput:pipe];
        
        NSFileHandle *fh = [pipe fileHandleForReading];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc removeObserver:self];
        [nc addObserver:self
               selector:@selector(dataReady:)
                   name:NSFileHandleReadCompletionNotification
                 object:fh];
        [nc addObserver:self
               selector:@selector(taskTerminated:)
                   name:NSTaskDidTerminateNotification
                 object:task];
        [task launch];
        [outputView setString:@""];
        
        [fh readInBackgroundAndNotify];
    }
}

- (void)appendData:(NSData *)d
{
    NSString *s = [[NSString alloc] initWithData:d
                                        encoding:NSUTF8StringEncoding];
    
    NSTextStorage *ts = [outputView textStorage];
    NSRange end;
    end.location = [ts length];
    end.length = 0;
    [ts replaceCharactersInRange:end
                      withString:s];
    [s release];
}

- (void)dataReady:(NSNotification *)note
{
    NSData *data = [[note userInfo] valueForKey:NSFileHandleNotificationDataItem];
    
    NSLog(@"dataReady:%d", [data length]);
    
    if ([data length]) {
        [self appendData:data];
    } 
    if (task) 
        [[pipe fileHandleForReading] readInBackgroundAndNotify];
}

- (void)taskTerminated:(NSNotification *)note
{
    NSLog(@"taskTerminated:");
    
    [task release];
    task = nil;
    
    [startButton setState:0];
    
}
@end

