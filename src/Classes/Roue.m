//
//  Roue.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Roue.h"

@implementation Roue

-(id) initDisplay {
    self = [super init];
    
    background = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"rouePerso%d.png", [InfosJoueur getMyPerso]]];
    [self addChild:background];
    
    containerRoue = [[SPSprite alloc] init];
    containerRoue.x = self.width/2;
    containerRoue.y = self.height/2;
    [self addChild:containerRoue];
    
    roue = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"roueP%d.png", [InfosPartie getPhase]]];
    roue.x = -roue.width/2;
    roue.y = -roue.height/2;
    [containerRoue addChild:roue];
    
    containerRoue.rotation = SP_D2R( arc4random()%360 );
    
    arrow = [SPImage imageWithContentsOfFile:@"roueAiguille.png"];
    [self addChild:arrow];
    
    return self;
}

-(void) update:(CGFloat) value{
    containerRoue.rotation += SP_D2R( value );		
}

-(void) getResult{
    float rot = containerRoue.rotation;
    rot = SP_R2D( rot );
    if( rot < 0.0f ){
        rot = 360 + rot;
    }
    rot = roundf( ((int)rot)/60 );
    
    NSString *resultLink;
    
    rot = 0;
    
    if( [InfosPartie getPhase] == 1 ){
        switch ( (int)rot ) {
            case 0:
                resultLink = @"roueResultDjinn.png";
                [InfosTour setDjinn:true];
                break;
            case 1:
            case 3:
                resultLink = @"";
                break;
            case 2:
            case 4:
                resultLink = @"roueResultMvt.png";
                [InfosTour setMouvement:[InfosTour getMouvement] + 2 ];
                break;
            case 5:
                resultLink = @"roueResultPower.png";
                [InfosTour setPower:true];
                break;
            default:
                break;
        }
    }else{
        switch ( (int)rot ) {
            case 0:
            case 2:
            case 4:
                resultLink = @"roueResultDjinn.png";
                [InfosTour setDjinn:true];
                break;
            case 1:
                resultLink = @"roueResultPower.png";
                [InfosTour setPower:true];
                break;
            case 3:
            case 5:
                resultLink = @"roueResultMvt.png";
                [InfosTour setMouvement:[InfosTour getMouvement] + 3 ];
                break;
            default:
                break;
        }
    }
    
    fondResult = [SPImage imageWithContentsOfFile:@"roueResultFond.png"];
    
    [self addChild:fondResult];
    [self removeChild:background];
    [self addChild:arrow];
    
    if( resultLink != @"" ){
        result = [SPImage imageWithContentsOfFile:resultLink];
        result.alpha = 0;
        result.x = result.width/2;
        result.y = result.height/2;
        result.scaleX = 0.0f;
        result.scaleY = 0.0f;
        SPTween *tweener = [SPTween tweenWithTarget:result time:1.0f transition:SP_TRANSITION_EASE_OUT];
        [tweener animateProperty:@"alpha" targetValue:1];
        [tweener animateProperty:@"y" targetValue:0];
        [tweener animateProperty:@"x" targetValue:0];
        [tweener animateProperty:@"scaleX" targetValue:1];
        [tweener animateProperty:@"scaleY" targetValue:1];
        [self addChild:result];
        
        [self.stage.juggler addObject:tweener];
    }
}

@end
