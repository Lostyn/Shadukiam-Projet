//
//  PageEnigme.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 04/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PageEnigme.h"

@implementation PageEnigme

-(void) show{
    [super show];
    
    Class enigmeClass = NSClassFromString( @"Enigme001" );
    enigme = [[enigmeClass alloc] init];
    
    titre = [[Titre alloc] initWithText:[enigme getTitre]];
    titre.x = 120;
    titre.y = 3;
    
    [self addChild:titre];
    [self addChild:enigme];
    
    [enigme execute]; 
    
    
    //back
    backBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    backBtn.x = 42;
    backBtn.y = 5;
    [self addChild:backBtn];
    
    [backBtn addEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    //anim
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:3];
    
    enigme.alpha = 0;
    enigme.y = 40;
    SPTween* tweenEnigme = [SPTween tweenWithTarget:enigme time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenEnigme setDelay:0.5f];
    [tweenEnigme animateProperty:@"alpha" targetValue:1];
    [tweenEnigme animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenTitre];
    [self.stage.juggler addObject:tweenEnigme];
}

-(void) onTouchBack:(SPTouchEvent*) event{
    targetBack = @"PageTDB";
    [self animQuit];
}

-(void) animQuit{
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:0];
    [tweenTitre animateProperty:@"y" targetValue:-20];
    
    SPTween* tweenEnigme = [SPTween tweenWithTarget:enigme time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenEnigme animateProperty:@"alpha" targetValue:0];
    [tweenEnigme animateProperty:@"y" targetValue:40];
    
    [self.stage.juggler addObject:tweenEnigme];
    [self.stage.juggler addObject:tweenTitre];[NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(goNextPage:) userInfo:nil repeats:NO];
}

-(void) goNextPage:(NSTimer*) timer {
    
    [[PageManager getInstance] changePage:targetBack];
    
    //kill the timer
    [timer invalidate];
    timer = nil;
}

-(void)enigmeResult:(NSString *)key{
    [enigme testResult:key];
}

-(void)enigmeSuccess:(NSString *)key{
    [enigme enigmeSuccess:key];
}

@end
