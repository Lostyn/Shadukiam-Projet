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
    
    okBtn = [SPImage imageWithContentsOfFile:@"valide.png"];
    [self addChild:okBtn];
    okBtn.x = 420;
    okBtn.y = 270;
    [okBtn addEventListener:@selector(valideDeplacement:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    backgroundZones = [SPImage imageWithContentsOfFile:@"fond_mouvement.png"];
    [self addChild:backgroundZones];
    backgroundZones.x = 60;
    backgroundZones.y = 50;
    
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
    
    NSLog(@"zone actuelle : %d", [InfosJoueur getCurrentCase]);
    
    currentCase = [[Plateau getInstance] getCaseByID:[InfosJoueur getCurrentCase]];
    zonesAccessibles = [[Plateau getInstance] getZonesAccessible:[InfosJoueur getCurrentCase] nbMoves:4];
    NSLog(@"accessibles : %@", zonesAccessibles);
    
    // affichage
    affZones = [[VisuPlateau alloc] initWithZones:zonesAccessibles andWidth:330 andHeight:200];
    affZones.x = 85;
    affZones.y = 80;
    [self addChild:affZones];
    
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
    okBtn.visible = false;
    
    if(pionJoueur == nil) {
        debug.text = @"Pion inexistant";
    } else {
        
        // recuperation des infos de la case actuelle
        currentCase = [[Plateau getInstance] getCaseByCoord:pionJoueur.posx andY:pionJoueur.posy];
        
        if(currentCase != nil) {
            NSString *canGo = @"NO !";
            
            // si la case est accessible
            if([zonesAccessibles containsObject:[currentCase objectForKey:@"zone"]]) {
                canGo = @" accessible";
                okBtn.visible = true;
            }
            
            debug.text = [NSString stringWithFormat:@"x : %d, y : %d, zone : %@ %@",
                          pionJoueur.posx, pionJoueur.posy, [currentCase objectForKey:@"zone"], canGo];
        } else {
            debug.text = @"Aucune case ici";
        }
        
    }
}

// validation du deplacement, stockage case actuelle et apsse a la page suivante
-(void) valideDeplacement: (SPTouchEvent*) event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            [InfosJoueur setCurrentCase:[[currentCase objectForKey:@"zone"] intValue]];
            [[PageManager getInstance] changePage:@"PageObtentionObjet"];
        }
    }
    
}

-(void) finalize {
    
    [self removeEventListener:@selector(touchForDebug:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self removeChild:titre];
    titre = nil;
    [self removeChild:debug];
    debug = nil;
    
    [okBtn removeEventListener:@selector(valideDeplacement:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self removeChild:okBtn];
    okBtn = nil;
    
    [updateTimer invalidate];
    updateTimer = nil;
    
}

@end
