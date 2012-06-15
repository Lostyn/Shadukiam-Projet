//
//  Menu.h
//  ShadukiamGame
//
//  Created by yael on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "InfosPartie.h"
#import "MenuInfo.h"

@interface Menu : SPSprite {
    SPSprite *persos;
    SPImage *background;
    SPImage *currentImage;
    MenuInfo *infoBox;
    Boolean lastIsDiceResult;
}

+(Menu *)getInstance;
-(void) addPerso:(int)numPerso;
-(void) initMenu;
-(void) reorderPersos:(NSMutableArray*) order;
-(void) setPersoActive:(int) playerIndex;
-(void) showInfo:(int) playerIndex ofType:(NSString*) type andData:(id) data;
-(void) hideInfo;
-(void) removePersos;

@end
