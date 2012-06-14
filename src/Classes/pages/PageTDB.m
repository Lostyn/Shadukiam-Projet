//
//  PageTDB.m
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageTDB.h"

@implementation PageTDB

- (void) show {
    
    [super show];
    
    titre = [[Titre alloc] initWithText:@"TABLEAU DE BORD"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
    persoImg = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"ficheperso_mini_%d.png", [InfosJoueur getMyPerso]]];
    [self addChild:persoImg];
    persoImg.scaleX = 0.8;
    persoImg.scaleY = 0.8;
    persoImg.x = ([Game stageWidth] - persoImg.width) / 2 + 20;
    persoImg.y = 50;
    [persoImg addEventListener:@selector(showPerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    buttons = [SPSprite sprite];
    [self addChild:buttons];
    
    btnInventaire = [[TDBBtn alloc] initWithText:@"INVENTAIRE" andImage:@"inventaire"];
    btnInventaire.x = 80;
    btnInventaire.y = 75;
    [buttons addChild:btnInventaire];
    btnInventaire.name = @"PageInventaire";
    [btnInventaire addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    btnEnigme = [[TDBBtn alloc] initWithText:@"ENIGMES" andImage:@"enigme"];
    btnEnigme.x = 80;
    btnEnigme.y = 165;
    btnEnigme.name = @"PageEnigme";
    [buttons addChild:btnEnigme];
    [btnEnigme addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    btnMessagerie = [[TDBBtn alloc] initWithText:@"MESSAGERIE" andImage:@"messagerie"];
    btnMessagerie.x = 340;
    btnMessagerie.y = 75;
    btnMessagerie.name = @"PageObtentionObjet";
    [buttons addChild:btnMessagerie];
    //[btnMessagerie addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    btnIntuition = [[TDBBtn alloc] initWithText:@"INTUITION" andImage:@"plateau"];
    btnIntuition.x = 340;
    btnIntuition.y = 165;
    btnIntuition.name = @"PageIntuition";
    [buttons addChild:btnIntuition];
    [btnIntuition addEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    finTour = [SPImage imageWithContentsOfFile:@"btn_tdb_fintour.png"];
    [buttons addChild:finTour];
    finTour.x = 170;
    finTour.y = 275;
    [finTour addEventListener:@selector(onFinTour:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    if([InfosPartie getCurrentPlayer] != [Dialog getInstance].myID) finTour.visible = false;
    
    if( [InfosTour getPower] ){
        btnPower = [SPImage imageWithContentsOfFile:@"power_btn.png"];
        [buttons addChild:btnPower];
        btnPower.x = 425;
        btnPower.y = 0;
    }
    
    
    // anim
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:0];
    
    
    persoImg.alpha = 0.01;
    persoImg.y = 60;
    persoImg.x += 10;
    persoImg.scaleX = 0.7;
    persoImg.scaleY = 0.7;
    SPTween* tweenPerso = [SPTween tweenWithTarget:persoImg time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenPerso setDelay:0.75f];
    [tweenPerso animateProperty:@"alpha" targetValue:1];
    [tweenPerso animateProperty:@"y" targetValue:50];
    [tweenPerso animateProperty:@"x" targetValue:persoImg.x - 10];
    [tweenPerso animateProperty:@"scaleX" targetValue:0.8];
    [tweenPerso animateProperty:@"scaleY" targetValue:0.8];
    
    buttons.alpha = 0.01;
    buttons.y = 5;
    SPTween* tweenButtons = [SPTween tweenWithTarget:buttons time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenButtons setDelay:1];
    [tweenButtons animateProperty:@"alpha" targetValue:1];
    [tweenButtons animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject:tweenTitre];
    [self.stage.juggler addObject:tweenPerso];
    [self.stage.juggler addObject:tweenButtons];
    // init masque background
    
    backgroundMask = [[SPQuad alloc] initWithWidth:[Game stageWidth] height:[Game stageHeight] color:0x000000];
    
    backgroundMask.alpha = 0;
    
    
    
    // xml
    NSData *xmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"persos" ofType:@"xml"]];
    NSError *error = nil;
    infosXML = [XMLReader dictionaryForXMLData:xmlData error:&error];
}



-(void) showPerso:(SPTouchEvent*) event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            [self addChild:backgroundMask];
            backgroundMask.alpha = 0;
            
            // init fiche
            persoActive = [[FichePerso alloc] init ];
            [persoActive initWithPerso:[InfosJoueur getMyPerso] andXML:[infosXML retrieveForPath:[NSString stringWithFormat:@"persos.perso.%d", [InfosJoueur getMyPerso]]]];
            
            
            persoActive.x = ([Game stageWidth] - persoActive.width) / 2 + 17;
            persoActive.y = ([Game stageHeight] - persoActive.height) / 2 + 45;
            persoActive.alpha = 0;
            [self addChild:persoActive];
            
            // tween fiche et background
            SPTween *tweenFiche = [SPTween tweenWithTarget:persoActive time:0.5f transition:SP_TRANSITION_EASE_OUT];
            [tweenFiche animateProperty:@"y" targetValue:persoActive.y - 30];
            
            [tweenFiche animateProperty:@"alpha" targetValue:1];
            tweenFiche.delay = 0.25f;
            
            SPTween *tweenBack = [SPTween tweenWithTarget:backgroundMask time:0.5f transition:SP_TRANSITION_EASE_OUT];
            [tweenBack animateProperty:@"alpha" targetValue:0.5];
            
            [self.stage.juggler addObject:tweenFiche];
            [self.stage.juggler addObject:tweenBack];
            
            // close
            [persoActive addEventListener:@selector(closePerso:) atObject:self forType:@"close"];
            [backgroundMask addEventListener:@selector(closePerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
    }
}



// ferme fiche perso
- (void) closePerso:(SPTouchEvent*)event {
    [backgroundMask removeEventListener:@selector(closePerso:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [persoActive removeEventListener:@selector(closePerso:) atObject:self forType:@"close"];
    
    // tween fiche et background
    SPTween *tweenFiche = [SPTween tweenWithTarget:persoActive time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenFiche animateProperty:@"y" targetValue:persoActive.y + 30];
    [tweenFiche animateProperty:@"alpha" targetValue:0];
    
    SPTween *tweenBack = [SPTween tweenWithTarget:backgroundMask time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenBack animateProperty:@"alpha" targetValue:0];
    
    [self.stage.juggler addObject:tweenFiche];
    [self.stage.juggler addObject:tweenBack];
    
    [tweenBack addEventListener:@selector(onClosePersoCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}



- (void) onClosePersoCompleted:(SPEvent*)event {
    [event.currentTarget removeEventListener:@selector(onClosePersoCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    [self removeChild:persoActive];
    persoActive = nil;
    [self removeChild:backgroundMask];
    backgroundMask.alpha = 0;
}

// touch btn, emmene a la bonne page
-(void) onTouchBtn:(SPTouchEvent*) event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            TDBBtn *btnTouch = (TDBBtn*)event.currentTarget;
            targetPage = btnTouch.name;
            [self animQuit];
        }
    }
    
}

// fin de mon tour
-(void) onFinTour:(SPTouchEvent*) event {
    [finTour removeEventListener:@selector(onFinTour:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    finTour.visible = false;
    [self testEndGame];
}

-(void)testEndGame{
    if( [InfosPartie getPhase] == 2 ){
        if( [InfosJoueur getCurrentCase] == 0 ){
            [InfosPartie addFinish:[InfosJoueur getMyPerso]];
            
            [[Dialog getInstance] sendMessage:@"addFinish" sendTo:-1 data:[NSString stringWithFormat:@"%d", [InfosJoueur getMyPerso]] ];
        }
        
        if( [InfosPartie getNbFinish] == [InfosPartie getNbPlayers] ){
            
            [self getInvScore];
            
            [[Dialog getInstance] sendMessage:@"end" sendTo:-1 data:@"data"];
            [[PageManager getInstance] changePage:@"PageEnd"];
        }else{
            [[Dialog getInstance] sendMessage:@"nextplayer" sendTo:-1 data:@"data"];
            [self nextPlayer];
        }
    }else{
        [[Dialog getInstance] sendMessage:@"nextplayer" sendTo:-1 data:@"data"];
        [self nextPlayer];
    }
}

// anim pour quitter la page
-(void) animQuit {
    
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre animateProperty:@"alpha" targetValue:0];
    [tweenTitre animateProperty:@"y" targetValue:-15];
    
    SPTween* tweenPerso = [SPTween tweenWithTarget:persoImg time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenPerso animateProperty:@"alpha" targetValue:0];
    [tweenPerso animateProperty:@"y" targetValue:60];
    [tweenPerso animateProperty:@"x" targetValue:persoImg.x + 10];
    [tweenPerso animateProperty:@"scaleX" targetValue:0.7];
    [tweenPerso animateProperty:@"scaleY" targetValue:0.7];
    
    SPTween* tweenButtons = [SPTween tweenWithTarget:buttons time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenButtons animateProperty:@"alpha" targetValue:0];
    [tweenButtons animateProperty:@"y" targetValue:5];
    
    [self.stage.juggler addObject:tweenTitre];
    [self.stage.juggler addObject:tweenPerso];
    [self.stage.juggler addObject:tweenButtons];
    
    [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(goNextPage:) userInfo:nil repeats:NO];
}

-(void) goNextPage:(NSTimer*) timer {
    
    [[PageManager getInstance] changePage:targetPage];
    
    //kill the timer
    [timer invalidate];
    timer = nil;
}

-(void) finalize {
    [self removeChild:titre];
    titre = nil;
    
    [self removeChild:persoImg];
    persoImg = nil;
    
    [self removeChild:btnInventaire];
    [btnInventaire removeEventListener:@selector(onTouchBtn:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    btnInventaire = nil;
    [self removeChild:btnPouvoir];
    btnPouvoir = nil;
    [self removeChild:btnMessagerie];
    btnMessagerie = nil;
    [self removeChild:btnIntuition];
    btnIntuition = nil;
    [self removeChild:btnEnigme];
    btnEnigme = nil;
}

@end
