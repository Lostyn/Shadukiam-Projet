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
#import "FichePerso.h"
#import "XMLReader.h"


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
    FichePerso *persoActive;
    SPQuad *backgroundMask;
    NSDictionary *infosXML;
    
    SPSprite *buttons;
    NSString *targetPage;
    
}

-(void) animQuit;
-(void)testEndGame;

@end
