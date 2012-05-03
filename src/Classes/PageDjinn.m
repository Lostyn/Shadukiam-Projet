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
    
    titre = [[Titre alloc] initWithText:@"Djinn"];
    titre.x = 120;
    titre.y = 3;
    [self addChild:titre];
    
    [self addEventListener:@selector(onNext:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
