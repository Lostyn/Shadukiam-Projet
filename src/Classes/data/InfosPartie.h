//
//  InfosPartie.h
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfosPartie : NSObject

+(void)addPlayer:(int)numPerso forPlayer:(int)playerID;
+(NSDictionary*) getJoueurs;
+(int)getNbPlayers;
+ (int) getPhase;
+(int) getCurrentPlayer;
+(void) setPlayersOrder:(NSMutableArray*) order;
+(void) goNextPlayer;
+(int) getCurrentPlayerIndex;

@end
