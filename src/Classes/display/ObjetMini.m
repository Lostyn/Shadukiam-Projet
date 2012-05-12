//
//  ObjetMini.m
//  ShadukiamGame
//
//  Created by yael on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjetMini.h"

@implementation ObjetMini

@synthesize ID;

-(id) initWithObjetID:(int) objetID andName:(NSString*) name {
    
    self = [super init];
    
    ID = objetID;
    
    background = [SPImage imageWithContentsOfFile:@"btn_objet.png"];
    [self addChild:background];
    
    icone = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"objet_mini_image_%d.png", ID]];
    [self addChild:icone];
    icone.x = (background.width - icone.width) / 2;
    icone.y = (background.height - icone.height) / 2;
    
    nomBkg = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"btn_objetnom_%d.png", [InfosJoueur getMyPerso]]];
    [self addChild:nomBkg];
    nomBkg.x = -5;
    nomBkg.y = 70;
    
    nomTxt = [SPTextField textFieldWithWidth:nomBkg.width height:nomBkg.height text:name];
    nomTxt.fontName = @"Times New Roman";
    nomTxt.color = 0xFFFFFF;
    nomTxt.fontSize = 12;
    nomTxt.x = nomBkg.x;
    nomTxt.y = nomBkg.y;
    [self addChild:nomTxt];

    
    return self;
    
}

-(void) finalize {
    
    [self removeChild:background];
    background = nil;
    
    [self removeChild:icone];
    icone = nil;
    
}

@end
