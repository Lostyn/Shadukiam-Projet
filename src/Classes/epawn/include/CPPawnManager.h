/*
 *  EHHardwareManager.h
 *  ePawnSDK
 *
 *  Copyright 2011 ePawn. All rights reserved.
 *
 */

#if !defined(_CPPAWNMANAGER_H_)
#define _CPPAWNMANAGER_H_

#include "CPDefines.h"

#if defined(CP_TARGET_IOS) || defined(CP_TARGET_MACOSX)

#if defined(CP_TARGET_IOS)
	#import <Foundation/Foundation.h>
#endif
#import "CPPawnManagerDelegate.h"

/**
 * The CPPawnManager class defines the interface for configuring the delivery of CPPawn positions to your application.
 * You use an instance of this class to establish the parameters that determine how positions should be delivered and to start and stop the actual delivery of those events.
 *
 * To use it:
 *	- first you create a instance of the CPPawnManager interface (with CPPawnManager::init or initWithPawnMode:(EPPawnMode)andResolution:(EPResolutionMode))
 *	- then each <em>frame</em> you have to make it process its data using CPPawnManager::process
 *
 * @see CPPawn, CPPawnManagerDelegate
 */
@interface CPPawnManager : NSObject
{	
	void*	_privateData;	
	UIView* _gameView;
}

/// The delegate object you want to receive update events (when CPPawnManager::process is called).
@property(assign, nonatomic) id<CPPawnManagerDelegate> delegate; 

@property(readonly) bool configLoaded;
/// true if an external screen is connected to the host.
@property(readonly) bool externalScreen;
#if defined(CP_TARGET_IOS)
	/// Screen used to display the game/application. It is the external screen connected to the iOS device, if any. Else (if no external screen is used) gameScreen is equal to <i>main screen</i>. 
	@property (nonatomic, retain, readonly) UIScreen *gameScreen;
	/// View used to display the game/application. You have to set it while starting your application, especially if the application is not using external screen. You have to call it when the view is completly created and each is resolution or aspect ratio changed.
	@property (nonatomic, retain) UIView *gameView;
	/// Screen used to display extra information. If no external screen is used commandScreen is null else it is the main screen of the iOS device (the main screen).
	@property (nonatomic, retain, readonly) UIScreen *commandScreen;
/*#elif defined(CP_TARGET_MACOSX)
	@property (nonatomic, retain) NSScreen *gameScreen;
	@property (nonatomic, retain) NSScreen *commandScreen;*/
#endif
/**
 * Initiliaze the manager with default values.
 *
 * Initialize the manager with pawnMode=EPPM_DUAL and resolutionMode=EPRM_MAX.
 *
 */
-(id)init;

/**
 * Initiliaze the manager defining pawn mode and resolution mode.
 *
 * @param pawnMode Define which type of pawns the application is using. See #EPPawnMode.
 * @param resolutionMode Define how the manager will configure the external screen (if any is connected to the device). See #EPResolutionMode.
 * @see EPPawnMode, EPResolutionMode.
 */
-(id)initWithPawnMode:(EPPawnMode)pawnMode andResolution:(EPResolutionMode)resolutionMode;

/**
 * Process CPPawn position and rotation (if necessary).
 *
 * You have to call this function regularly (each <em>frame</em>) to receive notification of CPPawn movements through your CPPawnManagerDelegate implementation.
 */
-(void)process;

@end

#else 

// TODO

// implementation of C++ epawn manager

#endif // #if defined(CP_TARGET_IOS) || defined(CP_TARGET_MACOSX)


#endif // _CPPAWNMANAGER_H_