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

@implementation GameLayer

-(void) initJoystickAndButtons
 {
    
    //Retrieve the screen boundaries from the director
   // CGSize screenSize = [CCDirector sharedDirector].winSize;
    
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
    
    NSLog(@"%0.2f X  %0.2f", screenSize.width , screenSize.height);
    
    
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

// on "init" you need to initialize your instance
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
        
        [self addChild:spaceship];
        
        [self scheduleUpdate];
        
	}
	return self;
}

-(void) update:(ccTime)deltaTime
{
    [spaceship processTurn:nil forTimeDelta:deltaTime];
}

-(GameObject *) createGameObjectOfType: (gameObjectType) type withPosition:(CGPoint) thePosition andDirection:(missileDirection) theDirection
{
    if (type == spaceshipType)
    {
        Spaceship * theSpaceship;
        
        theSpaceship = [[Spaceship alloc] initWithFile:@"Spaceship.png"];
        
        [theSpaceship setPosition: thePosition];
        
        [theSpaceship setAttackButton:attackButton];
        [theSpaceship setLeftJoystick:leftJoystick];
        [theSpaceship setDelegate:self];
        
        [gameObjects addObject:theSpaceship];
        
        return theSpaceship;
    }
    else if ( type == missileType)
    {
        Missile * missile = [Missile CreateMissileWithPosition:thePosition andDirection:theDirection];
        
        [gameObjects addObject:missile];
        
        return missile;
    }
    
    return nil;
}

-(void) didShootMissile
{
    CCLOG(@"Did shoot");
}

-(void) playerDidDie
{
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
