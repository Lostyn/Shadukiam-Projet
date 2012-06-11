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
    titre.y = 3;
}
@end
