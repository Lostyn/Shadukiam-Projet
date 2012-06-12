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


-(void) addJauge:(int) forId{
    Jauge *j = [[Jauge alloc] initWithImage:[NSString stringWithFormat:@"fond_%d.png", forId]];
    [dJauge setObject:j forKey:[NSString stringWithFormat:@"%d", forId]];
}

-(void) updateJauge{
    int i = 0;
    for( NSString* key in dJauge ){
        Jauge *j = [dJauge objectForKey:key];
        j.x = 45 + i*110;
        j.y = 300;
        [self addChild:j];
        i++;
    }
}

-(void)setJaugesValues{
    [[Dialog getInstance] sendMessage:@"getScore" sendTo:-1 data:@"data"];
}

-(void)setJaugeValue:(NSString*)key withValue:(int) value{
    NSLog(@"updateJauge :: key %@, value %d", key, value );
    [[dJauge objectForKey:key] update:value/100];
}

@end
