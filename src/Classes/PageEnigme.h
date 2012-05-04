//
//  PageEnigme.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 04/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "PageManager.h"
#import "DefaultEnigme.h"

@interface PageEnigme : Page {
    
    Titre *titre;
    DefaultEnigme *enigme;
    SPImage *backBtn;
    NSString *targetBack;
}

-(void)onTouchBack:(SPTouchEvent*)event;
-(void)animQuit;

@end
