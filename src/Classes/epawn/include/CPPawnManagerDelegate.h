//
//  CPPawnManagerDelegate.h
//  ePawnSDK
//
//  Created by Nicolas Hognon on 21/06/11.
//  Copyright 2011 ePawn. All rights reserved.
//

#if defined(CP_TARGET_IOS)
	#import <UIKit/UIKit.h>
#endif
#include "CPPawn.h"

/**
 * The CPPawnManagerDelegate protocol defines the methods used to receive CPPawn position from a CPPawnManager object.
 * The methods of this protocol are optional.
 *
 * \remark At this time the hardware and software only support 4 or 8 pawns (depending on the EPPawnMode used to initialize the CPPawnManager). 
 *
 */
@protocol CPPawnManagerDelegate

/**
 * Tells the receiver when a pawn down.
 */
- (void)pawnBegan:(const CPPawn*)pawn;

/**
 * Tells the receiver when a pawn move.
 */
- (void)pawnMoved:(const CPPawn*)pawn;

/**
 * Tells the receiver when a pawn is raised.
 */
- (void)pawnEnded:(const CPPawn*)pawn;

@end
