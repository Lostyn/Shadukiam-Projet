//
//  PageIntuition.h
//  ShadukiamGame
//
//  Created by yael on 06/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "ARParentViewController.h"
#import "QCARutils.h"
#import "PageManager.h"

@class ARParentViewController;

@interface PageIntuition : Page {
    UIWindow* window;
    ARParentViewController* arParentViewController;
    
    SPImage *backBtn;
}

@end
