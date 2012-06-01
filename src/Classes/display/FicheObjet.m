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
    [general addChild:okBtn];
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
                                             text:[NSString stringWithFormat:@"POINTS : %@\nPOINTS SPECIAUX : %@", [infosXML objectForKey:@"points"], [infosXML objectForKey:@"pointsB"]]];
    description.x = (background.width - description.width) / 2;
    description.y = 70;
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
    
    ptsTxt.x = 135;
    ptsSpeTxt.x = 170;
    ptsNameTxt.x = 120;
    ptsTxt.y = ptsSpeTxt.y = 152;
    ptsNameTxt.y = 172;
    ptsTxt.fontSize = ptsSpeTxt.fontSize = 24;
    ptsNameTxt.fontSize = 12;
    ptsTxt.fontName = ptsSpeTxt.fontName = ptsNameTxt.fontName = @"Times new Roman";
    
    if(forMe) {
        ptsTxt.color = 0x999999;
        ptsSpeTxt.color = 0xFFFFFF;
    } else {
        ptsTxt.color = 0xFFFFFF;
        ptsSpeTxt.color = 0x999999;
    }
    ptsNameTxt.color = 0xFFFFFF;
    
    [back addChild:ptsTxt];
    [back addChild:ptsNameTxt];
    [back addChild:ptsSpeTxt];
    
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
    }
}

-(void) onTouchOk:(SPTouchEvent*) event {
    [self dispatchEvent:[SPEvent eventWithType:@"touchOK"]];
}

- (void)finalize
{
    // event listeners should always be removed to avoid memory leaks!
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
    
    [super finalize];
}

@end
