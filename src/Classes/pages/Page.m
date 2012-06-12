//
//  Page.m
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "PageManager.h"

@implementation Page

-(void) show {
    
    [Dialog getInstance].delegate = self;
    
}

-(void) enigmeResult:(NSString *)key{
}
-(void) enigmeSuccess:(NSString *)key{
}

-(void) nextPlayer {
    
    [InfosPartie goNextPlayer];
    
    [[Menu getInstance] setPersoActive:[InfosPartie getCurrentPlayerIndex]];
    
    if([InfosPartie getCurrentPlayer] == [Dialog getInstance].myID) [[PageManager getInstance] changePage:@"PageDice"];
    
}

// vide une zone de son objet / enigme ...
-(void) videZone:(int)zoneID {
    
    [InfosDisposition videZone:zoneID];
    
}

-(void) showDjinn:(NSString*)djinnID {
    
    [InfosTour setForceDjinn:djinnID];
    [[PageManager getInstance] changePage:@"PageDjinn"];
    
}

// pour que une info apparaisse dans le menu des autres joueurs
-(void) dispatchMenuinfo:(NSString *)type andData:(id)data {
    
    [[Dialog getInstance] sendMessage:@"menuInfo" sendTo:-1 data:[NSDictionary dictionaryWithObjectsAndKeys:type, @"type", data, @"data", nil]];
    
}

// affichage d'une info dans le menu
-(void) showMenuInfo:(NSString *)type andData:(id)data fromID:(int)playerID {
    
    [[Menu getInstance] showInfo:[InfosPartie getCurrentPlayerIndex] ofType:type andData:data];
}

-(void) gotoPageEnd{
    [self getInvScore];
    [[PageManager getInstance] changePage:@"PageEnd"];
}

-(void) getInvScore{
    NSLog(@"GetInventaireScore");
    NSMutableArray *objets = [InfosJoueur getObjets];
    
    // init infos XML
    NSData *xmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"objets" ofType:@"xml"]];
    NSError *error = nil;
    NSDictionary *infosXML = [XMLReader dictionaryForXMLData:xmlData error:&error];
    
    // affichage des objets
    NSEnumerator *enumerator = [objets objectEnumerator];
    NSNumber *objetID;
    int i = 0;
    
    while(objetID = [enumerator nextObject]) {
        NSDictionary *xmlObjet = [infosXML retrieveForPath:[NSString stringWithFormat:@"objets.objet.%@", objetID]];
        NSLog(@"Add score %d", [[xmlObjet objectForKey:@"points"] intValue] );
        [InfosJoueur gainScore:[[xmlObjet objectForKey:@"points"] intValue]];
        
        i++;
    }
}

-(void) cancel{
}

@end
