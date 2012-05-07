//
//  Djinn001.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Djinn001.h"

@implementation Djinn001

-(void) execute {
    [self displayDescription:@"RENDEZ VOUS" withDesc:@"à la case indiqué"];
    
    [self addEventListener:@selector(onFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

-(void) onFrame:(SPEnterFrameEvent*) event{
    myPion = [[EpawnData getInstance] getPionByID:[InfosJoueur getMyPerso]];
    NSDictionary *currentCase = [[Plateau getInstance]getCaseByCoord:myPion.posx andY:myPion.posy];
    
    if( targetCase == (int)[currentCase objectForKey:@"id"] ){
        
    }
}

@end
