//
//  ShadSounds.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 30/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "DefaultDjinn.h"

@interface ShadSounds : NSObject {
    NSMutableDictionary *sounds;
}

+(ShadSounds*) getInstance;
-(void) addSounds:(NSString*) nsSound withKey:(NSString*) key;
-(void) removeSounds:(NSString*) key;
-(SPSound*) getSound:(NSString*) key;
-(void) playSound:(NSString*) key;

@end
