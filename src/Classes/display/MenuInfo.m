//
//  MenuInfo.m
//  ShadukiamGame
//
//  Created by yael on 28/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo
    
-(id) initWithType:(NSString*)type andData:(id)data {
        
    self = [super init];
    
    if([type isEqualToString:@"des"]) {
        fond = [SPImage imageWithContentsOfFile:@"info_roue.png"];
    }
    else if([type isEqualToString:@"desResult"]) {
        fond = [SPImage imageWithContentsOfFile:@"info_roueResult.png"];
        
        // djinns
        if([[data objectForKey:@"result1"] isEqualToString:@"djinn"]) {
            SPImage *djinn1 = [SPImage imageWithContentsOfFile:@"info_roueResult_djinn.png"];
            [self addChild:djinn1];
            djinn1.x = 3;
            djinn1.y = 2;
        }
        if([[data objectForKey:@"result2"] isEqualToString:@"djinn"]) {
            SPImage *djinn2 = [SPImage imageWithContentsOfFile:@"info_roueResult_djinn.png"];
            [self addChild:djinn2];
            djinn2.x = 14;
            djinn2.y = 2;
        }
        
        // powers
        if([[data objectForKey:@"result1"] isEqualToString:@"power"]) {
            SPImage *power1 = [SPImage imageWithContentsOfFile:@"info_roueResult_pouvoir.png"];
            [self addChild:power1];
            power1.x = 3;
            power1.y = 2;
        }
        if([[data objectForKey:@"result2"] isEqualToString:@"power"]) {
            SPImage *power2 = [SPImage imageWithContentsOfFile:@"info_roueResult_pouvoir.png"];
            [self addChild:power2];
            power2.x = 14;
            power2.y = 2;
        }
        
        // move
        if([[data objectForKey:@"result1"] isEqualToString:@"move"]) {
            SPTextField *move1 = [SPTextField textFieldWithWidth:14 height:16 text:@"2"];
            move1.fontName = @"Times new Roman";
            move1.fontSize = 16;
            move1.color = 0x000000;
            move1.x = 3;
            move1.y = 2;
            [self addChild:move1];
        }
        if([[data objectForKey:@"result2"] isEqualToString:@"move"]) {
            SPTextField *move2 = [SPTextField textFieldWithWidth:14 height:16 text:@"2"];
            move2.fontName = @"Times new Roman";
            move2.fontSize = 16;
            move2.color = 0x000000;
            move2.x = 14;
            move2.y = 2;
            [self addChild:move2];
        }
    }
    
    [self addChild:fond atIndex:0];
    
    return self;
}

@end
