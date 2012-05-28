//
//  MenuInfo.h
//  ShadukiamGame
//
//  Created by yael on 28/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPSprite.h"

@interface MenuInfo : SPSprite {
    
    SPImage *fond;
    
}

-(id) initWithType:(NSString*)type andData:(id)data;

@end
