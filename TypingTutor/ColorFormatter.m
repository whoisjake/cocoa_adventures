//
//  ColorFormatter.m
//  TypingTutor
//
//  Created by Aaron Hillegass on 10/23/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "ColorFormatter.h"

@interface ColorFormatter ()

- (NSString *)firstColorKeyForPartialString:(NSString *)string;

@end

@implementation ColorFormatter

- (id)init
{
	[super init];
	colorList = [[NSColorList colorListNamed:@"Apple"] retain];
	return self;
}
- (void)dealloc
{
	[colorList release];
	[super dealloc];
}

- (NSString *)firstColorKeyForPartialString:(NSString *)string
{
	// Is the string zero-length?
	if ([string length] == 0) {
		return nil;
	}
	
	// Check the keys for matches?
	for (NSString *key in [colorList allKeys]) {
		NSRange whereFound = [key rangeOfString:string
										options:NSCaseInsensitiveSearch];
		if ((whereFound.location == 0) && (whereFound.length > 0)) {
			return key;
		}
	}
	
	// If there is no match
	return nil;
}
- (NSString *)stringForObjectValue:(id)obj
{
	
	if (![obj isKindOfClass:[NSColor class]]) {
		return nil;
	}
	
	// Convert to an RGB color
	NSColor *color = [obj colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	CGFloat red, green, blue;
	[color getRed:&red
			green:&green
			 blue:&blue
			alpha:NULL];
	
	// Intialize distance to something large
	float minDistance = 3.0;
	NSString *closestKey;
	
	// Find the closest color
	for (NSString *key in [colorList allKeys]) {
		NSColor *c = [colorList colorWithKey:key];
		CGFloat r, g, b;
		[c getRed:&r
			green:&g
			 blue:&b
			alpha:NULL];
		
		// How far apart are the colors?
		float distance = pow(red - r, 2) + pow(green - g, 2) + pow (blue - b, 2);
		
		// Is this the closest yet?
		if (distance < minDistance) {
			minDistance = distance;
			closestKey = key;
		}
	}
	return closestKey;
}

- (BOOL)getObjectValue:(id *)obj
			 forString:(NSString *)string
	  errorDescription:(NSString **)errorString
{
	NSString *matchingKey = [self firstColorKeyForPartialString:string];
	
	// Is it found?
	if (matchingKey) {
		*obj = [colorList colorWithKey:matchingKey];
		return YES;
	} else {
		if (errorString) {
			*errorString = [NSString stringWithFormat:@"'%@' is not a color", string];
		}
		return NO;
	}
}

- (BOOL)isPartialStringValid:(NSString **)partial 
	   proposedSelectedRange:(NSRangePointer)newRange 
			  originalString:(NSString *)beforeString 
	   originalSelectedRange:(NSRange)beforeRange 
			errorDescription:(NSString **)error
{
	// Zero-length strings are fine
	if ([*partial length] == 0) {
		return YES;
	}
	
	NSString *match = [self firstColorKeyForPartialString:*partial];
	
	// Not a color?
	if (!match) {
		return NO;
	}
	
	// Is 'partial' a complete color name?
	if ([match isEqual:*partial]) {
		return YES;
	} 
	
	// If the beginning of the selection didn't move,
	// this was a delete.
	if (beforeRange.location == newRange->location) {
		return YES;
	}
	
	// Select the stuff that you added to 'partial'
	newRange->location = [*partial length];
	newRange->length = [match length] - newRange->location;
	*partial = match;
	return NO;
}

- (NSAttributedString *)attributedStringForObjectValue:(id)obj 
								 withDefaultAttributes:(NSDictionary *)attrs
{
	NSMutableDictionary *md = [attrs mutableCopy];
	NSString *match = [self stringForObjectValue:obj];
	if (match) {
		[md setObject:obj forKey:NSForegroundColorAttributeName];
	} else {
		match = @"";
	}
	NSAttributedString *attString = [[NSAttributedString alloc] initWithString:match
																	attributes:md];
	[attString autorelease];
	return attString;
}

@end
