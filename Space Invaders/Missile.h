//
//  Missile.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConstants.h"
#import "GameObject.h"

@interface Missile : GameObject
{
    missileDirection direction;
}

@property (readwrite) missileDirection direction;

+(Missile *) CreateMissileWithPosition:(CGPoint) thePosition andDirection:(missileDirection) theDirection;
-(BOOL) isOutsideScreen;

@end
