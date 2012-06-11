//
//  InfosPartie.m
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfosPartie.h"

@implementation InfosPartie

static NSMutableDictionary *joueurs = nil;
static NSMutableDictionary *finishJ = nil;
static int phase = 2;
static int currentPlayer = 0;
static int currentPlayerIndex = 0;
static NSMutableArray* playersOrder;

+(void) initialize {
    joueurs = [NSMutableDictionary dictionary];
    finishJ = [NSMutableDictionary dictionary];
}

+(void)addPlayer:(int)numPerso forPlayer:(int)playerID {
    
    NSString *playerIDStr = [NSString stringWithFormat:@"%d", playerID];
    NSString *numPersoStr = [NSString stringWithFormat:@"%d", numPerso];
    [joueurs setObject:numPersoStr forKey:playerIDStr];
    
}

+(NSDictionary*) getJoueurs {
    return joueurs;
}

+(void)addFinish:(int)playerID withScore:(int)playerScore{
    NSString *playerIdStr = [NSString stringWithFormat:@"%d", playerID];
    NSString *scorePlayer = [NSString stringWithFormat:@"%d", playerScore];
    [finishJ setObject:playerIdStr forKey:scorePlayer];
}

+(int)getNbFinish{
    return finishJ.count;
}

+(NSDictionary*) getFinishJ{
    return finishJ;
}

+(int)getNbPlayers {
    return joueurs.count;
}

+(int) getPhase{
    return phase;
}

+ (void) setPhase:(int)value{
    phase = value;
}

+(int) getCurrentPlayer {
    return currentPlayer;
}

+(int) getCurrentPlayerIndex {
    return currentPlayerIndex;
}

+(void) setPlayersOrder:(NSMutableArray*) order {
    playersOrder = order;
    currentPlayer = [[order objectAtIndex:0] intValue];
}

// passage au joueur suivant
+(void) goNextPlayer {
    currentPlayerIndex++;
    if(currentPlayerIndex > [playersOrder count] - 1) {
        currentPlayerIndex = 0;
    }
    
    currentPlayer = [[playersOrder objectAtIndex:currentPlayerIndex] intValue];
}

@end
