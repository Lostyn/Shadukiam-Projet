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
#import "Titre.h"

@class ARParentViewController;

@interface PageIntuition : Page {
    UIWindow* window;
    ARParentViewController* arParentViewController;
    Titre *titre;
    SPImage *switchObjet;
    SPImage *switchPorte;
    SPImage *barreFond;
    SPImage *barreTop;
    
    SPImage *backBtn;
    
    NSTimer *timerBarre;
}

@end
