//
//  Jauge.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 12/06/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "SPSprite.h"
#import "SXGauge.h"

@interface Jauge : SPSprite{
    SXGauge *gauge;
    SPSprite *sp;
    float lim;
    SPTextField *tfJauge;
}

-(id) initWithImage:(NSString*) image;
-(void) update:(float) value;
@end
