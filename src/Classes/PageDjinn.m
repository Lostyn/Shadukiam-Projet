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
    
    Class djinn = NSClassFromString( @"Djinn001" );
    carte = [[djinn alloc] init];
    [self addChild:carte];
    [carte execute];
    
    ok = [SPImage imageWithContentsOfFile:@"valide.png"];
    ok.x = 360;
    ok.y = 245;
    ok.alpha = 0.5f;
    [self addChild:ok];
    
    [ok addEventListener:@selector(onNext:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
