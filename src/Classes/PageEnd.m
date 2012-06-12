//
//  PageEnd.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 11/06/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "PageEnd.h"

@implementation PageEnd

-(void) show{
    [super show];
    
    [self getInvScore];
    
    v = 0;
    
    titre = [[Titre alloc] initWithText:@"CLASSEMENT"];
    [self addChild:titre];
    titre.x = 120;
    titre.y = 3;
    
    dJauge = [[NSMutableDictionary alloc] init];
    
    [self addJauge:[InfosJoueur getMyPerso]];
    
    NSDictionary *joueurs = [InfosPartie getJoueurs];
    for( NSString* key in joueurs ){
        [self addJauge:[[joueurs objectForKey:key] intValue]]; 
    }
    
    [self updateJauge];
    [self setJaugesValues];
}

-(void) getInvScore{
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
        [InfosJoueur gainScore:[[xmlObjet objectForKey:@"points"] intValue]];
        
        i++;
    }
}

-(void) addJauge:(int) forId{
    Jauge *j = [[Jauge alloc] initWithImage:[NSString stringWithFormat:@"fond_%d.png", forId]];
    [dJauge setObject:j forKey:[NSString stringWithFormat:@"%d", forId]];
}

-(void) updateJauge{
    int i = 0;
    for( NSString* key in dJauge ){
        Jauge *j = [dJauge objectForKey:key];
        j.x = 55 + i*50;
        j.y = 300;
        [self addChild:j];
        i++;
    }
}

-(void)setJaugesValues{
    [[Dialog getInstance] sendMessage:@"getScore" sendTo:-1 data:@"data"];
}

-(void)setJaugeValue:(NSString*)key withValue:(int) value{
    [[dJauge objectForKey:key] update:value];
}

@end
