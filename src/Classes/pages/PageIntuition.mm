//
//  PageIntuition.m
//  ShadukiamGame
//
//  Created by yael on 06/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageIntuition.h"

@implementation PageIntuition

-(void) show {
    
    // init back btn
    backBtn = [SPImage imageWithContentsOfFile:@"retourne.png"];
    [self addChild:backBtn];
    backBtn.x = 50;
    backBtn.y = 0;
    [backBtn addEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // init RA
    QCARutils *qUtils = [QCARutils getInstance];
    [qUtils resumeAR];
    
    CGRect myRect = CGRectMake(-50, 42, 280, 440);
    
    window = [[UIWindow alloc] initWithFrame: myRect];
    
    // Provide a list of targets we're expecting - the first in the list is the default
    if([[qUtils targetsList] count] == 0) {
        [qUtils addTargetName:@"Plateau provisoire" atPath:@"plateau_provisoire.xml"];
    }
    
    // Add the EAGLView and the overlay view to the window
    arParentViewController = [[ARParentViewController alloc] init];
    arParentViewController.arViewRect = myRect;
    [window insertSubview:arParentViewController.view atIndex:0];
    [window makeKeyAndVisible];
    [window setHidden:NO];
    
}
-(void) onTouchBack:(SPTouchEvent*) event {
    
    [backBtn removeEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [arParentViewController viewDidDisappear:NO];
    arParentViewController = nil;
    [window setHidden:YES];
    [window removeFromSuperview];
    window = nil;
    
    [[PageManager getInstance] changePage:@"PageTDB"];
    
}

-(void) finalize {
    [backBtn removeEventListener:@selector(onTouchBack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

@end
