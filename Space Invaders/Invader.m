//
//  Invader.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "Invader.h"

@implementation Invader

@synthesize sprite;

-(id) initWithSprite:(CCSprite *)theSprite
{
    if ((self = [super init]))
    {
        self.sprite = theSprite;
    }
    
    return self;
}

-(void) dealloc{
    [sprite release];
    [super dealloc];
}
@end
