//
//  Game.h
//  AppScaffold
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "PageManager.h"
#import "Menu.h"
#import "InfosJoueur.h"
#import "EpawnData.h"
#import "InfosDisposition.h"

@interface Game : SPSprite
{
  @private 
    float mGameWidth;
    float mGameHeight;
    int xOrigin;
    int yOrigin;
}

- (id)initWithWidth:(float)width height:(float)height;
+ (int)stageWidth;
+ (int)stageHeight;
+ (void) hideLogo;

@property (nonatomic, assign) float gameWidth;
@property (nonatomic, assign) float gameHeight;


@end
