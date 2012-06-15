//
//  DjinnP2.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 16/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "DjinnP2.h"

@implementation DjinnP2


-(void)execute{
    [self displayDescription:@"ÉBOULEMENT" withDesc:@"Une case du plateau est détruite"];
    
    atlasBoucle = [SPTextureAtlas atlasWithContentsOfFile:@"waterDjinn_boucle.xml"];
    frameBoucle = [atlasBoucle texturesStartingWith:@"boucle/"];
    
    
    SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"waterDjinn_debut.xml"];
    NSArray *frames = [atlas texturesStartingWith:@"debut/"];
    debut = [[SPMovieClip alloc] initWithFrames:frames fps:30];
    debut.x = 58;
    debut.y = 15;
    [self addChild:debut];
    [debut addEventListener:@selector(nextAnim:) atObject:self forType:SP_EVENT_TYPE_MOVIE_COMPLETED];
    debut.loop = NO;
    
    
    //   
        zoneCase = [[Plateau getInstance] getZonesForSalle:3];
    
        int index = arc4random()%zoneCase.count;
        targetCase = [[zoneCase objectAtIndex:index] intValue];
    
        visu = [[VisuPlateau alloc] initWithZones:zoneCase andWidth:170 andHeight:95];
        visu.x = 250;
        visu.y = 140;
        [visu setZoneActive:targetCase];
        [self addChild:visu];
    
    [super execute];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:false];
    
    [[ShadSounds getInstance] playSound:@"caillou" ];
}

-(void) cancel{
    [super cancel];
    
    [self removeAllChildren];
    [loop stop];
    [self.stage.juggler removeAllObjects];
}

-(void)onTimer:(NSTimer*) timer{
    [timer invalidate];
    timer = nil;
    
    [debut play];
    [self.stage.juggler addObject:debut];
}

-(void)nextAnim:(SPEvent*) event{
    loop = [[SPMovieClip alloc] initWithFrames:frameBoucle fps:30];
    loop.x = 58;
    loop.y = 15;
    [self addChild:loop];
    
    [loop play];
    
    [self.stage.juggler addObject:loop];
    
    [self removeChild:debut];
    [debut stop];
    [self.stage.juggler removeObject:debut];
}
@end
