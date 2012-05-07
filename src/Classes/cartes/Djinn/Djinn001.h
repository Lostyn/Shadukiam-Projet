//
//  Djinn001.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "DefaultDjinn.h"
#import "VisuPlateau.h"
#import "InfosJoueur.h"
#import "EpawnData.h"

@interface Djinn001 : DefaultDjinn {
    
    NSArray *zoneCase;
    int targetCase;
    PionInfos *myPion;
    VisuPlateau *visu;
    SPMovieClip *debut;
    
    SPTextureAtlas *atlasBoucle;
    NSArray *frameBoucle;
}

@end
