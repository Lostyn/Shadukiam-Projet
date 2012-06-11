//
//  InfosJoueur.h
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfosJoueur : NSObject

+ (void) setMyPerso:(int)numPerso;
+ (int) getMyPerso;
+ (void) addObjet:(int) objetID;
+ (void) removeObjet:(int) objetID;
+ (NSMutableArray*) getObjets;
+ (void) setCurrentCase:(int)numCase;
+ (int) getCurrentCase;

+ (void) gainScore:(int) value;
+ (void) looseScore:(int) value;
+ (int) getScore;

@end
