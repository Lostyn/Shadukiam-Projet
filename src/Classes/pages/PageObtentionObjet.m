//
//  PageObtentionObjet.m
//  ShadukiamGame
//
//  Created by yael on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageObtentionObjet.h"

@implementation PageObtentionObjet

-(void) show {
    
    [super show];
    
    titre = [[Titre alloc] initWithText:@"NOUVEL OBJET"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = -20;
    titre.alpha = 0;
    
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:0];
    [tweenTitre setDelay:0.5];
    [self.stage.juggler addObject:tweenTitre];
    
    // init infos XML
    
    NSData *xmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"objets" ofType:@"xml"]];
    NSError *error = nil;
    infosXML = [XMLReader dictionaryForXMLData:xmlData error:&error];
    
    // init fiche objet
    numObjet = 1;
    [InfosJoueur addObjet:numObjet];
    
    ficheObjet = [[FicheObjet alloc] init ];
    [ficheObjet initWithID:numObjet andXML:[infosXML retrieveForPath:[NSString stringWithFormat:@"objets.objet.%d", numObjet]]];
    
    ficheObjet.x = ([Game stageWidth] - ficheObjet.width) / 2 + 17;
    ficheObjet.y = ([Game stageHeight] - ficheObjet.height) / 2 + 45;
    ficheObjet.alpha = 0;
    [self addChild:ficheObjet];
    
    // ok
    [ficheObjet addEventListener:@selector(onTouchOK:) atObject:self forType:@"touchOK"];
    
    // tween fiche 
    SPTween *tweenFiche = [SPTween tweenWithTarget:ficheObjet time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:ficheObjet.y - 30];
    [tweenFiche animateProperty:@"alpha" targetValue:1];
    tweenFiche.delay = 1;
    
    [self.stage.juggler addObject:tweenFiche];
}

-(void) onTouchOK:(SPEvent*) event {
    
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:0];
    [tweenTitre animateProperty:@"y" targetValue:-15];
    
    SPTween *tweenFiche = [SPTween tweenWithTarget:ficheObjet time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:ficheObjet.y + 30];
    [tweenFiche animateProperty:@"alpha" targetValue:0];
    
    [self.stage.juggler addObject:tweenFiche];
    [self.stage.juggler addObject:tweenTitre];
    
    [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(goTDB:) userInfo:nil repeats:NO];
}

-(void) goTDB:(NSTimer*) timer {
    
    //kill the timer
    [timer invalidate];
    timer = nil;
    
    [[PageManager getInstance] changePage:@"PageTDB"];
    
}

-(void) finalize {
    
    [self removeChild:titre];
    titre = nil;
    
    [ficheObjet removeEventListener:@selector(onTouchOK:) atObject:self forType:@"touchOK"];
    [self removeChild:ficheObjet];
    ficheObjet = nil;
    
    infosXML = nil;
    
}

@end