//
//  DefaultDjinn.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "DefaultDjinn.h"

@implementation DefaultDjinn

-(id) init{
    self = [super init];
    
    carte = [SPImage imageWithContentsOfFile:@"ficheperso_bkg_7.png"];
    carte.x = [Game stageWidth]/2 - carte.width/2;
    carte.y = [Game stageHeight]/2 -carte.height/2;
    [self addChild:carte];
    
    return self;
}

-(void) execute {
}

-(void) displayDescription:(NSString *)sDescription {
    
    description = [SPTextField textFieldWithWidth:220 height:150 text:sDescription];
    description.x = carte.x + 100;
    description.y = carte.y + 50;
    description.fontName = [Constante getFontDescription];
    description.fontSize = [Constante getSizeDescription];
    description.color = [Constante getColorDescription];
    [self addChild:description];
}

@end
