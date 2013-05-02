//
//  Missile.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "Missile.h"

@implementation Missile

@synthesize sprite;

-(id) initWithSprite:(CCSprite *)theSprite
{
    if ((self = [super init]))
    {
        self.sprite = theSprite;
    }
    
    return self;
}

@end
