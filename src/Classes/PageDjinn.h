//
//  PageDjinn.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 03/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "Page.h"
#import "PageManager.h"
#import "InfosTour.h"
#import "DefaultDjinn.h"

@interface PageDjinn : Page {
    
    SPQuad *bg;
    DefaultDjinn *carte;
    SPImage *ok;
}

-(void)anim;
-(void)displayCarte:(NSTimer*) timer;

@end
