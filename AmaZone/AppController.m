//
//  AppController.m
//  AmaZone
//
//  Created by Jacob Good on 8/31/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"

// Hillegass AWS Key, not mine :)
#define AWS_ID @"1CKE6MZ6S27EFQ458402"

NSString *stringForKind(NSXMLNodeKind k) {
    switch (k) {
        case NSXMLDocumentKind:
            return @"Document";
        case NSXMLElementKind:
            return @"Element";
        case NSXMLTextKind:
            return @"Text";
    }
    return [NSString stringWithFormat:@"%d", k];
}

void ShowTree(NSXMLNode *node, int level)
{
    NSXMLNodeKind kind = [node kind];
    NSString *kindString = stringForKind(kind);
    int i;
    for (i = 0; i < level; i++) {
        fprintf(stderr, "  ");
    }
    NSString *output;
    if (kind == NSXMLTextKind) {
        output = [NSString stringWithFormat:@"%@: %@", 
				  kindString, [node stringValue]];
    } else {
        output = [NSString stringWithFormat:@"%@: %@", 
				  kindString, [node name]];
    }
    const char *outC = [output cStringUsingEncoding:NSUTF8StringEncoding];
    fprintf(stderr, "%s\n", outC);
    NSArray *children = [node children];
    for (i = 0; i < [children count]; i++) {
        ShowTree([children objectAtIndex:i], level+1);
    }
}

@implementation AppController

- (void)awakeFromNib
{
    [tableView setDoubleAction:@selector(openItem:)];
    [tableView setTarget:self];
}

#pragma mark Action methods

- (void)fetchBooks:(id)sender
{
    // Show the user that something is going on
    [progress startAnimation:nil];
    
    // Put together the request
    // See http://www.amazon.com/gp/aws/landing.html
    
    // Get the string and percent-escape for insertion into URL
	NSString *searchString = [[searchField stringValue] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"searchString = %@", searchString);
    // Create the URL
    NSString *urlString = [NSString stringWithFormat:
						   @"http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemSearch&SubscriptionId=%@&SearchIndex=Books&Keywords=%@",
						   AWS_ID, searchString];
	
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url 
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];  
    
    // Fetch the XML response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    if (!urlData) {
        NSRunAlertPanel(@"Error loading", @"%@", nil, nil, nil, [error localizedDescription]);
        return;
    }
    
    // Parse the XML response
	[doc release];
	doc = [[NSXMLDocument alloc] initWithData:urlData
                                      options:0 
                                        error:&error];
	NSLog(@"doc = %@", doc);
    
	
    //ShowTree(doc, 0);
    
    
	if (!doc) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	[itemNodes release];
	itemNodes = [[doc nodesForXPath:@"ItemSearchResponse/Items/Item" error:&error] retain];
	if (!itemNodes) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
    // Update the interface
    [tableView reloadData];
    [progress stopAnimation:nil];
}

- (NSString *)stringForPath:(NSString *)xp ofNode:(NSXMLNode *)n
{
	NSError *error;
	NSArray *nodes = [n nodesForXPath:xp error:&error];
	if (!nodes) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return nil;
	}
	if ([nodes count] == 0) {
		return nil;
	}
	else return [[nodes objectAtIndex:0] stringValue];
}

- (void)openItem:(id)sender
{
    int row = [tableView clickedRow];
    if (row == -1) {
        return;
    }
	
    NSXMLNode *clickedItem = [itemNodes objectAtIndex:row];
	NSString *urlString = [self stringForPath:@"DetailPageURL"
									   ofNode:clickedItem];
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

#pragma mark TableView data source methods


- (int)numberOfRowsInTableView:(NSTableView *)tv
{
    return [itemNodes count];
}

- (id)tableView:(NSTableView *)tv 
objectValueForTableColumn:(NSTableColumn *)tableColumn 
            row:(int)row
{
	NSXMLNode *itemNode = [itemNodes objectAtIndex:row];
	NSString *xPath = [tableColumn identifier];
	
	return [self stringForPath:xPath ofNode:itemNode];
}

@end
