//
//  EpawnData.m
//  ShadukiamGame
//
//  Created by yael on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EpawnData.h"

@implementation EpawnData

static EpawnData *instance = nil;

+ (EpawnData*)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
    }
    return instance;
}

-(void) start:(id)view {
    
    pions = [NSMutableArray array];
    for(int i = 0; i < 10; i++) {
        [pions addObject:[[PionInfos alloc] init]];
    }
    
    // initiliaze the CPPawnManger with default values.
    _epManager = [[CPPawnManager alloc] init];
    _epManager.gameView = view;
    
    // start a timer to run the mainLoop (which is used to process the CPPawnManager)
    _processTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0) target:self selector:@selector(mainLoop) userInfo:nil repeats:YES];
    
}

-(void)mainLoop {
	[_epManager process];
}

-(NSMutableArray*) getPions {
    return pions;
}

-(void) setPions:(NSMutableArray*) newPions {
    pions = newPions;
}

-(PionInfos*) getPionByID:(int) pionID {
    
    NSEnumerator * enumerator =  [pions objectEnumerator];
    
    PionInfos* pion;
    
    while (pion = [enumerator nextObject]) {
        if(pion.pid == pionID) {
            return pion;
        }
    }
    
    return nil;
    
}


#pragma mark CPPawnManager delegate


- (void)pawnBegan:(const CPPawn*)pawn
{
    PionInfos* pion = [[PionInfos alloc] init];
    pion.pid = pawn->pid;
    pion.posx = pawn->posx;
    pion.posy = pawn->posy;
    [pions insertObject:pion atIndex:pawn->pid];
	
}

- (void)pawnMoved:(const CPPawn*)pawn
{
    PionInfos* pion = [[PionInfos alloc] init];
    pion.pid = pawn->pid;
    pion.posx = pawn->posx;
    pion.posy = pawn->posy;
    [pions insertObject:pion atIndex:pawn->pid];
}

- (void)pawnEnded:(const CPPawn*)pawn
{
	[pions removeObjectAtIndex:pawn->pid];
}

@end
