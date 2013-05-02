//
//  Spaceship.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Missile.h"

@protocol SpaceshipDelegate <NSObject>

-(void) didShootMissile:(Missile *) theMissile;
-(void) playerDidDie;

@end

@interface Spaceship : NSObject
{
    CCSprite * sprite;
    BOOL isActive;
    NSNumber * score;
    id <SpaceshipDelegate> delegate;
}

@property (nonatomic, retain) CCSprite * sprite;
@property (readwrite) BOOL isActive;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) id <SpaceshipDelegate> delegate;

-(id) initWithSprite: (CCSprite *) theSprite;

-(void) shootMissile;

-(void) updatePosition:(CGPoint) newLocation;

-(void) processTurn:(CCArray *) gameObjects;

@end
