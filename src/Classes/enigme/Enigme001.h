//
//  Enigme001.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 04/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "DefaultEnigme.h"
#import "PopUpEnigme.h"

@interface Enigme001 : DefaultEnigme{
    
    SPImage *mecanisme;
    SPImage *levier;
    SPPoint *start;
    PopUpEnigme *popUp;
    SPSprite *spLevier;
    Boolean testActive;
}

-(CGFloat) DistanceBetweenTwoPoints:(SPPoint*) point1 withPoint2:(SPPoint*) point2;
-(void)active;
@end
