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
    
    carte = [SPImage imageWithContentsOfFile:@"fond_popup.png"];
    carte.x = [Game stageWidth]/2 - carte.width/2 + 19;
    carte.y = [Game stageHeight]/2 -carte.height/2;
    [self addChild:carte];
    
    return self;
}

-(void) execute {
    self.alpha = 0;
    SPTween* tween = [SPTween tweenWithTarget:self time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tween setDelay:0.5f];
    [tween animateProperty:@"alpha" targetValue:1.0f];
    
    [self.stage.juggler addObject:tween];
}

-(void) displayDescription:(NSString*) sTitle withDesc:(NSString*)sDescription {
    bg_desc = [SPImage imageWithContentsOfFile:@"fond_popup_txt2.png"];
    bg_desc.x = 215;
    bg_desc.y = 55;
    [self addChild:bg_desc];
    
    title = [SPTextField textFieldWithWidth:200 height:50 text:sTitle];
    title.x = 235;
    title.y = 90;
    title.vAlign = SPVAlignTop;
    title.fontName = [Constante getFontDescription];
    title.fontSize = [Constante getSizeDescription] + 4;
    [self addChild:title];
    
    description = [SPTextField textFieldWithWidth:200 height:150 text:sDescription];
    description.x = 235;
    description.y = 113;
    description.vAlign = SPVAlignTop;
    description.fontName = [Constante getFontDescription];
    description.fontSize = [Constante getSizeDescription];
    [self addChild:description];
}

@end
