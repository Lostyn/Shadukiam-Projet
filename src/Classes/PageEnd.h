//
//  PageEnd.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 11/06/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "Jauge.h"
#import "InfosJoueur.h"
#import "InfosPartie.h"
#import "Dialog.h"
#import "XMLReader.h"

@interface PageEnd : Page {
    Titre *titre;
    NSMutableDictionary *dJauge;
    float v;
}

-(void) getInvScore;
-(void) addJauge:(int) forId;
-(void) updateJauge;
-(void) setJaugesValues;

@end
