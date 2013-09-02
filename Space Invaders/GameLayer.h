//
//  GameLayer.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "cocos2d.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyJoystick.h"
#import "Spaceship.h"
#import "Spaceship.h"
#import "GameConstants.h"
#import "InvaderFlock.h"


/*
    Main Game Layer. This class will cointain all of the current game elements. It will be responsible for adding the elements,
    delegating data between the elements and schedule updates for them.
 */

@interface GameLayer : CCLayer <SpaceshipDelegate>
{
    SneakyJoystick *leftJoystick;
    SneakyButton *attackButton;
    Spaceship *spaceship;
    NSMutableArray * gameObjects;
    CGSize screenSize;
    InvaderFlock *invaderFlock;
    float yBound;
    
}

@property (nonatomic, retain) InvaderFlock * invaderFlock;
@property (readwrite) float yBound;

-(void) initJoystickAndButtons;
-(void) checkInvaders;
-(void) endGame;
-(void) generateInvaderMissile;

-(InvaderFlock *) createInvaderFlock;

+(CCScene *) scene;

-(GameObject *) createGameObjectOfType:(gameObjectType) type withPosition:(CGPoint) thePosition andDirection:(missileDirection) theDirection;

@end
