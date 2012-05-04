//
//  DefaultDjinn.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "SPSprite.h"
#import "Game.h"
#import "Constante.h"
#import "Dialog.h"
#import "EpawnData.h"

@interface DefaultDjinn : SPSprite {
    
    SPImage *carte;
    SPTextField *description;
    SPImage *disableOk;
    SPImage *ok;
}

-(void)execute;
-(void)displayDescription:(NSString*) sDescription;
    


@end
