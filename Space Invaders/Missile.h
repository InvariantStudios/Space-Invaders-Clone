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
    misileDirection direction;
}

@property (readwrite) misileDirection direction;

+(Missile *) CreateMissileWithPosition:(CGPoint) thePosition andDirection:(misileDirection) theDirection;
-(void) destroy;
-(BOOL) isOutsideScreen;

@end
