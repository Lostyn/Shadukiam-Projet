//
//  VisuPlateau.m
//  ShadukiamGame
//
//  Created by yael on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VisuPlateau.h"

@implementation VisuPlateau 

-(id) initWithZones:(NSMutableArray *)zonesShow andWidth:(int)widthAff andHeight:(int)heightAff {
    
    self = [super init];
    
    SPQuad *fond = [SPQuad quadWithWidth:widthAff height:heightAff color:0x000000];
    //[self addChild:fond];
    fond.alpha = 0.3;
    
    // affichage de toutes les cases
    conteneur = [SPSprite sprite];
    [self addChild:conteneur];
    
    NSEnumerator *zonesEnum = [zonesShow objectEnumerator];
    NSDictionary *zoneData = nil;
    NSString *zoneIDStr = nil;
    
    int xMin = 999;
    int yMin = 999;
    
    zonesImages = [NSMutableDictionary dictionary];
    
    while(zoneIDStr = [zonesEnum nextObject]) {
        int zoneID = [zoneIDStr intValue];
        zoneData = [[Plateau getInstance] getZoneByID:zoneID];
        
        SPImage *zoneImage = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"zone_%@.png", [zoneData objectForKey:@"id"]]];
        int posx = [[zoneData objectForKey:@"posx"] intValue] / 2;
        int posy = [[zoneData objectForKey:@"posy"] intValue] / 2;
        zoneImage.x = posx;
        zoneImage.y = posy;
        [conteneur addChild:zoneImage];
        
        [zonesImages setObject:zoneImage forKey:[NSString stringWithFormat:@"%d", zoneID]];
        
        // maj min coords affichage
        if(posx < xMin) xMin = posx;
        if(posy < yMin) yMin = posy;
    }
    
    //NSLog(@"xmin : %d, ymin : %d", xMin, yMin);
    //NSLog(@"width : %d, height : %d", widthAff, heightAff);
    
    float ratioX = (float)widthAff / conteneur.width;
    float ratioY = (float)heightAff / conteneur.height;
    
    //NSLog(@"ratio x : %f, ratio y : %f", ratioX, ratioY);
    
    float ratio;
    if(ratioX < ratioY) ratio = ratioX;
    else ratio = ratioY;
    if(ratio > 1) ratio = 1;
    //NSLog(@"ratio : %f", ratio);
    //NSLog(@"conteneur width : %f, height : %f", conteneur.width, conteneur.height);
    
    conteneur.x = - xMin * ratio;
    conteneur.y = - yMin * ratio;
    conteneur.x += ((float)widthAff - conteneur.width * ratio) / 2;
    conteneur.y += ((float)heightAff - conteneur.height * ratio) / 2;
    
    conteneur.scaleX = conteneur.scaleY = ratio;
    
    return self;
    
}

// changement de la zone actie
-(void) setZoneActive:(int)zoneID {
    
    if(currentZoneHidden != nil) currentZoneHidden.visible = true;
    if(currentZoneActive != nil) [conteneur removeChild:currentZoneActive];
    
    if(zoneID != -1) {
        [self hideZone:zoneID];
        [self affZoneActive:zoneID];
    }
    
}

// cache l'image d'une zone pour afficher l'image de la zone active
-(void) hideZone:(int)zoneID {
    
    currentZoneHidden = [zonesImages objectForKey:[NSString stringWithFormat:@"%d", zoneID]];
    
    currentZoneHidden.visible = false;
    
}

-(void) affZoneActive:(int)zoneID {
    
    if(zoneID % 2 == 1) {
    NSDictionary *zoneData = [[Plateau getInstance] getZoneByID:zoneID];
    
    currentZoneActive = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"zone_%d_active.png", zoneID]];
    currentZoneActive.x = [[zoneData objectForKey:@"posx"] intValue] / 2;
    currentZoneActive.y = [[zoneData objectForKey:@"posy"] intValue] / 2;
    [conteneur addChild:currentZoneActive];
    }
    
}

-(void) finalize {
    
    [self removeChild:conteneur];
    conteneur = nil;
    
}

@end
