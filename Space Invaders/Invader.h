//
//  Invader.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Invader : NSObject
{
    CCSprite *sprite;
}

@property (nonatomic, retain) CCSprite * sprite;

-(id) initWithSprite:(CCSprite *) theSprite;

@end
