//
//  PagePlay.m
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PagePlay.h"

@implementation PagePlay

- (void) show {
    
    [super show];
    [Game hideLogo];
    
    SPImage *bg = [SPImage imageWithContentsOfFile:@"bg_start.png"];
    [self addChild:bg];
    
    logoBlack = [SPImage imageWithContentsOfFile:@"logo_default.png"];
    logoBlack.x = 117;
    logoBlack.y = 20;
    [self addChild:logoBlack];
    
    logoWhite = [SPImage imageWithContentsOfFile:@"logo_default_white.png"];
    logoWhite.x = 117;
    logoWhite.y = 20;
    logoWhite.alpha = 0;
    [self addChild:logoWhite];
    
    // bouton play
    playBtn = [SPImage imageWithContentsOfFile:@"btn_start.png"];
    playBtn.x = 116;
    playBtn.y = 122;
    
    // texte d'info
    textInfos = [SPTextField textFieldWithWidth:300 height:20 text:@""];
    textInfos.fontName = @"Times new Roman";
    textInfos.color = 0x000000;
    textInfos.fontSize = 16;
    textInfos.x = 90;
    //textInfos.y = 140;
    [self addChild:textInfos];
    
    // init dialog
    connected = NO;
    [[Dialog getInstance] connect];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(checkConnection:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(anim:) userInfo:nil repeats:NO];
}


-(void)anim:(NSTimer*) timer{
    SPTween* tweenBlack = [SPTween tweenWithTarget:logoBlack time:2.0f transition:SP_TRANSITION_EASE_OUT];
    [tweenBlack setDelay:0.75f];
    [tweenBlack animateProperty:@"alpha" targetValue:0];
    
    SPTween* tweenWhite = [SPTween tweenWithTarget:logoWhite time:2.0f transition:SP_TRANSITION_EASE_OUT];
    [tweenWhite setDelay:0.75f];
    [tweenWhite animateProperty:@"alpha" targetValue:1];
    
    [self.stage.juggler addObject:tweenBlack];
    [self.stage.juggler addObject:tweenWhite];
    
}

-(void)animQuit{
    [self removeChild:playBtn];
    [self removeChild:textInfos];
    
    SPTween* white = [SPTween tweenWithTarget:logoWhite time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [white animateProperty:@"alpha" targetValue:0];
    
    [self.stage.juggler addObject:white];
}




// si on est pas connecté quelques secondes apres le lancement de l'appli, creation du serveur
-(void)checkConnection:(NSTimer*)timer {
    
    if(!connected) {
        [[Dialog getInstance] createServer];
    }
    
    //kill the timer
    [timer invalidate];
    timer = nil;
    
}

// touch play, lancement partie
-(void)onTouchPlay: (SPTouchEvent*) event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            [playBtn removeEventListener:@selector(onTouchPlay:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            playBtn.visible = false;
    
            [[Dialog getInstance] sendGameInfoToClients];
        }
    }
}

-(void) finalize {
    [self removeChild:playBtn];
    playBtn = nil;
    
    [self removeChild:textInfos];
    textInfos = nil;
    
}

#pragma mark Dialog Delegate


// connecté au serveur, affichage bouton jouer
- (void) connectedToServ {
    connected = YES;
    
    if([Dialog getInstance].isServer) {
        [self addChild:playBtn];
        [playBtn addEventListener:@selector(onTouchPlay:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        textInfos.text = @"ATTENTE DE JOUEURS";
    } else {
        textInfos.text = @"ATTENTE DU LANCEMENT";
    }
    
}

// jeu lancé, selection perso
-(void) gameLaunched {
    [self animQuit];
    
    [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(gotoGame:) userInfo:nil repeats:NO];
}

-(void)gotoGame:(NSTimer *)timer{
    [[PageManager getInstance] changePage:@"PageSelectPerso"];
}

// client connecté
- (void) clientConnected:(Connection*)connection {
    textInfos.text = [NSString stringWithFormat:@"%d joueur(s) connecté", [[Dialog getInstance].clientsID count]];
}

@end
