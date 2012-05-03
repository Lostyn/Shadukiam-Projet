/*
 *  CPDefines.h
 *  ePawnSDK
 *
 *  Copyright 2011 ePawn. All rights reserved.
 *
 */

#if !defined(_CPDEFINES_H_)
#define _CPDEFINES_H_

#ifdef __APPLE__
	#include "TargetConditionals.h"

	#if TARGET_OS_IPHONE
		#define CP_TARGET_IOS
	#elif TARGET_OS_MAC
		#define CP_TARGET_MACOSX
	#else
		#error "TARGET: UNSUPPORTED"
	#endif
#endif

/**
 * Define how the manager will configure the external screen (if any is connected to the device).
 */
typedef enum
{
	/** Look for the VGA resolution (1024x768). */
	EPRM_VGA,
	/** Look for the 720p resolution (1280x720). */
	EPRM_720p,
	/** Look for the 1080p resolution (1920x1080). */
	EPRM_1080p,
	/** Look for the maximum resolution supported by the device and/or the screen. */
	EPRM_MAX
} EPResolutionMode;

/**
 * Define the type of pawn used by the application. At this time pawns are differentiated by the number of "point" used to compute their position and rotation. 
 */
typedef enum
{
	/** Pawn defined by only one point (which is its position). Pawns rotation is always 0. */
	EPPM_MONO,
	/** Pawn defined by two points. It is position is the center of the two points. */
	EPPM_DUAL
} EPPawnMode;

#endif // _CPDEFINES_H_