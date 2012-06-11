//
//  InfosJoueur.m
//  ShadukiamGame
//
//  Created by yael on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfosJoueur.h"

@implementation InfosJoueur

static int myPerso = 0;
static NSMutableArray* objets = nil;
static int currentCase = 0;
static int score = 0;

+(void) initialize {
    objets = [NSMutableArray array];
}

+ (void) setMyPerso:(int)numPerso {
    myPerso = numPerso;
}

+ (int) getMyPerso {
    return myPerso;
}

+ (void) gainScore:(int)value{
    score += value;
}

+ (void) looseScore:(int)value{
    score -= value;
}

+ (int) getScore{
    return score;
}

+ (void) setCurrentCase:(int)numCase {
    currentCase = numCase;
}

+ (int) getCurrentCase {
    return currentCase;
}

+ (void) addObjet:(int) objetID {
    [objets addObject:[NSNumber numberWithInt:objetID]];
}

+ (void) removeObjet:(int) index {
    [objets removeObjectAtIndex:index];
}

+(NSMutableArray*) getObjets {
    return objets;
}

@end
