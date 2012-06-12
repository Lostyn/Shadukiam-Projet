//
//  Page.h
//  ShadukiamGame
//
//  Created by yael on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dialog.h"
#import "Menu.h"
#import "XMLReader.h"

@interface Page : SPSprite <DialogDelegate> {
    
}

-(void) show;
-(void) getInvScore;
-(void) dispatchMenuinfo:(NSString*) type andData:(id) data;
-(void) cancel;

@end
