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
    
    
    joystickBasePosition = [[CCDirector sharedDirector] convertToGL:ccp(screenSize.width*0.0625f,
                                                                        screenSize.height*0.9583f)];

    attackButtonPosition = [[CCDirector sharedDirector] convertToGL:ccp(screenSize.width*0.75f,
                                                                            screenSize.height*0.9583f)];
    
    /* DEBUG */
    CCLOG(@"%0.2f X  %0.2f", screenSize.width , screenSize.height);
    
    
    //Set up the Joystick base
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    joystickBase.position = joystickBasePosition;
    
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"dpadDown.png"];
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickDown.png"];
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    
    leftJoystick = [joystickBase.joystick retain];
    
    [self addChild:joystickBase];
    
    //Set up fire button base

    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    attackButtonBase.position = attackButtonPosition;
    
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile: @"handUp.png"];
    
    attackButtonBase.activatedSprite = [CCSprite spriteWithFile: @"handDown.png"];
    
    attackButtonBase.pressSprite = [CCSprite spriteWithFile: @"handDown.png"];
    
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
                                                  withPosition:ccp( screenSize.width /2 , screenSize.height/2 )
                                                  andDirection: noDirection];
    
        [self createGameObjectOfType:invaderType withPosition:ccp(spaceship.position.x, spaceship.position.y + 200.0f) andDirection:noDirection];
                
        [self scheduleUpdate];
        
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
        CCLOG(@"Created Missile");
       // CCLOG(@"GameObjects: %d" , [gameObjects count]);
        return theMissile;
    }
    
    else if (type == invaderType)
    {
        Invader * theInvader = [Invader CreateInvaderWithPosition:thePosition];
        
        [gameObjects addObject: theInvader];
        
        [self addChild: theInvader];
        
        /* DEBUG */
        CCLOG(@"Created Invader");
        //CCLOG(@"GameObjects: %d" , [gameObjects count]);
        return theInvader;
    }
    
    return nil;
}

-(void) checkInvaders
{
    int counter = 0;
    for (GameObject * object in gameObjects)
    {
        if (object.gameObjectType == invaderType)
            ++ counter;
    }
    
    if (counter <= 0)
    {
        int offset = arc4random() % 330;

        [self createGameObjectOfType:invaderType
                        withPosition:ccp(offset, spaceship.position.y + 200.0f)
                        andDirection:noDirection];
    }
}

#pragma mark SpaceshipDelegate Methods

/* Called when the user pressed the attack button. It will create a missile game object and add it to the array and layer */
-(void) didShootMissilefromPosition:(CGPoint) thePosition
{
    CCLOG(@"Did shoot");
    [self createGameObjectOfType:missileType withPosition:thePosition andDirection:down];
}

/* Called when the spaceship has been hit and the game is over */
-(void) playerDidDie
{
    
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
