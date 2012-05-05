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
    NSMutableDictionary *zonesImages;
    SPImage *currentZoneHidden;
    SPImage *currentZoneActive;
    
}

-(id) initWithZones:(NSMutableArray*) zonesShow andWidth:(int) widthAff andHeight:(int) heightAff;
-(void) setZoneActive:(int) zoneID;
-(void) hideZone:(int) zoneID;
-(void) affZoneActive:(int) zoneID;

@end
