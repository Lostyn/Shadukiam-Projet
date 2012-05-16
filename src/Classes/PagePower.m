//
//  PagePower.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PagePower.h"

@implementation PagePower

-(void) show {
    [super show];
    
    titre = [[Titre alloc] initWithText:@"Power"];
    titre.x = 120;
    titre.y = -20;
    titre.alpha = 0;
    [self addChild:titre];
 
    bg = [[SPQuad alloc] initWithWidth:[Game stageWidth] height:[Game stageHeight] color:0x000000];
    bg.alpha = 0;
    [self addChild:bg];
    
    [self displayCarte];
    [self anim];
    
    //[self addEventListener:@selector(onNext:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}


- (void) displayCarte{
    carte = [SPSprite sprite];
    carte.y = 40;
    carte.alpha = 0;
    [self addChild:carte];
    
    SPImage *bgCarte = [SPImage imageWithContentsOfFile:@"power_carte.png"];
    bgCarte.x = [Game stageWidth]/2 - bgCarte.width/2 + 19;
    bgCarte.y = [Game stageHeight]/2 - bgCarte.height/2;
    [carte addChild:bgCarte];
    
    nowBtn = [SPImage imageWithContentsOfFile:@"power_now.png"];
    nowBtn.x = bgCarte.x + 100;
    nowBtn.y = bgCarte.y + bgCarte.height - 55;
    [carte addChild:nowBtn];
    
    waitBtn = [SPImage imageWithContentsOfFile:@"power_wait.png"];
    waitBtn.x = nowBtn.x + nowBtn.width;
    waitBtn.y = nowBtn.y;
    [carte addChild:waitBtn];
    
    SPImage *cadreDesc = [SPImage imageWithContentsOfFile:@"power_cadre.png"];
    cadreDesc.x = bgCarte.x + 170;
    cadreDesc.y = bgCarte.y + 90;
    [carte addChild:cadreDesc];
    
    SPImage *power = [SPImage imageWithContentsOfFile:@"power_icon.png"];
    power.x = bgCarte.x + 51;
    power.y = bgCarte.y + 33;
    [carte addChild:power];
    
    [nowBtn addEventListener:@selector(onNow:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void) onNow:(SPTouchEvent*) event{
    [[PageManager getInstance] changePage:@"PageTDB"];
}


- (void) anim{
    SPTween *tTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tTitre setDelay:0.75f];
    [tTitre animateProperty:@"alpha" targetValue:1];
    [tTitre animateProperty:@"y" targetValue:0];
    
    SPTween *tCarte = [SPTween tweenWithTarget:carte time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tCarte setDelay:0.75f];
    [tCarte animateProperty:@"alpha" targetValue:1];
    [tCarte animateProperty:@"y" targetValue:0];
    
    SPTween *tBg = [SPTween tweenWithTarget:bg time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tBg setDelay:0.75f];
    [tBg animateProperty:@"alpha" targetValue:0.5f];
    
    [self.stage.juggler addObject:tTitre];
    [self.stage.juggler addObject:tCarte];
    [self.stage.juggler addObject:tBg];
}

-(void)onNext:(SPTouchEvent*) event{
    [InfosTour setPower:false];
    
    [[PageManager getInstance] changePage:@"PageMove"];        
}

@end
