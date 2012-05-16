//
//  Djinn002.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 16/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Djinn002.h"

@implementation Djinn002

-(void)execute{
    if( [InfosJoueur getObjets].count == 0 ){
       [self displayDescription:@"DJINN VOLEUR" withDesc:@"Le djinn ne trouve rien a voler chez vous"]; 
    }else{
        [self displayDescription:@"DJINN VOLEUR" withDesc:@"Vous perdez un de vos objets"];
    
        //init infox XML
        NSData *xmlData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"objets" ofType:@"xml"]];
        NSError *error = nil;   
        infosXML = [XMLReader dictionaryForXMLData:xmlData error:&error];
    
        int index = arc4random()%[InfosJoueur getObjets].count;
    
        NSNumber *objetID = [[InfosJoueur getObjets] objectAtIndex:index];
        NSDictionary *xmlObjet = [infosXML retrieveForPath:[NSString stringWithFormat:@"objets.objet.%@", objetID]];
    
        ObjetMini *objetIcone = [[ObjetMini alloc] initWithObjetID:[objetID intValue] andName:[xmlObjet objectForKey:@"name"]];
        objetIcone.x = 290;
        objetIcone.y = 140;
        [self addChild:objetIcone];
    
        [InfosJoueur removeObjet:index];
    }
    
    //Anim djinn
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
