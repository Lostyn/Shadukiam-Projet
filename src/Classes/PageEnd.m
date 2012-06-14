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
    
    titre = [[Titre alloc] initWithText:@"CLASSEMENT"];
    [self addChild:titre];
    titre.x = 120;
    
    dJauge = [[NSMutableDictionary alloc] init];
    
    //[self addJauge:[InfosJoueur getMyPerso]];
    
    NSDictionary *joueurs = [InfosPartie getJoueurs];
    for( NSString* key in joueurs ){
       [self addJauge:[key intValue] andPlayer:[joueurs objectForKey:key]]; 
    }
    
    [self updateJauge];
    [self setJaugesValues];
    
    end = [SPImage imageWithContentsOfFile:@"btn_fin.png"];
    [self addChild:end];
    end.x = 170;
    end.y = 275;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(connect:) userInfo:nil repeats:NO];
}

-(void)connect:(NSTimer*) timer{
    [timer invalidate];
    timer = nil;
    [end addEventListener:@selector(onFin:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}



-(void) onFin:(SPTouchEvent*) event{
    [[PageManager getInstance] changePage:@"PagePlay"];
}


-(void) addJauge:(int) forId andPlayer:(NSString*)pl{
    NSLog(@"forpl %@", pl);
    Jauge *j = [[Jauge alloc] initWithImage:[NSString stringWithFormat:@"fond_%@.png", pl]];
    [dJauge setObject:j forKey:[NSString stringWithFormat:@"%d", forId]];
}

-(void) updateJauge{
    int i = 0;
    for( NSString* key in dJauge ){
        Jauge *j = [dJauge objectForKey:key];
        j.x = 45 + i*110;
        j.y = 280;
        [self addChild:j];
        i++;
    }
}

-(void)setJaugesValues{
    NSString *key = [NSString stringWithFormat:@"%d", [InfosJoueur getMyPerso]];
    int val = [InfosJoueur getScore];
    [[dJauge objectForKey:key] update:val];
    [[Dialog getInstance] sendMessage:@"getScore" sendTo:-1 data:@"data"];
}

-(void)setJaugeValue:(NSString*)key withValue:(int) value{
    float v = value;
    [[dJauge objectForKey:key] update:v];
}

@end
