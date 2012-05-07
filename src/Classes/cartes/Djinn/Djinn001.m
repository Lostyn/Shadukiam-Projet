//
//  Djinn001.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Djinn001.h"

@implementation Djinn001

-(void) execute {
    [self displayDescription:@"RENDEZ VOUS" withDesc:@"à la case indiqué"];
    
    zoneCase = [[Plateau getInstance] getZonesForSalle:3];
    
    int index = arc4random()%zoneCase.count;
    targetCase = [[zoneCase objectAtIndex:index] intValue];
    
    NSLog(@"::%d", targetCase);
    visu = [[VisuPlateau alloc] initWithZones:zoneCase andWidth:170 andHeight:95];
    visu.x = 250;
    visu.y = 140;
    [visu setZoneActive:targetCase];
    [self addChild:visu];
    
    [self addEventListener:@selector(onFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    
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
    
    [super execute];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:false];
}

-(void)onTimer:(NSTimer*) timer{
    [timer invalidate];
    timer = nil;
    
    [debut play];
    [self.stage.juggler addObject:debut];
}

-(void) onFrame:(SPEnterFrameEvent*) event{
    myPion = [[EpawnData getInstance] getPionByID:[InfosJoueur getMyPerso]];
    NSDictionary *currentCase = [[Plateau getInstance]getCaseByCoord:myPion.posx andY:myPion.posy];
    
    if( targetCase == (int)[currentCase objectForKey:@"id"] ){
        [self dispatchEvent:[SPEvent eventWithType:@"VALIDATE"]];
    }else{
        [self dispatchEvent:[SPEvent eventWithType:@"UNVALIDATE"]];
    }
}

-(void)nextAnim:(SPEvent*) event{
    SPMovieClip *movie = [[SPMovieClip alloc] initWithFrames:frameBoucle fps:30];
    movie.x = 58;
    movie.y = 15;
    [self addChild:movie];
    
    [movie play];
    
    [self.stage.juggler addObject:movie];
    
    [self removeChild:debut];
    [debut stop];
    [self.stage.juggler removeObject:debut];
}

@end
