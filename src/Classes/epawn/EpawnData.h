//
//  EpawnData.h
//  ShadukiamGame
//
//  Created by yael on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPPawnManagerDelegate.h"
#import "CPPawnManager.h"
#import "PionInfos.h"

@interface EpawnData : NSObject <CPPawnManagerDelegate> {
    
    NSMutableArray* pions;
    CPPawnManager* _epManager;
    NSTimer* _processTimer;
    
}

+(EpawnData *)getInstance;
-(void) start:(id) view;
-(NSMutableArray*) getPions;
-(void) setPions:(NSMutableArray*) newPions;
-(PionInfos*) getPionByID:(int) pionID;

@end
