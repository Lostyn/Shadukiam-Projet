//
//  FicheObjet.h
//  ShadukiamGame
//
//  Created by yael on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "Game.h"
#import "InfosJoueur.h"
#import "XMLReader.h"

@interface FicheObjet : SPSprite {
    
    SPSprite *front;
    SPSprite *back;
    SPSprite *general;
    SPImage *background;
    SPImage *portrait;
    SPImage *nom;
    SPImage *retourneBtn;
    SPImage *nomBack;
    SPImage *okBtn;
    NSDictionary *infosXML;
    SPTextField *description;
    SPImage *closeBtn;
    
    bool isFront;
    int objetID;
    
}

@property int objetID;

- (void) initWithID:(int)ID andXML:(NSDictionary*) objetXML;

@end
