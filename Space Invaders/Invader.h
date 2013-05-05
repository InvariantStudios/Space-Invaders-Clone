//
//  Invader.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"
#import "GameConstants.h"

@interface Invader : GameObject

+(Invader *) CreateInvaderWithPosition:(CGPoint) thePosition;

@end
