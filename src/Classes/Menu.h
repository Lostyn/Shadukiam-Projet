//
//  Menu.h
//  ShadukiamGame
//
//  Created by yael on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "InfosPartie.h"

@interface Menu : SPSprite {
    SPSprite *persos;
    SPImage *background;
    SPImage *currentImage;
}

+(Menu *)getInstance;
-(void) addPerso:(int)numPerso;
-(void) initMenu;
-(void) reorderPersos:(NSMutableArray*) order;
-(void) setPersoActive:(int) playerIndex;

@end
