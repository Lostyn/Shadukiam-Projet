//
//  Roue.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "SPSprite.h"
#import "InfosJoueur.h"
#import "InfosTour.h"

@interface Roue : SPSprite{
    
    SPImage *background;
    SPImage *arrow;
    SPImage *roue;
    SPSprite *containerRoue;
    SPImage *result;
    SPImage *fondResult;
}

-(id) initDisplay;
-(void) update:(CGFloat) fValue;
-(void) getResult;


@end
