//
//  PagePlay.h
//  ShadukiamGame
//
//  Created by yael on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "PageManager.h"
#import "ShadSounds.h"
#import <AudioToolbox/AudioServices.h>

@interface PagePlay : Page {
    
    SPImage *playBtn;
    bool connected;
    SPTextField *textInfos;
    SPImage *logoBlack;
    SPImage *logoWhite;
    
    SPMovieClip *waiter;
    
}

-(void)anim:(NSTimer*) timer;
-(void)animQuit;
-(void)gotoGame:(NSTimer*) timer;

@end
