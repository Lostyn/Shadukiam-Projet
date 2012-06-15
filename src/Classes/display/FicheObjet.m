//
//  FicheObjet.m
//  ShadukiamGame
//
//  Created by yael on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FicheObjet.h"

@implementation FicheObjet

@synthesize objetID;

- (void) initWithID:(int)ID andXML:(NSDictionary *)objetXML {
    
    objetID = ID;
    
    isFront = YES;
    
    infosXML = objetXML;
    
    // general : background / boutons
    general = [SPSprite sprite];
    
    background = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_bkg_%d.png", [InfosJoueur getMyPerso]]];
    [general addChild:background];
    
    retourneBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    [general addChild:retourneBtn];
    retourneBtn.x = 50;
    retourneBtn.y = 110;
    
    okBtn = [SPImage imageWithContentsOfFile:@"valide.png"];
    if(objetID == 7) {
        [general addChild:okBtn];
        [okBtn addEventListener:@selector(onTouchOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    okBtn.x = 340;
    okBtn.y = 110;
    
    [self addChild:general];
    
    // front : portrait + nom
    front = [SPSprite sprite];
    [self addChild:front];
    
    portrait = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"fiche_objet_objBig_%d.png", objetID]];
    [front addChild:portrait];
    portrait.x = (background.width - portrait.width) / 2;
    portrait.y = 10;
    
    nom = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"fiche_objet_nom_%d.png", objetID]];
    [front addChild:nom];
    nom.x = (background.width - nom.width) / 2;
    nom.y = 200;
    
    // back : nom et texte
    back = [SPSprite sprite];
    [self addChild:back];
    back.x = background.width / 2;
    back.scaleX = 0;
    
    nomBack = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"fiche_objet_nom_%d.png", objetID]];
    [back addChild:nomBack];
    nomBack.x = (background.width - nomBack.width) / 2;
    nomBack.y = 22;
    
    description = [SPTextField textFieldWithWidth:220 height:150 
                                             text:[NSString stringWithFormat:@"%@",[infosXML objectForKey:@"description"]
                                                   ]];
    description.x = (background.width - description.width) / 2;
    description.y = 60;
    description.fontName = @"Times new Roman";
    description.fontSize = 14;
    description.color = 0xFFFFFF;
    [back addChild:description];
    
    // icones classes
    NSDictionary *classes = [infosXML retrieveForPath:@"classes.classe"];
    
    NSEnumerator *classesEnum = [classes objectEnumerator];
    NSString *classeStr;
    int i = 0;
    
    Boolean forMe = false;
    
    while(classeStr = [classesEnum nextObject]) {
        if(![classeStr isEqualToString:@"0"]) {
            SPImage *classeImage = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"menu_perso_%@.png", classeStr]];
            classeImage.x = 305 - i * 20;
            classeImage.y = 38;
            classeImage.scaleX = classeImage.scaleY = 0.8;
            [back addChild:classeImage];
            i++;
            
            if([classeStr intValue] == [InfosJoueur getMyPerso]) forMe = true;
        }
    }
    
    // points
    SPTextField *ptsTxt = [SPTextField textFieldWithText: [infosXML objectForKey:@"points"]];
    SPTextField *ptsSpeTxt = [SPTextField textFieldWithText: [infosXML objectForKey:@"pointsB"]];
    SPTextField *ptsNameTxt = [SPTextField textFieldWithText:@"POINTS"];
    SPTextField *ptsSepTxt = [SPTextField textFieldWithText:@"-"];
    
    ptsTxt.x = 135;
    ptsSpeTxt.x = 170;
    ptsNameTxt.x = 152;
    ptsSepTxt.x = 152;
    ptsTxt.y = ptsSpeTxt.y = 152;
    ptsNameTxt.y = 172;
    ptsSepTxt.y = 152;
    ptsTxt.fontSize = ptsSpeTxt.fontSize = 24;
    ptsNameTxt.fontSize = 12;
    ptsSepTxt.fontSize = 24;
    ptsTxt.fontName = ptsSpeTxt.fontName = ptsNameTxt.fontName = ptsSepTxt.fontName = @"Times new Roman";
    
    if(forMe) {
        ptsTxt.color = 0x999999;
        ptsTxt.alpha = 0.8;
        ptsSpeTxt.color = 0xFFFFFF;
    } else {
        ptsTxt.color = 0xFFFFFF;
        ptsSpeTxt.color = 0x999999;
        ptsSpeTxt.alpha = 0.8;
    }
    ptsNameTxt.color = 0xFFFFFF;
    ptsSepTxt.color = 0xFFFFFF;
    
    [back addChild:ptsTxt];
    [back addChild:ptsNameTxt];
    [back addChild:ptsSpeTxt];
    [back addChild:ptsSepTxt];
    
    // close btn
    
    closeBtn = [SPImage imageWithContentsOfFile:@"btn_close.png"];
    [self addChild:closeBtn];
    closeBtn.x = 395;
    closeBtn.y = 10;
    [closeBtn addEventListener:@selector(onTouchClose:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // listeners
    [retourneBtn addEventListener:@selector(onTouchRetourne:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
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

-(void) onTouchOk:(SPTouchEvent*) event {
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            [[ShadSounds getInstance] playSound:@"dynamite" ];
            [InfosPartie setPhase:2];
            [InfosJoueur removeObjet:7];
            [[Dialog getInstance] sendMessage:@"phase" sendTo:-1 data:[NSNumber numberWithInt:2]];
            [[PageManager getInstance] changePage:@"PageTDB"];
        }
    }
}

- (void)onTouchClose:(SPTouchEvent*) event {
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    if(touches.count == 1) {
        [self dispatchEvent:[SPEvent eventWithType:@"close"]];
    }
}

- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
    
    [okBtn removeEventListener:@selector(onTouchOk:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [general removeChild:background];
    background = nil;
    
    [retourneBtn removeEventListener:@selector(onTouchRetourne:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [general removeChild:retourneBtn];
    retourneBtn = nil;
    
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
