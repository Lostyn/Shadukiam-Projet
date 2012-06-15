//
//  DjinnP2.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 16/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "DefaultDjinn.h"
#import "VisuPlateau.h"
#import "Plateau.h"

@interface DjinnP2 : DefaultDjinn {
    VisuPlateau *visu;
    NSArray *zoneCase;
    int targetCase;
}

@end
