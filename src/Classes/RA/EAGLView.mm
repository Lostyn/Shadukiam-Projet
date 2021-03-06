/*==============================================================================
 Copyright (c) 2012 QUALCOMM Austria Research Center GmbH.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary
 ==============================================================================*/

// Subclassed from AR_EAGLView
#import "EAGLView.h"
#import "Teapot.h"
#import "Texture.h"
#import "rocks.h"
#import "rock_stone_pile.h"
#import "key3.h"
#import "torch.h"
#import "rock.h"
#import "torch2.h"

#import <QCAR/Renderer.h>

#import "QCARutils.h"

#ifndef USE_OPENGL1
#import "ShaderUtils.h"
#endif

namespace {
    // Teapot texture filenames
    const char* textureFilenames[] = {
        "key.png",
        "rock.png",
        "torch.png"
    };

    // Model scale factor
    const float kObjectScale = 15.0f;
}


@implementation EAGLView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
	if (self)
    {
        // create list of textures we want loading - ARViewController will do this for us
        int nTextures = sizeof(textureFilenames) / sizeof(textureFilenames[0]);
        for (int i = 0; i < nTextures; ++i)
            [textureList addObject: [NSString stringWithUTF8String:textureFilenames[i]]];
    }
    return self;
}

- (void) setup3dObjects
{
    // build the array of objects we want drawn and their texture
    // in this example we have 3 targets and require 3 models
    // but using the same underlying 3D model of a teapot, differentiated
    // by using a different texture for each
    
    /*
    for (int i=0; i < [textures count]; i++)
    {
        Object3D *obj3D = [[Object3D alloc] init];

        obj3D.numVertices = NUM_TEAPOT_OBJECT_VERTEX;
        obj3D.vertices = teapotVertices;
        obj3D.normals = teapotNormals;
        obj3D.texCoords = teapotTexCoords;
        
        obj3D.numIndices = NUM_TEAPOT_OBJECT_INDEX;
        obj3D.indices = teapotIndices;
        
        obj3D.texture = [textures objectAtIndex:i];

        [objects3D addObject:obj3D];
    }
     */
    
    Object3D *key = [[Object3D alloc] init];
    
    key.numVertices = key3NumVerts;
    key.vertices = key3Verts;
    key.texCoords = key3TexCoords;
    //key.normals = key3Normals;
    
    key.texture = [textures objectAtIndex:0];
    
    [objects3D addObject:key];
    
    Object3D *torch = [[Object3D alloc] init];
    
    torch.numVertices = torch2NumVerts;
    torch.vertices = torch2Verts;
    torch.texCoords = torch2TexCoords;
    //torch.normals = torch2Normals;
    
    torch.texture = [textures objectAtIndex:2];
    
    [objects3D addObject:torch];
    
    Object3D *rock = [[Object3D alloc] init];
    
    rock.numVertices = rockNumVerts;
    rock.vertices = rockVerts;
    rock.texCoords = rockTexCoords;
    rock.normals = rockNormals;
    
    rock.texture = [textures objectAtIndex:1];
    
    [objects3D addObject:rock];
    
    
    objectsPos = [NSMutableArray array];
    objectsNum = [NSMutableArray array];
    
    [objectsNum addObject:[NSNumber numberWithInt:0]];
    [objectsPos addObject:[SPPoint pointWithX:-25 y:-70]];
    
    [objectsNum addObject:[NSNumber numberWithInt:0]];
    [objectsPos addObject:[SPPoint pointWithX:-5 y:0]];
    
    [objectsNum addObject:[NSNumber numberWithInt:0]];
    [objectsPos addObject:[SPPoint pointWithX:-40 y:5]];
    
    [objectsNum addObject:[NSNumber numberWithInt:0]];
    [objectsPos addObject:[SPPoint pointWithX:-27 y:57]];
    
    [objectsNum addObject:[NSNumber numberWithInt:0]];
    [objectsPos addObject:[SPPoint pointWithX:32 y:31]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:55 y:-80]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:40 y:-42]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:38 y:45]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:60 y:60]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-10 y:-25]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-45 y:45]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-55 y:55]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-52 y:25]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-49 y:-30]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-65 y:-4]];
    
    [objectsNum addObject:[NSNumber numberWithInt:1]];
    [objectsPos addObject:[SPPoint pointWithX:-68 y:-50]];
    
    // rochers
    if([InfosPartie getPhase] == 2) {
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-45 y:45]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-55 y:55]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-52 y:25]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-65 y:55]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-65 y:40]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-65 y:25]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-52 y:40]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-40 y:30]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-35 y:45]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-10 y:45]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:0 y:45]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-5 y:54]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-10 y:65]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:0 y:65]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-16 y:72]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-10 y:35]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-10 y:25]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-5 y:5]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-25 y:20]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:0 y:-5]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-10 y:15]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-16 y:-10]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-25 y:-20]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-50 y:-10]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-48 y:-28]];
        
        [objectsNum addObject:[NSNumber numberWithInt:2]];
        [objectsPos addObject:[SPPoint pointWithX:-58 y:-21]];
    }
    
    //[objectsNum addObject:[NSNumber numberWithInt:2]];
    //[objectsPos addObject:[SPPoint pointWithX:30 y:100]];
    
    objectsRot = [NSMutableArray array];
    objectsZ = [NSMutableArray array];
    objectsSpeed = [NSMutableArray array];
    objectsSpeedVar = [NSMutableArray array];
    
    for(int i = 0; i < [objectsNum count]; i++) {
        
        int initZ = 2;
        if([[objectsNum objectAtIndex:i] intValue] == 1) {
            if(arc4random() % 10 > 5) initZ = -2;
        } else if([[objectsNum objectAtIndex:i] intValue] == 2) {
            initZ = 0;
        }
        
        [objectsRot addObject:[NSNumber numberWithInt:arc4random() % 360]];
        [objectsZ addObject:[NSNumber numberWithInt:initZ]];
        [objectsSpeed addObject:[NSNumber numberWithFloat:0]];
        
        float speedVar = (arc4random() % 3 + 3);
        speedVar /= 100;
        NSLog(@"var speed : %f", speedVar);
        [objectsSpeedVar addObject:[NSNumber numberWithFloat:speedVar]];
    }
}


// called after QCAR is initialised but before the camera starts
- (void) postInitQCAR
{
    // These two calls to setHint tell QCAR to split work over multiple
    // frames.  Depending on your requirements you can opt to omit these.
    QCAR::setHint(QCAR::HINT_IMAGE_TARGET_MULTI_FRAME_ENABLED, 1);
    QCAR::setHint(QCAR::HINT_IMAGE_TARGET_MILLISECONDS_PER_MULTI_FRAME, 25);
    
    // Here we could also make a QCAR::setHint call to set the maximum
    // number of simultaneous targets                
    // QCAR::setHint(QCAR::HINT_MAX_SIMULTANEOUS_IMAGE_TARGETS, 2);
}

// modify renderFrameQCAR here if you want a different 3D rendering model
////////////////////////////////////////////////////////////////////////////////
// Draw the current frame using OpenGL
//
// This method is called by QCAR when it wishes to render the current frame to
// the screen.
//
// *** QCAR will call this method on a single background thread ***
- (void)renderFrameQCAR
{
    [self setFramebuffer];
    
    // Clear colour and depth buffers
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    // Render video background and retrieve tracking state
    QCAR::State state = QCAR::Renderer::getInstance().begin();
    QCAR::Renderer::getInstance().drawVideoBackground();
    
    //NSLog(@"active trackables: %d", state.getNumActiveTrackables());
    
    if (QCAR::GL_11 & qUtils.QCARFlags) {
        glEnable(GL_TEXTURE_2D);
        glDisable(GL_LIGHTING);
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_NORMAL_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    }
    
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    
    for (int i = 0; i < state.getNumActiveTrackables(); ++i) {
        // Get the trackable
        const QCAR::Trackable* trackable = state.getActiveTrackable(i);
        
        
        for(int i = 0; i < [objectsNum count]; i++) {
            
            int objectNum = [[objectsNum objectAtIndex:i] intValue];
            Object3D *obj3D = [objects3D objectAtIndex:objectNum];
            
            SPPoint *pos = [objectsPos objectAtIndex:i];
            int rotation = [[objectsRot objectAtIndex:i] intValue];
            float zPos = [[objectsZ objectAtIndex:i] floatValue];
            float speed = [[objectsSpeed objectAtIndex:i] floatValue];
            float speedVar = [[objectsSpeedVar objectAtIndex:i] floatValue];
            
            if((objectNum == 1 && [InfosJoueur getShowObjets]) || (objectNum == 0 && ![InfosJoueur getShowObjets]) || objectNum == 2) { 
        
        // Render using the appropriate version of OpenGL
        if (QCAR::GL_11 & qUtils.QCARFlags) {
            /*
            // Load the projection matrix
            glMatrixMode(GL_PROJECTION);
            glLoadMatrixf(qUtils.projectionMatrix.data);
            
            // Load the model-view matrix
            glMatrixMode(GL_MODELVIEW);
            glLoadMatrixf(modelViewMatrix.data);
            glTranslatef(pos.x, pos.y, -kObjectScale);
            glScalef(kObjectScale, kObjectScale, kObjectScale);
            
            // Draw object
            glBindTexture(GL_TEXTURE_2D, [obj3D.texture textureID]);
            glTexCoordPointer(2, GL_FLOAT, 0, (const GLvoid*)obj3D.texCoords);
            glVertexPointer(3, GL_FLOAT, 0, (const GLvoid*)obj3D.vertices);
            glNormalPointer(GL_FLOAT, 0, (const GLvoid*)obj3D.normals);
            glDrawElements(GL_TRIANGLES, obj3D.numIndices, GL_UNSIGNED_SHORT, (const GLvoid*)obj3D.indices);
             */
        }
#ifndef USE_OPENGL1
        else {
            // OpenGL 2
            
            
            QCAR::Matrix44F modelViewMatrix = QCAR::Tool::convertPose2GLMatrix(trackable->getPose());
            
            QCAR::Matrix44F modelViewProjection;
            
            ShaderUtils::translatePoseMatrix(pos.x, pos.y, kObjectScale / 2 + zPos, &modelViewMatrix.data[0]);
            ShaderUtils::scalePoseMatrix(kObjectScale, kObjectScale, kObjectScale, &modelViewMatrix.data[0]);
            ShaderUtils::rotatePoseMatrix(90, 1, 0, 0, &modelViewMatrix.data[0]);
            ShaderUtils::rotatePoseMatrix(rotation, 0, 1, 0, &modelViewMatrix.data[0]);
            ShaderUtils::multiplyMatrix(&qUtils.projectionMatrix.data[0], &modelViewMatrix.data[0], &modelViewProjection.data[0]);
            
            glUseProgram(shaderProgramID);
            
            glVertexAttribPointer(vertexHandle, 3, GL_FLOAT, GL_FALSE, 0, (const GLvoid*)obj3D.vertices);
            glVertexAttribPointer(normalHandle, 3, GL_FLOAT, GL_FALSE, 0, (const GLvoid*)obj3D.normals);
            glVertexAttribPointer(textureCoordHandle, 2, GL_FLOAT, GL_FALSE, 0, (const GLvoid*)obj3D.texCoords);
            
            glEnableVertexAttribArray(vertexHandle);
            glEnableVertexAttribArray(normalHandle);
            glEnableVertexAttribArray(textureCoordHandle);
            
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, [obj3D.texture textureID]);
            glUniformMatrix4fv(mvpMatrixHandle, 1, GL_FALSE, (const GLfloat*)&modelViewProjection.data[0]);
            //glDrawElements(GL_TRIANGLES, obj3D.numIndices, GL_UNSIGNED_SHORT, (const GLvoid*)obj3D.indices);
            glDrawArrays(GL_TRIANGLES, 0, obj3D.numVertices);
            
            ShaderUtils::checkGlError("EAGLView renderFrameQCAR");
            
            // si cle, rotation reguliere
            if(objectNum == 0) {
                rotation += 2;
                if(rotation > 360) rotation = 1;
                [objectsRot replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:rotation]];
            } else if (objectNum == 1) {
                // si feu, bondit
                if(zPos < 0) speed += speedVar;
                else speed -= speedVar;
                zPos += speed;
                //NSLog(@"%f, %f", zPos, speed);
                [objectsZ replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:zPos]];
                [objectsSpeed replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:speed]];
                
            }
        }
#endif
            }
        }
    }
    
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_CULL_FACE);
    
    if (QCAR::GL_11 & qUtils.QCARFlags) {
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_VERTEX_ARRAY);
        glDisableClientState(GL_NORMAL_ARRAY);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    }
#ifndef USE_OPENGL1
    else {
        glDisableVertexAttribArray(vertexHandle);
        glDisableVertexAttribArray(normalHandle);
        glDisableVertexAttribArray(textureCoordHandle);
    }
#endif
    
    QCAR::Renderer::getInstance().end();
    [self presentFramebuffer];
}

-(void) finalize {
    objects3D = nil;
    objectsNum =  nil;
    objectsPos = nil;
    objectsRot = nil;
    objectsSpeed = nil;
    objectsZ = nil;
}

@end
