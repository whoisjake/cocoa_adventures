//
//  AppController.m
//  SpeakLine
//
//  Created by Jacob Good on 8/11/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id) init
{
	[super init];
	
	// Logs can help the beginner understand what
	// is happening and hunt down bugs.
	NSLog(@"init");
	
	// Create a new instanceof NSSpeechSynthesizer
	// with the default voice.
	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
	[speechSynth setDelegate:self];
	voiceList = [[NSSpeechSynthesizer availableVoices] retain];
	return self;
}

- (void) awakeFromNib
{
	// When the table view appears on screen, the default voice
	// should be selected
	NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
	int defaultRow = [voiceList indexOfObject:defaultVoice];
	[tableView selectRow:defaultRow byExtendingSelection:NO];
	[tableView scrollRowToVisible:defaultRow];
}

- (IBAction) sayIt:(id)sender
{
	NSString *string = [textField stringValue];
	
	// Is the string zero-length?
	if ([string length] == 0) {
		NSLog(@"string from %@ is of zero-length", textField);
		return;
	}
	
	[speechSynth startSpeakingString:string];
	NSLog(@"Have started to say: %@", string);
	[stopButton setEnabled:YES];
	[startButton setEnabled:NO];
	[tableView setEnabled:NO];
}

- (IBAction) stopIt:(id)sender
{
	NSLog(@"stopping");
	[speechSynth stopSpeaking];
}

- (void) speechSynthesizer:(NSSpeechSynthesizer *)sender
		 didFinishSpeaking:(BOOL) complete
{
	NSLog(@"complete = %d", complete);
	[stopButton setEnabled:NO];
	[startButton setEnabled:YES];
	[tableView setEnabled:YES];
}

- (int) numberOfRowsInTableView:(NSTableView *)tv
{
	return [voiceList count];
}

- (id) tableView:(NSTableView *)tv
	objectValueForTableColumn:(NSTableColumn *)tableColumn
						  row:(int)row
{
	NSString *v = [voiceList objectAtIndex:row];
	NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
	return [dict objectForKey:NSVoiceName];
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
	int row = [tableView selectedRow];
	if (row == -1) {
		return;
	}
	
	NSString *selectedVoice = [voiceList objectAtIndex:row];
	[speechSynth setVoice:selectedVoice];
	NSLog(@"new voice = %@", selectedVoice);
}

- (BOOL) respondsToSelector:(SEL)aSelector
{
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"respondsToSelector:%@",methodName);
	return [super respondsToSelector:aSelector];
}

@end
