//
//  Constante.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Constante.h"

@implementation Constante

    static NSString *DESCRIPTION_FONT = @"Times new Roman";
    static int DESCRIPTION_SIZE = 14;
    static int DESCRIPTION_COLOR = 0xFFFFFF;

+(NSString*) getFontDescription{
    return DESCRIPTION_FONT;
}

+(int) getSizeDescription{
    return DESCRIPTION_SIZE;
}

+(int) getColorDescription{
    return DESCRIPTION_COLOR;
}

@end
