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
#import "PageManager.h"

@interface PageEnd : Page {
    Titre *titre;
    NSMutableDictionary *dJauge;
    SPImage *end;
}

-(void) addJauge:(int) forId andPlayer:(NSString*)pl;
-(void) updateJauge;
-(void) setJaugesValues;

@end
