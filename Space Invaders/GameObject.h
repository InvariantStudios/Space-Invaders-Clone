//
//  GameObject.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConstants.h"

@interface GameObject : CCSprite
{
    gameObjectType gameObjectType;
}

@property (readwrite) CGSize * size;
@property (readwrite) gameObjectType gameObjectType;

    
-(void) processTurn:(NSMutableArray *) gameObjects forTimeDelta:(float) deltaTime;
-(void) destroySelfFromGameObjects:(NSMutableArray *) gameObjects;

@end
