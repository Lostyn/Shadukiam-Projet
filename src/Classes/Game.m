//
//  Game.m
//  AppScaffold
//

#import "Game.h" 

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation Game

static int stageWidth;
static int stageHeight;
static SPImage *logoBlack;

@synthesize gameWidth  = mGameWidth;
@synthesize gameHeight = mGameHeight;

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super init]))
    {
        mGameWidth = width;
        mGameHeight = height;
        
        [self setup];
    }
    return self;
}


- (void)setup
{
    // This is where the code of your game will start. 
    // In this sample, we add just a few simple elements to get a feeling about how it's done.
    
    [SPAudioEngine start];  // starts up the sound engine
    
    
    // The Application contains a very handy "Media" class which loads your texture atlas
    // and all available sound files automatically. Extend this class as you need it --
    // that way, you will be able to access your textures and sounds throughout your 
    // application, without duplicating any resources.
    
    //[Media initAtlas];      // loads your texture atlas -> see Media.h/Media.m
    //[Media initSound];      // loads all your sounds    -> see Media.h/Media.m
    
    stageWidth = mGameHeight;
    stageHeight = mGameWidth;
    xOrigin = -80;
    yOrigin = 80;
    
    SPImage *background = [SPImage imageWithContentsOfFile:@"fond.jpg"];
    background.x = xOrigin;
    background.y = yOrigin;
    [self addChild:background];
    
    logoBlack = [SPImage imageWithContentsOfFile:@"logo_default.png"];
    logoBlack.x = 36;
    logoBlack.y = 100;
    [self addChild:logoBlack];

    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(initGame:) userInfo:nil repeats:NO];
    
}

- (void) initGame:(NSTimer*) timer {
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // init epawn
    [[EpawnData getInstance] start:self.stage.nativeView];
    
    // init disposition
    [InfosDisposition genere];
     
    // pagemanager
    [self addChild:[PageManager getInstance]];
    [PageManager getInstance].x = xOrigin;
    [PageManager getInstance].y = yOrigin;

    [[PageManager getInstance] changePage:@"PagePlay"];
    // test TDB
    //[InfosPartie addPlayer:2 forPlayer:2];
    //[InfosPartie addPlayer:1 forPlayer:1];
    //[InfosJoueur setMyPerso:3];
    //[[PageManager getInstance] changePage:@"PageDice"];

    
    // menu
    [self addChild:[Menu getInstance]];
    [Menu getInstance].x = xOrigin;
    [Menu getInstance].y = yOrigin;
    [[Menu getInstance] initMenu]; 
    
    SPImage *barreDroite = [SPImage imageWithContentsOfFile:@"barre_droite.png"];
    barreDroite.x = 480 - barreDroite.width;
    
    
    //kill the timer
    [timer invalidate];
    timer = nil;
    
    [self getSounds];
}

-(void) getSounds{
    [SPAudioEngine start];
    
    [[ShadSounds getInstance] addSounds:@"caillou.caf" withKey:@"caillou"];
    [[ShadSounds getInstance] addSounds:@"dynamite.caf" withKey:@"dynamite"];
    [[ShadSounds getInstance] addSounds:@"flip.caf" withKey:@"flip"];
    [[ShadSounds getInstance] addSounds:@"indice.caf" withKey:@"indice"];
    [[ShadSounds getInstance] addSounds:@"meca1.caf" withKey:@"meca1"];
    [[ShadSounds getInstance] addSounds:@"meca2.caf" withKey:@"meca2"];
}

+ (void) hideLogo{
    logoBlack.alpha = 0;
}

+ (int)stageWidth {
    return stageWidth;
}

+ (int)stageHeight {
    return stageHeight;
}

@end
