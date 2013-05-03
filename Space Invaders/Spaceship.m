//
//  Spaceship.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "Spaceship.h"
#import "GameConstants.h"


@implementation Spaceship

@synthesize sprite = _sprite;
@synthesize score;
@synthesize isActive;
@synthesize delegate;


-(id) initWithSprite: (CCSprite *) theSprite
{
    if((self = [super init]))
    {
        _sprite = theSprite;
        score = kDEFAULTSCORE;
        isActive = YES;
    }
    
    return self;
}

-(void) shootMissile
{
    //TODO create missile and inform delegate that missile was fired.
    Missile *createdMissle = [[Missile alloc] init];
    [self.delegate didShootMissile:createdMissle];
    
}

-(void) updatePosition:(CGPoint) newLocation
{
    self.sprite.position = newLocation;
}

-(void) processTurn:(CCArray *) gameObjects
{
    //TODO AI implementation
}



@end
