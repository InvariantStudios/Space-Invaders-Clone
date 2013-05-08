//
//  GameLayer.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "GameLayer.h"
#import "Spaceship.h"
#import "GameConstants.h"
#import "Invader.h"

@implementation GameLayer

@synthesize invaderFlock;
@synthesize yBound;

/* 
 * Initializes the joystick and attack button for spaceship user controls
 */
-(void) initJoystickAndButtons
 {
    //Preset dimensions for the button and the joystick
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    
    //Position the controls on the screen 
    CGPoint joystickBasePosition;
    CGPoint attackButtonPosition;
     
     joystickBasePosition = ccp(2.5f * kINVADER_X_OFFSET_FACTOR * screenSize.width, 3.0f * kINVADER_Y_OFFSET_FACTOR * screenSize.height);

    attackButtonPosition = ccp(screenSize.width - 2.5f * kINVADER_X_OFFSET_FACTOR * screenSize.width , 3.0f * kINVADER_Y_OFFSET_FACTOR * screenSize.height);

    //Set up the Joystick base
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    joystickBase.position = joystickBasePosition;
    
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"JoystickBase.png"];
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"JoystickThumb.png"];
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    
    leftJoystick = [joystickBase.joystick retain];
    
    [self addChild:joystickBase];
    
    //Set up fire button base

    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    attackButtonBase.position = attackButtonPosition;
    
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile: @"JoystickBase.png"];
    
    attackButtonBase.activatedSprite = [CCSprite spriteWithFile: @"JoystickBase.png"];
    
    attackButtonBase.pressSprite = [CCSprite spriteWithFile: @"JoystickBase.png"];
    
    attackButtonBase.button = [[SneakyButton alloc] initWithRect: attackButtonDimensions];
    
    attackButton = [attackButtonBase.button retain];
    
    attackButton.isToggleable = NO;
    
    [self addChild:attackButtonBase];
}

+(CCScene *) scene
{
	// Container to hold the game layer.
	CCScene *scene = [CCScene node];
	
	// Create an autoreleased object of the game layer
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        gameObjects = [[NSMutableArray alloc] init];
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        [self initJoystickAndButtons];
        
        spaceship = (Spaceship *) [self createGameObjectOfType: spaceshipType
                                                  withPosition:[[CCDirector sharedDirector] convertToGL: ccp(screenSize.width /2 , screenSize.height * kSPACESHIP_POSITION_FACTOR)]
                                                  andDirection: noDirection];
        
        yBound = screenSize.height - screenSize.height * kY_BOUND_FACTOR;
        
        CCLOG(@"YBOUND: %.2f", yBound);
            
        self.invaderFlock = [self createInvaderFlock];
                
        [self scheduleUpdate];
        
        //[self schedule:@selector(updateFlock) interval:5.0f];
                
	}
    
	return self;
}

/* 
 * This method is called about 60 times a second by the cocos2d scheduler. It iterates through self.gameObjects
 * to allow every object to chech for collisions and update its position.
 */
-(void) update:(ccTime)deltaTime
{
    NSMutableArray *array = [gameObjects copy];
    
    for (GameObject * object in array)
        [object processTurn:gameObjects forTimeDelta:deltaTime];
    
    [array release];
    
    [self checkInvaders];
    
    [invaderFlock processTurn];
}

/*
 * This method creates a game object (Spaceship, Missile, Invader), the Game object will be initialized with the given position. 
 * This method will also add the new object to the gameObjects array and add it to the game layer.
 */
-(GameObject *) createGameObjectOfType: (gameObjectType) type withPosition:(CGPoint) thePosition andDirection:(missileDirection) theDirection
{
    if (type == spaceshipType)
    {

        Spaceship * theSpaceship = [Spaceship MakeSpaceShipWithPosition:thePosition
                                                           attackButton:attackButton
                                                            andJoystick:leftJoystick];
        
        [theSpaceship setDelegate:self];
        
        [gameObjects addObject:theSpaceship];
        
        [self addChild:theSpaceship z:100 tag:kSPACESHIPTAG];
                
        /* DEBUG */
        CCLOG(@"Created Spaceship");
       // CCLOG(@"GameObjects: %d" , [gameObjects count]);
        
        return theSpaceship;

    }
    else if ( type == missileType)
    {
        Missile * theMissile = [Missile CreateMissileWithPosition:thePosition andDirection:theDirection];
        
        [gameObjects addObject:theMissile];
        
        [self addChild: theMissile];
        
        /* DEBUG */
        //CCLOG(@"Created Missile");
       // CCLOG(@"GameObjects: %d" , [gameObjects count]);
        
        return theMissile;
    }
    
    else if (type == invaderType)
    {
        Invader * theInvader = [Invader CreateInvaderWithPosition:thePosition];
        
        [gameObjects addObject: theInvader];
                
        [self addChild: theInvader];
        
        
        /* DEBUG */
       // CCLOG(@"Created Invader");
        //CCLOG(@"GameObjects: %d" , [gameObjects count]);
        
        return theInvader;
    }
    
    return nil;
}



/*
 * Checks if the game is over. If there are no Invaders left or if the Invaders have reached the spacehsip.
 */
-(void) checkInvaders
{    
    float flockYBound = [invaderFlock getYBound];
    
    if (invaderFlock.invaderCount <= 0 || flockYBound <= yBound)
        [self endGame];
}


/*
 * Returns 2-dimensional array of invaders each index represents a row of enemies in the screen
 * All the Invades have been added to the layer and gameObjects
 */
-(InvaderFlock *) createInvaderFlock
{
    InvaderFlock *theFlock = [[InvaderFlock alloc] init];
    
    [theFlock setScreenSize:screenSize];
    
    NSMutableArray * grid = [[NSMutableArray alloc] init];
    
    NSMutableArray * row;
    
    // Padding that is equal to half of the sprite's size
    float xOffset = screenSize.width * kINVADER_X_OFFSET_FACTOR;
    float yOffset = screenSize.height * kINVADER_Y_OFFSET_FACTOR;
    
    // The last x-coordinate before we reahced the edge of the screen
    float finalXPosition = screenSize.width - (4 * xOffset);
    
    /*DEBUG*/
//    CCLOG(@"--------------INVADER GRID------------------------");
//    CCLOG(@"xOffset: %.2f" , xOffset);
//    CCLOG(@"yOffset: %.2f" , yOffset);
//    CCLOG(@"finalXPosition: %.2f" , finalXPosition);

    // The first row should start at twice the offset and the next row will be 3 offsets down
    int yIdx = 2;
    
    
    for (int rowIndex = 0 ; rowIndex <= kINVADER_ROWS; ++rowIndex)
    {
        row = [[NSMutableArray alloc] init];
        
        int i = 0;

        // The first invader starts off at 4 times the offset and the next one will be 3 offsets apart
        for (int xIdx = 4; xOffset * xIdx <=  finalXPosition; xIdx += 3)
        {
            CGPoint thePosition = [[CCDirector sharedDirector] convertToGL:ccp(xIdx * xOffset, yIdx * yOffset)];
            
            CCLOG(@"Invader: <%.2f , %.2f>", thePosition.x, thePosition.y);
            
            Invader * invader = (Invader *) [self createGameObjectOfType:invaderType withPosition:thePosition andDirection:noDirection];
            
            [invader setFlockRowIndex: rowIndex]; //used so we can remove the invader from the row when it dies
            
            [invader setDelegate:theFlock];
            
            [invader setRowIndex:i];
            
            theFlock.invaderCount += 1;
            
            [row insertObject:invader atIndex:i];
            
            ++i;
        }
        
        yIdx += 3; //position next row
        
        [grid insertObject:row atIndex:rowIndex];
    }
    
    theFlock.invaders = grid;
    
    return theFlock;
}


-(void) updateFlock
{
    [invaderFlock moveFlockDownYAxis];
    
    /*DEBUG*/
    //CCLOG(@"xBound: %.2f" , [invaderFlock getXBound]);
}

/*
 * GAME OVER MOTHERFUCKERS
 */
-(void) endGame
{
    CCLOG(@"Game Over");
    [self unscheduleUpdate];
    [invaderFlock stopAllAnimations];
}
#pragma mark SpaceshipDelegate Methods

/* Called when the user pressed the attack button. It will create a missile game object and add it to the array and layer */
-(void) didShootMissilefromPosition:(CGPoint) thePosition
{
    [self createGameObjectOfType:missileType withPosition:thePosition andDirection:down];
}

/* Called when the spaceship has been hit and the game is over */
-(void) playerDidDie
{
    CCLOG(@"Game Over");
}

- (void) dealloc
{
    [invaderFlock release];
	[super dealloc];
}

@end
