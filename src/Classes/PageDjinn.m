//
//  PageDjinn.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PageDjinn.h"

@implementation PageDjinn

-(void) show {
    [super show];
    
    NSArray *aDjinn = [NSArray arrayWithObjects:@"Djinn001", @"Djinn002", nil ];
    
    bg = [[SPQuad alloc] initWithWidth:[Game stageWidth] height:[Game stageHeight] color:0x000000];
    bg.alpha = 0;
    [self addChild:bg];
    
    NSString *classDjinn = [aDjinn objectAtIndex: arc4random()%aDjinn.count];
    if( [[InfosTour getForceDjinn] isEqualToString:@""] ){
        if( [InfosPartie getPhase] == 2 ){
            classDjinn = @"DjinnP2";
        }
        [[Dialog getInstance] sendMessage:@"showDjinn" sendTo:-1 data:classDjinn];
    }else{
        classDjinn = [InfosTour getForceDjinn];
    }
    
    Class djinn = NSClassFromString( classDjinn );
    carte = [[djinn alloc] init];
        
    ok = [SPImage imageWithContentsOfFile:@"valide.png"];
    ok.x = 360;
    ok.y = 245;
    
    [self anim];
    [ok addEventListener:@selector(onNext:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}



-(void)anim{
    SPTween* tBg = [SPTween tweenWithTarget:bg time:0.5f transition:SP_TRANSITION_EASE_OUT];
    [tBg setDelay:0.75f];
    [tBg animateProperty:@"alpha" targetValue:0.5f];
    
    [self.stage.juggler addObject: tBg];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(displayCarte:) userInfo:nil repeats:NO];
    
}

-(void)displayCarte:(NSTimer*) timer{
    [self addChild:carte];
    [carte execute];
    [self addChild:ok];
}

-(void)onNext:(SPTouchEvent*) event{
    [InfosTour setDjinn:false];
    
    if( [InfosTour getPower] == true ){
        [[PageManager getInstance] changePage:@"PagePower"];
    }else{
        [[PageManager getInstance] changePage:@"PageMove"];        
    }
}

@end
