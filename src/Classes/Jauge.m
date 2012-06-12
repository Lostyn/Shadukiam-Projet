//
//  Jauge.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 12/06/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Jauge.h"

@implementation Jauge

-(id)initWithImage:(NSString*) image{
    self = [super init];
    
    sp = [SPSprite sprite];
    sp.rotation = -PI/2;
    [self addChild:sp];
    
    SPImage *cadre = [SPImage imageWithContentsOfFile:@"cadre_gauge.png"];
    SPImage *fond = [SPImage imageWithContentsOfFile:@"fond.png"];
    
    gauge = [SXGauge gaugeWithTexture: [SPTexture textureWithContentsOfFile:image]];
    
    [sp addChild:fond];
    [sp addChild:gauge];
    [sp addChild:cadre];
    
    return self;
}

-(void) update:(float) value{
    gauge.ratio = value;
}
@end
