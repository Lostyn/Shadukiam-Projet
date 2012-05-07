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
    
    contenu = [SPSprite sprite];
    [self addChild:contenu];
    
    titre = [[Titre alloc] initWithText:@"DEPLACEMENT"];
    titre.x = 100;
    titre.y = 0;
    [self addChild:titre];
    
    compteur = [SPSprite sprite];
    compteur.x = 370;
    compteur.y = 5;
    [self addChild:compteur];
    
    
    okBtn = [SPImage imageWithContentsOfFile:@"valide.png"];
    okBtn.x = 380;
    okBtn.y = 235;
    [okBtn addEventListener:@selector(valideDeplacement:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    backgroundZones = [SPImage imageWithContentsOfFile:@"fond_mouvement.png"];
    [contenu addChild:backgroundZones];
    backgroundZones.x = 40;
    backgroundZones.y = 30;
    
    
    
    
    SPImage *compteurBkg = [SPImage imageWithContentsOfFile:@"compteur_mvt.png"];
    [compteur addChild:compteurBkg];
    
    SPTextField *compteurTxt = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d", [InfosTour getMouvement]]];
    compteurTxt.width = compteur.width;
    compteurTxt.height = compteur.height;
    compteurTxt.fontName = [Constante getFontDescription];
    compteurTxt.fontSize = 16;
    compteurTxt.color = 0xFFFFFF;
    [compteur addChild:compteurTxt];
    
    // debug
    debug = [SPTextField textFieldWithWidth:400 height:20 text:@""];
    [self addChild:debug];
    debug.x = 40;
    debug.y = 300;
    debug.fontSize = 16;
    debug.color = 0x000000;
    
    [self addEventListener:@selector(touchForDebug:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // recuperation des cases accessibles pour le deplacement
    
    //NSLog(@"zone actuelle : %d", [InfosJoueur getCurrentCase]);
    
    currentCase = [[Plateau getInstance] getCaseByID:[InfosJoueur getCurrentCase]];
    currentZoneID = [[currentCase objectForKey:@"zone"] intValue];
    zonesAccessibles = [[Plateau getInstance] getZonesAccessible:[InfosJoueur getCurrentCase] nbMoves:[InfosTour getMouvement]];
    //NSLog(@"accessibles : %@", zonesAccessibles);
    
    // affichage
    affZones = [[VisuPlateau alloc] initWithZones:zonesAccessibles andWidth:310 andHeight:200];
    affZones.x = 95;
    affZones.y = 80;
    [contenu addChild:affZones];
    [affZones setZoneActive:currentZoneID];
    
    
    [contenu addChild:okBtn];
    
    
    // anims
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:1.25];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenTitre];
    
    compteur.alpha = 0;
    compteur.y = -20;
    SPTween* tweenConpteur = [SPTween tweenWithTarget:compteur time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenConpteur setDelay:1.25];
    [tweenConpteur animateProperty:@"alpha" targetValue:1];
    [tweenConpteur animateProperty:@"y" targetValue:5];
    
    [self.stage.juggler addObject:tweenConpteur];
    
    contenu.alpha = 0;
    contenu.y = 10;
    SPTween* tweenContenu = [SPTween tweenWithTarget:contenu time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenContenu setDelay:1.5];
    [tweenContenu animateProperty:@"alpha" targetValue:1];
    [tweenContenu animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenContenu];
    
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
        okBtn.visible = false;
    } else {
        
        // recuperation des infos de la case actuelle
        currentCase = [[Plateau getInstance] getCaseByCoord:pionJoueur.posx andY:pionJoueur.posy];
        
        if(currentCase != nil) {
            NSString *canGo = @"NO !";
            
            int zoneNum = [[currentCase objectForKey:@"zone"] intValue];
            
            // si on a changé de zone, sinon pas la peine de changer
            if(zoneNum != currentZoneID) {
                currentZoneID = zoneNum;
                
                // si la case est accessible
                if([zonesAccessibles containsObject:[currentCase objectForKey:@"zone"]]) {
                    canGo = @" accessible";
                    okBtn.visible = true;
                    [affZones setZoneActive:zoneNum];
                } else {
                    okBtn.visible = false;
                    [affZones setZoneActive:-1];
                }
            
                debug.text = [NSString stringWithFormat:@"x : %d, y : %d, zone : %@ %@",
                          pionJoueur.posx, pionJoueur.posy, [currentCase objectForKey:@"zone"], canGo];
            }
        } else {
            debug.text = @"Aucune case ici";
            okBtn.visible = false;
            [affZones setZoneActive:-1];
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
            if(currentCase != nil) {
                
                if([zonesAccessibles containsObject:[currentCase objectForKey:@"zone"]]) {
                    [InfosJoueur setCurrentCase:[[currentCase objectForKey:@"zone"] intValue]];
                    [self animQuit];
                }
                
            }
        }
    }
    
}

-(void) animQuit {
    
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:0];
    [tweenTitre animateProperty:@"y" targetValue:-20];
    [self.stage.juggler addObject:tweenTitre];
    
    SPTween* tweenConpteur = [SPTween tweenWithTarget:compteur time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenConpteur animateProperty:@"alpha" targetValue:0];
    [tweenConpteur animateProperty:@"y" targetValue:-20];
    [self.stage.juggler addObject:tweenConpteur];
    
    SPTween* tweenContenu = [SPTween tweenWithTarget:contenu time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenContenu animateProperty:@"alpha" targetValue:0];
    [tweenContenu animateProperty:@"y" targetValue:10];
    [self.stage.juggler addObject:tweenContenu];
    
    [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(goNextPage:) userInfo:nil repeats:NO];
    
}

-(void) goNextPage:(NSTimer*) timer {
    
    [[PageManager getInstance] changePage:@"PageObtentionObjet"];
    
    //kill the timer
    [timer invalidate];
    timer = nil;
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
