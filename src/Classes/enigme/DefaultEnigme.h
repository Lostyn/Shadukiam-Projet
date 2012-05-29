//
//  DefaultEnigme.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 04/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "SPSprite.h"
#import "PageManager.h"
#import "Dialog.h"
#import "EpawnData.h"
#import "Constante.h"

@interface DefaultEnigme : SPSprite{
    
    NSString *titre;
    SPImage *backBtn;
    NSString *targetBack;
    bool catchKey;
    NSTimeInterval catchTime;
}

-(void)execute;
-(NSString*)getTitre;
-(void) testResult:(NSString*) sKey;
-(void) enigmeSuccess:(NSString*) sKey;
-(void) cancel;

@end
