//
//  PageIntuition.m
//  ShadukiamGame
//
//  Created by yael on 06/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageIntuition.h"

@implementation PageIntuition

-(void) show {
    
    
    titre = [[Titre alloc] initWithText:@"INTUITION"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
    // anim
    titre.alpha = 0;
    titre.y = -20;
    SPTween* tweenTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenTitre setDelay:0.5f];
    [tweenTitre animateProperty:@"alpha" targetValue:1];
    [tweenTitre animateProperty:@"y" targetValue:0];
    [self.stage.juggler addObject:tweenTitre];
    
    // init back btn
    backBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    [self addChild:backBtn];
    backBtn.x = 50;
    backBtn.y = 0;
    [backBtn addEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // switch
    switchObjet = [SPImage imageWithContentsOfFile:@"intuition_switch_objets.png"];
    [self addChild:switchObjet];
    switchObjet.x = 100;
    switchObjet.y = 40;
    switchObjet.visible = false;
    [switchObjet addEventListener:@selector(showPortes:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    switchPorte = [SPImage imageWithContentsOfFile:@"intuition_switch_portes.png"];
    [self addChild:switchPorte];
    switchPorte.x = 100;
    switchPorte.y = 40;
    [switchPorte addEventListener:@selector(showObjets:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // init RA
    QCARutils *qUtils = [QCARutils getInstance];
    [qUtils resumeAR];
    
    CGRect myRect = CGRectMake(-70, 42, 280, 440);
    
    window = [[UIWindow alloc] initWithFrame: myRect];
    
    // Provide a list of targets we're expecting - the first in the list is the default
    if([[qUtils targetsList] count] == 0) {
        [qUtils addTargetName:@"plateau" atPath:@"plateau_ra.xml"];
    }
    
    // Add the EAGLView and the overlay view to the window
    arParentViewController = [[ARParentViewController alloc] init];
    arParentViewController.arViewRect = myRect;
    [window insertSubview:arParentViewController.view atIndex:0];
    [window makeKeyAndVisible];
    [window setHidden:NO];
    
}

-(void) showPortes:(SPTouchEvent*)event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            switchObjet.visible = false;
            switchPorte.visible = true;
        }
    }
    
}

-(void) showObjets:(SPTouchEvent*)event {
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    // si on a bien juste tapé sur l'objet
    if(touches.count == 1) {  
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 1)
        {
            switchObjet.visible = true;
            switchPorte.visible = false;
        }
    }
    
}

-(void) onTouchBack:(SPTouchEvent*) event {
    
    [backBtn removeEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [arParentViewController viewDidDisappear:NO];
    arParentViewController = nil;
    [window setHidden:YES];
    [window removeFromSuperview];
    window = nil;
    
    [[PageManager getInstance] changePage:@"PageTDB"];
    
}

-(void) finalize {
    [backBtn removeEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self removeChild:backBtn];
    backBtn = nil;
    
    [self removeChild:titre];
    titre = nil;
    
    [switchObjet removeEventListener:@selector(showPortes:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [switchPorte removeEventListener:@selector(showObjets:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

@end
