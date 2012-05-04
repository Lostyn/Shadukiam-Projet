//
//  PopUpEnigme.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 04/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PopUpEnigme.h"

@implementation PopUpEnigme

-(id) init{
    self = [super init];
    
    [self display];
    
    return self;
}

-(void) display{
    SPQuad *bg = [[SPQuad alloc] initWithWidth:[Game stageWidth] height:[Game stageHeight] color:0x000000];
    bg.alpha = 0.5f;
    SPImage *cadre = [SPImage imageWithContentsOfFile:@"popUpEnigme.png"];
    cadre.x = [Game stageWidth]/2 - cadre.width/2;
    cadre.y = [Game stageHeight]/2 - cadre.height/2;
    SPTextField *title = [SPTextField textFieldWithWidth:200 height:100 text:@"Félicitations !"];
    title.x = 135;
    title.y = 80;
    title.fontName = [Constante getFontDescription];
    title.fontSize = [Constante getSizeDescription] + 14;
    
    SPTextField *text = [SPTextField textFieldWithWidth:200 height:100 text:@"Le mécanisme a été activé avec succès."];
    text.x = title.x;
    text.y = title.y + 50;
    text.fontName = [Constante getFontDescription];
    text.fontSize = [Constante getSizeDescription] + 5;
    
    
    SPImage *ok = [SPImage imageWithContentsOfFile:@"valide.png"];
    ok.x = cadre.x + cadre.width/2 - ok.width/2;
    ok.y = cadre.y + cadre.height - 72;
    
    SPTextField *point = [SPTextField textFieldWithWidth:50 height:20 text:@"+5pts"];
    point.x = ok.x;
    point.y = ok.y - 20;
    point.fontName = [Constante getFontDescription];
    point.fontSize = [Constante getSizeDescription] + 5;
    point.color = 0x5B0404;
    
    [self addChild:bg];
    [self addChild:cadre];
    [self addChild:title];
    [self addChild:text];
    [self addChild:point];
    [self addChild:ok];
    
    [ok addEventListener:@selector(onOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

-(void)onOk:(SPTouchEvent*) event{
    [[PageManager getInstance] changePage:@"PageTDB"];
}
@end
