//
//  VisuPlateau.h
//  ShadukiamGame
//
//  Created by yael on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"
#import "Plateau.h"

@interface VisuPlateau : SPSprite {
    
    SPSprite *conteneur;
    
}

-(id) initWithZones:(NSMutableArray*) zonesShow andWidth:(int) widthAff andHeight:(int) heightAff;

@end
