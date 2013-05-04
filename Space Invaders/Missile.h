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

@interface Missile : CCSprite
{
    misileDirection direction;
}

@property (readwrite) misileDirection direction;

-(id) initWithFile: (NSString *) filename position:(CGPoint) thePosition andDirection:(misileDirection) theDirection;
-(void) advanceWithTimeDelta:(float) deltaTime;

@end
