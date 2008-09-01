//
//  MyDocument.m
//  ZIPspector
//
//  Created by Jacob Good on 9/1/08.
//  Copyright Jacob Good 2008 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
		
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
		
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    //[tableView reloadData];
}


- (BOOL)readFromURL:(NSURL *)absoluteURL 
			 ofType:(NSString *)typeName 
			  error:(NSError **)outError;
{
    NSString *filename = [absoluteURL path];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/zipinfo"];
    
    NSArray *args = [NSArray arrayWithObjects:@"-1", filename, nil];
    [task setArguments:args];
	
    NSPipe *outPipe = [[NSPipe alloc] init];
    [task setStandardOutput:outPipe];
    [outPipe release];
    
    [task launch];
    
    // Read the output
    NSData *data = [[outPipe fileHandleForReading] readDataToEndOfFile];
    [task waitUntilExit];
    int status = [task terminationStatus];
    [task release];
	
    // Check status
    if (status != 0) {
        if ( outError != NULL ) {
            NSDictionary *eDict = [NSDictionary dictionaryWithObject:@"zipinfo exited abnormally" 
                                                              forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:0 userInfo:eDict];
        }
        return NO;
    }
    
    
    // Convert to a string
    NSString *aString = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
	
    [filenames release];
    // Break the string into lines
    filenames = [[aString componentsSeparatedByString:@"\n"] retain];
    
    // Release the string
    [aString release];
    
    // In case of revert
    [tableView reloadData];
    
    return YES;
}

#pragma mark Table Data Source Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    return [filenames count];
}
- (id)tableView:(NSTableView *)tv 
objectValueForTableColumn:(NSTableColumn *)tc 
            row:(NSInteger)row
{
    return [filenames objectAtIndex:row];
}


@end
