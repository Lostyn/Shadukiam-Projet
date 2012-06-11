//
//  Plateau.m
//  ShadukiamGame
//
//  Created by yael on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Plateau.h"

@implementation Plateau

static Plateau *instance = nil;

static int NB_CASES_LINE = 22;
static int NB_CASES_COL = 28;
static float CASE_WIDTH = 10.7;
static float CASE_HEIGHT = 22.2;
    
+ (Plateau*)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
        [instance initInfos];
    }
    return instance;
}

- (void) initInfos {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"plateau" ofType:@"xml"]];
    NSError *error = nil;
    XMLData = [XMLReader dictionaryForXMLData:data error:&error];
    
    // salles accessibles
    sallesAccessibles = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", nil];
    //[self addSalleAccessible:3];
    
}

// retourne une case a partir son ID
- (NSDictionary*) getCaseByID:(int)caseID {
    return [XMLData retrieveForPath:[NSString stringWithFormat:@"plateau.cases.case.%d", caseID]];
}

// retourne une case a partir de sa position x et y
- (NSDictionary*) getCaseByPos:(int)posX andY:(int)posY {
    if(posX >= 0 && posX < NB_CASES_COL && posY >= 0 && posY < NB_CASES_LINE) {
        int caseID = posX * NB_CASES_LINE + posY;
        return [self getCaseByID:caseID];
    } else {
        return nil;
    }
}

// retourne une case a partir des coordonnées du pion
- (NSDictionary*) getCaseByCoord: (int) coordX andY: (int) coordY {
    if( coordX < 45 )
        return nil;
    if( coordX > 280 )
        return nil;
    if( coordY < 80 )
        return nil;
    
    coordX = coordX - 45;
    coordY = coordY - 80;
    coordY = 400 - coordY;
    
    int posX = floor(coordY / CASE_HEIGHT);
    if(posX % 2 == 1) coordX += CASE_WIDTH / 2;
    int posY = floor(coordX / CASE_WIDTH);
    
    return [self getCaseByPos:posX+10 andY:posY];
    
}

// retourne une zone a partir son ID
- (NSDictionary*) getZoneByID:(int)zoneID {
    return [XMLData retrieveForPath:[NSString stringWithFormat:@"plateau.zones.zone.%d", zoneID]];
}

// retourne un tableau avec les id des zones possibles en fonction de l'actuelle et le nombre de deplacements
- (NSMutableArray*) getZonesAccessible:(int)zoneID nbMoves: (int)moves {
    
    NSMutableArray *accessibles = [NSMutableArray array];
    
    NSDictionary *currentZone = [self getZoneByID:zoneID];
    
    [self getZonesAccessibleRec:currentZone nbMoves:moves currLevel:0 withArray: accessibles];
    
    return accessibles;
}

-(void) getZonesAccessibleRec:(NSDictionary*) currZone nbMoves: (int) moves currLevel: (int)level withArray:(NSMutableArray*) accessibles {
    if(level < moves) {
        
        
        NSDictionary *voisins = [currZone retrieveForPath:@"voisins.voisin"];
            
            
        NSEnumerator *voisinsEnum = [voisins objectEnumerator];
        NSString *voisinStr;
            
        while(voisinStr = [voisinsEnum nextObject]) {
            NSDictionary* zoneVoisine = [self getZoneByID:[voisinStr intValue]];
                
            // si la salle de la zone est accessible
            NSString *salleID = [zoneVoisine objectForKey:@"salle"];
            if([sallesAccessibles containsObject:salleID]) {
                    
                if(![accessibles containsObject:voisinStr]) {
                    [accessibles addObject:voisinStr];
                }
            
                [self getZonesAccessibleRec:zoneVoisine nbMoves:moves currLevel:level + 1 withArray:    accessibles];
                }
            }
    }
    
}

-(NSArray*) getZonesForSalle:(int)salleID {
    
    NSDictionary *zones = [XMLData retrieveForPath:[NSString stringWithFormat:@"plateau.salles.salle.%d.zones", salleID]];
    
    NSEnumerator *zonesEnum = [zones objectEnumerator];
    NSString *zoneIDStr;
    NSMutableArray *zonesArray = [NSMutableArray array];
    
    while(zoneIDStr = [zonesEnum nextObject]) {
        [zonesArray addObject:zoneIDStr];
    }
    
    return [zonesArray objectAtIndex:0];
    
}

-(void) addSalleAccessible:(int)salleID {
    
    [sallesAccessibles addObject:[NSString stringWithFormat:@"%d", salleID]];
    
}

@end
