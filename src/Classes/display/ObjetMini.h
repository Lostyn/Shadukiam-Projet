//
//  ObjetMini.h
//  ShadukiamGame
//
//  Created by yael on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "InfosJoueur.h"

@interface ObjetMini : SPSprite {
    
    SPImage *background;
    SPImage *icone;
    SPImage *nomBkg;
    SPTextField *nomTxt;
    int ID;
    
}

@property int ID;
-(id) initWithObjetID:(int) objetID andName:(NSString*) name;

@end
