/*==============================================================================
 Copyright (c) 2012 QUALCOMM Austria Research Center GmbH.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary
 ==============================================================================*/

#import "AR_EAGLView.h"
#import "InfosJoueur.h"
// This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView
// subclass.  The view content is basically an EAGL surface you render your
// OpenGL scene into.  Note that setting the view non-opaque will only work if
// the EAGL surface has an alpha channel.
@interface EAGLView : AR_EAGLView
{
    NSMutableArray* objectsPos;
    NSMutableArray* objectsNum;
    NSMutableArray* objectsRot;
    NSMutableArray* objectsZ;
    NSMutableArray* objectsSpeed;
    NSMutableArray* objectsSpeedVar;
}

@end
