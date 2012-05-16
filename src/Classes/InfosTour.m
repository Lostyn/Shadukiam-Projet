//
//  InfosTour.m
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import "InfosTour.h"

@implementation InfosTour

static bool power = false;
static bool djinn = false;
static int mouvement = 0;
static NSString *forceDjinn = @"";

+(void) setDjinn:(bool)bDjinn {
    djinn = bDjinn;
}
+(bool) getDjinn{
    return djinn;
}

+(void) setPower:(bool)bPower {
    power = bPower;
}
+(bool) getPower{
    return power;
}

+(void) setMouvement:(int)iMvt {
    mouvement = iMvt;
}
+(int) getMouvement {
    return mouvement;
}

+(void) setForceDjinn:(NSString*) force{
    forceDjinn = force;
}

+(NSString*) getForceDjinn{
    return forceDjinn;
}
@end
