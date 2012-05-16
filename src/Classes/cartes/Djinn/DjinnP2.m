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
    
    [super execute];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:false];
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
