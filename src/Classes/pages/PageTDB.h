//
//  PageTDB.h
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "InfosJoueur.h"
#import "PageManager.h"
#import "TDBBtn.h"
#import "InfosPartie.h"


@interface PageTDB : Page {
    
    Titre *titre;
    SPImage *persoImg;
    TDBBtn *btnInventaire;
    TDBBtn *btnPouvoir;
    TDBBtn *btnEnigme;
    TDBBtn *btnMessagerie;
    TDBBtn *btnIntuition;
    SPImage *finTour;
    SPImage *btnPower;
    
    SPSprite *buttons;
    NSString *targetPage;
    
}

-(void) animQuit;
-(void)testEndGame;

@end
