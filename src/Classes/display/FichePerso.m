//
//  FichePerso.m
//  ShadukiamGame
//
//  Created by yael on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FichePerso.h"

@implementation FichePerso

@synthesize numPerso;

- (void) initWithPerso:(int)pnumPerso andXML:(NSDictionary*) persoXML {
    
    numPerso = pnumPerso;
    infosXML = persoXML;
    
    isFront = YES;
    
    // general : background / boutons
    general = [SPSprite sprite];
    
    background = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_bkg_%d.png", numPerso]];
    [general addChild:background];
    
    retourneBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    [general addChild:retourneBtn];
    retourneBtn.x = 60;
    retourneBtn.y = 110;
    
    okBtn = [SPImage imageWithContentsOfFile:@"valide.png"];
    [general addChild:okBtn];
    okBtn.x = 330;
    okBtn.y = 110;
    
    [self addChild:general];
    
    // front : portrait + nom
    front = [SPSprite sprite];
    [self addChild:front];
    
    portrait = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_illu_%d.png", numPerso]];
    [front addChild:portrait];
    portrait.x = (background.width - portrait.width) / 2;
    portrait.y = 10;
    
    nom = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_nom_%d.png", numPerso]];
    [front addChild:nom];
    nom.x = (background.width - nom.width) / 2;
    nom.y = 200;
    
    // back : nom et texte
    back = [SPSprite sprite];
    [self addChild:back];
    back.x = background.width / 2;
    back.scaleX = 0;
    
    nomBack = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_nom_%d.png", numPerso]];
    [back addChild:nomBack];
    nomBack.x = (background.width - nomBack.width) / 2;
    nomBack.y = 30;
    
    description = [SPTextField textFieldWithWidth:220 height:150 
                                             text:[NSString stringWithFormat:@"HISTOIRE : %@\nCAPACITE : %@", [infosXML objectForKey:@"histoire"], [infosXML objectForKey:@"capacite"]]];
    description.x = (background.width - description.width) / 2;
    description.y = 70;
    description.fontName = [Constante getFontDescription];
    description.fontSize = 14;
    description.color = 0xFFFFFF;
    [back addChild:description];
    
    // close btn
    
    closeBtn = [SPImage imageWithContentsOfFile:@"btn_close.png"];
    [self addChild:closeBtn];
    closeBtn.x = 395;
    closeBtn.y = 10;
    [closeBtn addEventListener:@selector(onTouchClose:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // listeners
    [retourneBtn addEventListener:@selector(onTouchRetourne:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [okBtn addEventListener:@selector(onTouchOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

- (void)onTouchRetourne:(SPTouchEvent*) event {
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    if(touches.count == 1) {
        SPTween *tweenGeneral = [SPTween tweenWithTarget:general time:0.25f transition:SP_TRANSITION_EASE_IN];
        [tweenGeneral animateProperty:@"scaleX" targetValue:0];
        [tweenGeneral animateProperty:@"x" targetValue:background.width / 2];
        
        SPTween *tweenGeneral2 = [SPTween tweenWithTarget:general time:0.25f transition:SP_TRANSITION_EASE_OUT];
        tweenGeneral2.delay = 0.25f;
        [tweenGeneral2 animateProperty:@"scaleX" targetValue:1];
        [tweenGeneral2 animateProperty:@"x" targetValue:0];
    
        SPTween *tweenFront;
        SPTween *tweenBack;
        
        if(isFront) {
            // passage au back de la carte
            tweenFront = [SPTween tweenWithTarget:front time:0.25f transition:SP_TRANSITION_EASE_IN];
            [tweenFront animateProperty:@"scaleX" targetValue:0];
            [tweenFront animateProperty:@"x" targetValue:background.width / 2];
            
            tweenBack = [SPTween tweenWithTarget:back time:0.25f transition:SP_TRANSITION_EASE_OUT];
            tweenBack.delay = 0.25f;
            [tweenBack animateProperty:@"scaleX" targetValue:1];
            [tweenBack animateProperty:@"x" targetValue:0];
            
        } else {
            // passage au front
            tweenFront = [SPTween tweenWithTarget:front time:0.25f transition:SP_TRANSITION_EASE_OUT];
            tweenFront.delay = 0.25f;
            [tweenFront animateProperty:@"scaleX" targetValue:1];
            [tweenFront animateProperty:@"x" targetValue:0];
            
            tweenBack = [SPTween tweenWithTarget:back time:0.25f transition:SP_TRANSITION_EASE_IN];
            [tweenBack animateProperty:@"scaleX" targetValue:0];
            [tweenBack animateProperty:@"x" targetValue:background.width / 2];
        }
    
        isFront = !isFront;
    
        [self.stage.juggler addObject:tweenGeneral];
        [self.stage.juggler addObject:tweenGeneral2];
        [self.stage.juggler addObject:tweenFront];
        [self.stage.juggler addObject:tweenBack];
        
        [[ShadSounds getInstance] playSound:@"flip" ];
    }
}

- (void)onTouchClose:(SPTouchEvent*) event {
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    if(touches.count == 1) {
        [self dispatchEvent:[SPEvent eventWithType:@"close"]];
    }
}

-(void) onTouchOk:(SPTouchEvent*) event {
    [self dispatchEvent:[SPEvent eventWithType:@"touchOK"]];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [okBtn removeEventListener:@selector(onTouchOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

-(void) removeOK {
    [general removeChild:okBtn];
}

- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
    [general removeChild:background];
    background = nil;
    
    [retourneBtn removeEventListener:@selector(onTouchRetourne:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [general removeChild:retourneBtn];
    retourneBtn = nil;
    
    [general removeChild:okBtn];
    [okBtn removeEventListener:@selector(onTouchOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    okBtn = nil;
    
    [self removeChild:general];
    general = nil;
    
    [front removeChild:portrait];
    portrait = nil;
    
    [front removeChild:nom];
    nom = nil;
    
    [self removeChild:front];
    front = nil;
    
    [back removeChild:nomBack];
    nomBack = nil;
    
    [self removeChild:back];
    back = nil;
    
    [closeBtn removeEventListener:@selector(onTouchClose:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self removeChild:closeBtn];
    closeBtn = nil;
    
    [super finalize];
}

@end
