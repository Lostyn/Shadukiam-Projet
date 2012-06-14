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
    gauge.ratio = 0;
    
    tfJauge = [SPTextField textFieldWithWidth:100 height:30 text:@""];
    tfJauge.x = 15;
    tfJauge.y = -140;
    tfJauge.fontName = @"Times new Roman";
    tfJauge.fontSize = 26;
    tfJauge.color = 0xFFFFFF;
    [self addChild:tfJauge];
    
    [sp addChild:fond];
    [sp addChild:gauge];
    [sp addChild:cadre];
    
    return self;
}

-(void) update:(float) value{
    NSLog(@"updateJauge %f", value/100 );

    lim = value/100;
    [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(UpJauge:) userInfo:nil repeats:TRUE];
    
}

-(void) UpJauge:(NSTimer*) timer {
    if( gauge.ratio <= lim ){
        gauge.ratio = gauge.ratio + 0.01;
        int v = floorf(gauge.ratio*100);
        
        tfJauge.text = [NSString stringWithFormat:@"%d", v];
    }else{
        [timer invalidate];
        timer = nil;
    }
}
@end
