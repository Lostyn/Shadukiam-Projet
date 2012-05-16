//
//  InfosTour.h
//  ShadukiamGame
//
//  Created by Jérémy Petrequin on 02/05/12.
//  Copyright (c) 2012 université de franche comté. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfosTour : NSObject

+(void)setDjinn:(bool) bDjinn;
+(bool)getDjinn;

+(void)setPower:(bool) bPower;
+(bool)getPower;

+(void)setMouvement:(int)iMvt;
+(int)getMouvement;

+(void) setForceDjinn:(NSString*) force;
+(NSString*) getForceDjinn;
@end
