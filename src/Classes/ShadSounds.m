//
//  ShadSounds.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 30/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "ShadSounds.h"

@implementation ShadSounds

static ShadSounds *instance = nil;

+(ShadSounds*)getInstance{
    if( instance == nil ){
        instance = [[self alloc] init];
    }
    
    return instance;
}

-(void) addSounds:(NSString*) nsSound withKey:(NSString*) key{
    if( !sounds )
        sounds = [[NSMutableDictionary alloc] init];
    
    if( [sounds objectForKey:key] == nil ){
        SPSound *sound = [SPSound soundWithContentsOfFile:nsSound];
        [sounds setObject:sound forKey:key];
    }else{
        NSLog(@"a sound with this key is already registered" );
    }
}

-(void) removeSounds:(NSString*) key{
    [sounds removeObjectForKey:key];
}

-(SPSound*) getSound:(NSString*) key{
    return [sounds objectForKey:key];
}

-(void) playSound:(NSString*) key{
    SPSoundChannel *channel = [[sounds objectForKey:key] createChannel];
    channel.volume = 0.6f;
    [channel play];
}

@end
