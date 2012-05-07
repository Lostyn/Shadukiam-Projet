//
//  Page.m
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "PageManager.h"

@implementation Page

-(void) show {
    
    [Dialog getInstance].delegate = self;
    
}

-(void) enigmeResult:(NSString *)key{
}
-(void) enigmeSuccess:(NSString *)key{
}

-(void) nextPlayer {
    
    [InfosPartie goNextPlayer];
    
    if([InfosPartie getCurrentPlayer] == [Dialog getInstance].myID) [[PageManager getInstance] changePage:@"PageDice"];
    
}

@end
