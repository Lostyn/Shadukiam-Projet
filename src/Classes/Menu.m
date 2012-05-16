//
//  Menu.m
//  ShadukiamGame
//
//  Created by yael on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"

@implementation Menu

static Menu *instance = nil;

+ (Menu*)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
    }
    return instance;
}

-(void) initMenu {
    
    background = [SPImage imageWithContentsOfFile:@"fond_menu.png"];
    [self addChild:background];
    
    currentImage = [SPImage imageWithContentsOfFile:@"menu_perso_highlight.png"];
    [self addChild:currentImage];
    currentImage.alpha = 0;
    currentImage.x = -1;
    
    persos = [SPSprite sprite];
    [self addChild:persos];
    persos.x = 8;
    persos.y = 260;
}

-(void) addPerso:(int)numPerso {
    SPImage *persoIcon = [SPImage imageWithContentsOfFile:[NSString stringWithFormat:@"menu_perso_%d.png", numPerso]];
    [persos addChild:persoIcon];
    persoIcon.y = -([persos numChildren] - 1) * (persoIcon.height + 10);
}

-(void) reorderPersos:(NSMutableArray *)order {
    
    [persos removeAllChildren];
    
    for(int i = [order count] - 1; i >= 0; i--) {
        
        NSString *joueurIDStr = [NSString stringWithFormat:@"%@", [order objectAtIndex:i]];
        NSLog(@"joueur id : %@, joueurs : %@", joueurIDStr, [InfosPartie getJoueurs]);
        int numPersoOrder = [[[InfosPartie getJoueurs] objectForKey:joueurIDStr] intValue];
        
        [self addPerso:numPersoOrder];
        
    }
    
}

-(void) setPersoActive:(int)playerIndex {
    currentImage.alpha = 1;
    int imageIndex = [persos numChildren] - playerIndex - 1;
    currentImage.y = 251 - imageIndex * 30;
}

@end
