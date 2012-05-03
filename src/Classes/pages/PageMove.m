//
//  PageMove.m
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageMove.h"

@implementation PageMove

- (void) show {
    
    [super show];
    
    titre = [[Titre alloc] initWithText:@"DEPLACEMENT"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 0;
    
    // debug
    debug = [SPTextField textFieldWithWidth:400 height:20 text:@""];
    [self addChild:debug];
    debug.x = 40;
    debug.y = 300;
    debug.fontSize = 16;
    debug.color = 0x000000;
    
    [self addEventListener:@selector(touchForDebug:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // anims
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenTitre];
    
    // recuperation des cases accessibles pour le deplacement
    
    currentCase = [[Plateau getInstance] getCaseByID:[InfosJoueur getCurrentCase]];
    casesAccessibles = [[Plateau getInstance] getZonesAccessible:[InfosJoueur getCurrentCase] nbMoves:3];
    NSLog(@"accessibles : %@", casesAccessibles);
    
    [[Plateau getInstance] getCaseByCoord:450 andY:5];
    
    // init timer update
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0/10.0) target:self selector:@selector(updatePosPion) userInfo:nil repeats:YES];
    
}

-(void) touchForDebug:(SPTouchEvent*) event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if([touches count] > 0) {
        SPTouch *touch = [touches objectAtIndex:0];
    
        SPPoint *touchPos = [touch locationInSpace:self];
        
        PionInfos *pion = [[PionInfos alloc] init];
        pion.pid = [InfosJoueur getMyPerso];
        pion.posx = touchPos.x;
        pion.posy = touchPos.y * 2;
        
        NSMutableArray *pions = [NSMutableArray array];
        for(int i = 0; i < 10; i++) {
            [pions addObject:[[PionInfos alloc] init]];
        }
        [pions insertObject:pion atIndex:pion.pid];
        [[EpawnData getInstance] setPions:pions];
    }
    
}

-(void) updatePosPion {
    // position du pion du joueur
    PionInfos *pionJoueur = [[EpawnData getInstance] getPionByID:[InfosJoueur getMyPerso]];
    
    if(pionJoueur == nil) {
        debug.text = @"Pion inexistant";
    } else {
        
        currentCase = [[Plateau getInstance] getCaseByCoord:pionJoueur.posx andY:pionJoueur.posy];
        
        if(currentCase != nil) {
            debug.text = [NSString stringWithFormat:@"x : %d, y : %d, zone : %@",
                          pionJoueur.posx, pionJoueur.posy, [currentCase objectForKey:@"zone"]];
        } else {
            debug.text = @"Aucune case ici";
        }
        
    }
}

-(void) finalize {
    
    [self removeEventListener:@selector(touchForDebug:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self removeChild:titre];
    titre = nil;
    [self removeChild:debug];
    debug = nil;
    
    [updateTimer invalidate];
    updateTimer = nil;
    
}

@end
