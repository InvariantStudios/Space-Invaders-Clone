//
//  GameObject.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameObject : CCSprite
{
    CGSize * size;
}

@property (readwrite) CGSize * size;
    
-(void) processTurn:(CCArray *) gameObjects forTimeDelta:(float) deltaTime;

@end
