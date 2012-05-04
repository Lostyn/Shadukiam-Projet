//
//  PageMove.h
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "Plateau.h"
#import "EpawnData.h"
#import "InfosTour.h"
#import "PageManager.h"
#import "VisuPlateau.h"

@interface PageMove : Page {
    
    Titre *titre;
    NSDictionary *currentCase;
    NSMutableArray *zonesAccessibles;
    NSTimer *updateTimer;
    SPImage *okBtn;
    VisuPlateau *affZones;
    SPImage *backgroundZones;
    
    SPTextField *debug;
    
}

@end
