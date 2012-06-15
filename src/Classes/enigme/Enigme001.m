//
//  Enigme001.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 04/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Enigme001.h"

@implementation Enigme001

static NSString *KEY = @"enigme001Active";

-(id) init{
    self = [super init];
    
    titre = @"MÉCANISME";
    catchKey = NO;
    
    return self;
}

-(NSString*)getTitre{
    return titre;
}

-(void)execute{
    testActive = false;
    
    SPImage *background = [SPImage imageWithContentsOfFile:@"cadre.png"];
    background.x = 262;
    background.y = 100;
    [self addChild:background];
    
    spLevier = [[SPSprite alloc] init];
    spLevier.x = 165;
    spLevier.y = 220;
    spLevier.rotation = -50 * PI / 180;
    [self addChild:spLevier];

    mecanisme = [SPImage imageWithContentsOfFile:@"levier_meca.png"];
    mecanisme.x = -mecanisme.width/2;
    mecanisme.y = -mecanisme.height;
    [spLevier addChild:mecanisme];
    
    levier = [SPImage imageWithContentsOfFile:@"levier.png"];
    levier.x = 43;
    levier.y = 120;
    levier.touchable = false;
    [self addChild:levier];
    
    SPTextField *description = [SPTextField textFieldWithWidth:150 height:150 text:@"Levier\nCe levier doit être activé en même temps qu'un autre."];
    description.x = background.x + 30;
    description.y = background.y + 10;
    description.fontName = [Constante getFontDescription];
    description.fontSize = [Constante getSizeDescription] + 4;
    description.color = 0x000000;
    [self addChild:description];
    
    [mecanisme addEventListener:@selector(onDown:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    //popUp
    popUp = [[PopUpEnigme alloc] init];
    popUp.alpha = 0;
}

-(void) cancel{
   [mecanisme removeEventListener:@selector(onDown:) atObject:self forType:SP_EVENT_TYPE_TOUCH]; 
}

-(void) onDown:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if([touches count] > 0) {
        SPTouch *touch = [touches objectAtIndex:0];
        
        SPPoint *touchPos = [touch locationInSpace:self];
        float rot = ( touchPos.x - spLevier.x );
        
        if( rot > 90 ){
            rot = 90;
            if( !testActive ){
                testActive = true;
                
                [[Dialog getInstance] sendMessage:@"enigmeResult" sendTo:-1 data:KEY];
                [self active];
            }
        }else{
            testActive = false;
        }
        if( rot < -50 )
            rot = -50;
        
        spLevier.rotation = rot * PI / 180;
        
    }
}

/*
-(void)onSwipe:(SPTouchEvent*) event{
   NSArray *touchBegan = [[event touchesWithTarget:levier andPhase:SPTouchPhaseBegan] allObjects];
    NSArray *touchEnded = [[event touchesWithTarget:levier andPhase:SPTouchPhaseEnded] allObjects];
    
    if( touchBegan.count == 1 ){
        SPTouch *touch = [touchBegan objectAtIndex:0];
        if( touch.tapCount == 1 ){
            start = [touch locationInSpace:self.parent];
        }
    }
    
    if( touchEnded.count == 1 ){
        SPTouch *touchE = [touchEnded objectAtIndex:0];
        
        CGFloat dist = [self DistanceBetweenTwoPoints:[touchE locationInSpace:self.parent] withPoint2:start ];
        
        if( dist > 100 && [touchE locationInSpace:self.parent].x - start.x > 100 ){
            
            [[Dialog getInstance] sendMessage:@"enigmeResult" sendTo:-1 data:KEY];
            [self active];
        }
    }
}*/

-(void) testResult:(NSString*) sKey{
    
    if( [sKey isEqualToString:KEY] ){
        catchKey = YES;
        catchTime = [[NSDate date] timeIntervalSince1970];
    }
}

-(void) active{
    if( catchKey ){
        if( [[NSDate date] timeIntervalSince1970] - catchTime < 2 ){
            [[Dialog getInstance] sendMessage:@"enigmeSuccess" sendTo:-1 data:KEY];
            [self enigmeSuccess:KEY];
        }else{
            catchKey = NO;
        }
    }
}

-(void) enigmeSuccess:(NSString *)sKey{
    catchKey = NO;
    
    [mecanisme addEventListener:@selector(onDown:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self addChild:popUp];
    SPTween *tweenPop = [SPTween tweenWithTarget:popUp time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tweenPop animateProperty:@"alpha" targetValue:1];
    
    [self.stage.juggler addObject:tweenPop];
    
    [InfosJoueur gainScore:5];
    [[Plateau getInstance] addSalleAccessible:3];
    
    [[ShadSounds getInstance] playSound:@"meca2" ];
}

/*
-(CGFloat) DistanceBetweenTwoPoints:(SPPoint*) point1 withPoint2:(SPPoint*) point2
{
    
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
}*/

@end
