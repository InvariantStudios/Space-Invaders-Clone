//
//  Spaceship.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "SneakyButton.h"
#import "SneakyJoystick.h"
#import "cocos2d.h"
#import "GameObject.h"
#import "Missile.h"

@protocol SpaceshipDelegate <NSObject>

-(void) didShootMissilefromPosition:(CGPoint) thePosition;
-(void) playerDidDie;

@end

@interface Spaceship : GameObject
{
    BOOL isActive;
    NSNumber * score;
    id <SpaceshipDelegate> delegate;
    SneakyJoystick *leftJoystick;
    SneakyButton *attackButton;
}

@property (readwrite) BOOL isActive;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) id <SpaceshipDelegate> delegate;
@property (nonatomic, retain) SneakyButton *attackButton;
@property (nonatomic, retain) SneakyJoystick *leftJoystick;

-(void) shootMissile;

-(void) applyJoystickForTimeDelta:(float) deltaTime;

-(void) checkBounds;

+(Spaceship *) MakeSpaceShipWithPosition:(CGPoint) thePosition attackButton:(SneakyButton *) attackButton andJoystick: (SneakyJoystick *) leftJoystick;

@end
