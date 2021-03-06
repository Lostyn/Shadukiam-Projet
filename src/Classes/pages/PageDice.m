//
//  PageDice.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PageDice.h"

@implementation PageDice

-(void) show {
    [super show];
    
    [super dispatchMenuinfo:@"des" andData:@""];
    
    velocity = 0.0;
    velocity2 = 0.0;
    [InfosTour setMouvement:2];
    
    titre = [[Titre alloc] initWithText:@"Lancer" ];
    [self addChild:titre ];
    titre.x = 120;
    titre.y = -20;
    titre.alpha = 0;
    
    roue1 = [[Roue alloc] initDisplay ];
    roue1.x = 55;
    roue1.y = 95;
    roue1.alpha = 0;
    [self addChild:roue1];
    
    roue2 = [[Roue alloc] initDisplay ];
    roue2.x = 265;
    roue2.y = 95;
    roue2.alpha = 0;
    [self addChild:roue2];
    
    //[roue1 update:arc4random()%360];
    //[roue2 update:arc4random()%360];

    [self addEventListener:@selector(onSwipe:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self addEventListener:@selector(onFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    
    [self anim];
}

-(void) cancel{
    [self removeAllChildren];    
    
    [self removeEventListener:@selector(onNext:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self removeEventListener:@selector(onFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}


-(void)anim{
    SPTween* tRoue1 = [SPTween tweenWithTarget:roue1 time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tRoue1 setDelay:0.75f];
    [tRoue1 animateProperty:@"alpha" targetValue:1];
    [tRoue1 animateProperty:@"y" targetValue:75];
    
    SPTween* tRoue2 = [SPTween tweenWithTarget:roue2 time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tRoue2 setDelay:0.75f];
    [tRoue2 animateProperty:@"alpha" targetValue:1];
    [tRoue2 animateProperty:@"y" targetValue:75];
    
    SPTween* tTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tTitre setDelay:0.75f];
    [tTitre animateProperty:@"alpha" targetValue:1];
    [tTitre animateProperty:@"y" targetValue:0];
    
    [self.stage.juggler addObject: tRoue1];
    [self.stage.juggler addObject: tRoue2];
    [self.stage.juggler addObject: tTitre];
}

-(void)animQuit{
    SPTween* tRoue1 = [SPTween tweenWithTarget:roue1 time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tRoue1 animateProperty:@"alpha" targetValue:0];
    [tRoue1 animateProperty:@"y" targetValue:95];
    
    SPTween* tRoue2 = [SPTween tweenWithTarget:roue2 time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tRoue2 animateProperty:@"alpha" targetValue:0];
    [tRoue2 animateProperty:@"y" targetValue:95];
    
    SPTween* tTitre = [SPTween tweenWithTarget:titre time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tTitre animateProperty:@"alpha" targetValue:0];
    [tTitre animateProperty:@"y" targetValue:-20];
    
    [self.stage.juggler addObject: tRoue1];
    [self.stage.juggler addObject: tRoue2];
    [self.stage.juggler addObject: tTitre];
}




-(void)onSwipe:(SPTouchEvent*) event {
    NSArray *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    NSArray *touchEnded = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    if( touchBegan.count == 1 ){
        SPTouch *touch = [touchBegan objectAtIndex:0];
        if( touch.tapCount == 1 ){
            start = [touch locationInSpace:self.parent];	
            previousTime = [ [ NSDate date ] timeIntervalSince1970 ];
        }
    }
    
    
    if( touchEnded.count == 1 ){
        SPTouch *touchE = [touchEnded objectAtIndex:0];
        
        CGFloat dist = [self DistanceBetweenTwoPoints:[touchE locationInSpace:self.parent] withPoint2:start ];
        
        if( [[ NSDate date ] timeIntervalSince1970 ] - previousTime < 0.7 ){
            if( dist > 50 ){
                velocity = ( [touchE locationInSpace:self.parent].x - start.x );
                velocity2 = velocity + ( arc4random()%60 - 30 );
                
                [self removeEventListener:@selector(onSwipe:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
                
                if( velocity > 0 ){
                    velocity = 400;
                    velocity2 = 247;
                }else{
                    velocity = -400;
                    velocity2 = -305;
                }
                /*velocity = MIN( velocity, 400 );
                velocity2 = MIN( velocity2, 400 );
                
                velocity = MAX( velocity, -400 );
                velocity2 = MAX( velocity2, -400 );*/
            }
        }
    }
}

-(void)onFrame:(SPEnterFrameEvent*) event{
    if( velocity != 0.0 || velocity2 != 0 ){

        [roue1 update:velocity];
        [roue2 update:velocity2];
        
        velocity = velocity * 0.95;
        velocity2 = velocity2 * 0.95;
        
        if( velocity < 0.1 && velocity > -0.1 ){
            velocity = 0.0;
        }
        
        if( velocity2 < 0.1 && velocity2 > -0.1 ){
            velocity2 = 0.0;
        }
        
        if( velocity == 0.0 && velocity2 == 0.0 ){
            [self result];
        }
    }
}

-(void)result{
    [roue1 getResult];
    [roue2 getResult];
    
    [self addEventListener:@selector(onNext:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // envoi resultats aux autres joueurs
    NSDictionary* dataSend = [NSDictionary dictionaryWithObjectsAndKeys:[roue1 getResultName], @"result1", [roue2 getResultName], @"result2", nil];
    [super dispatchMenuinfo:@"desResult" andData:dataSend];
}

-(void)onNext:(SPTouchEvent*) event {
    NSArray *touchEnded = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
        
    if( touchEnded.count == 1 ){
        [self animQuit];
        [NSTimer scheduledTimerWithTimeInterval:0.75f target:self selector:@selector(gotoPage:) userInfo:nil repeats:NO];
    }
}

-(void)gotoPage:(NSTimer*) timer{
    if( [InfosTour getDjinn] == true ){
        [[PageManager getInstance] changePage:@"PageDjinn"];
    }else if( [InfosTour getPower] == true ){
        [[PageManager getInstance] changePage:@"PagePower"];            
    }else{
        [[PageManager getInstance] changePage:@"PageMove"];
    }
}

-(CGFloat) DistanceBetweenTwoPoints:(SPPoint*) point1 withPoint2:(SPPoint*) point2
{

    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
}

@end
