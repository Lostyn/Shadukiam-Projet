
#if !defined(__CPPawnManager4Unity_h_)
#define __CPPawnManager4Unity_h_

#include "CPDefines.h"

extern "C" {
	
	bool EPManagerInitialize(bool rotation, EPResolutionMode resolutionMode);
	bool EPManagerInitialized();
	void EPManagerTerminate();
	UIScreen* EPGameScreen();
	UIScreen* EPCommandScreen();
	bool EPExternalScreen();
	void EPManagerProcess();
	float EPGetPositionX(int i);
	float EPGetPositionY(int i);
	
}

#endif // __CPPawnManager4Unity_h_