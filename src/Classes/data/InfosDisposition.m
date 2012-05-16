//
//  InfosDisposition.m
//  ShadukiamGame
//
//  Created by yael on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfosDisposition.h"

@implementation InfosDisposition

static NSMutableArray* elements;

+ (void) genere {
    
    
    
    elements = [NSMutableArray arrayWithObjects:
                @"",
                [NSDictionary dictionaryWithObjectsAndKeys:@"objet", @"type", @"1", @"objetID", nil],
                @"",
                [NSDictionary dictionaryWithObjectsAndKeys:@"objet", @"type", @"2", @"objetID", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"enigme", @"type", @"1", @"enigmeID", nil],
                @"",
                [NSDictionary dictionaryWithObjectsAndKeys:@"enigme", @"type", @"1", @"enigmeID", nil],
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                @"",
                nil];
    
}

+(NSDictionary*) getElementForZone:(int)zoneID {
    
    NSDictionary *element = [elements objectAtIndex:zoneID];
    
    if([element isEqual:@""]) return nil;
    else return element;
    
}

+(void) videZone:(int)zoneID {
    
    [elements replaceObjectAtIndex:zoneID withObject:@""];
    
}

@end
