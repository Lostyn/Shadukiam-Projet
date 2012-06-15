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
static Boolean showObjets = false;

+(void) initialize {
    objets = [NSMutableArray array];
}

+(void) reinit {
    myPerso = 0;
    objets = [NSMutableArray array];
    currentCase = 0;
    score = 0;
    showObjets = false;
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

+(void) setShowObjets:(Boolean)value {
    showObjets = value;
}

+(Boolean) getShowObjets {
    return showObjets;
}

@end
