//
//  Missile.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "Missile.h"

@implementation Missile

@synthesize direction;

+(Missile *) CreateMissileWithPosition:(CGPoint) thePosition andDirection:(misileDirection) theDirection
{
    Missile * genericMissle = [[self alloc] initWithFile:@""];
    [genericMissle setPosition:thePosition];
    [genericMissle setDirection:theDirection];
      CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if ( theDirection == up)
    {
        CCAction * actionMove = [CCMoveTo actionWithDuration:1.5f position:ccp(thePosition.x, screenSize.height * (-.032f) )];
        [genericMissle runAction:actionMove];
    }
    else
    {
        CCAction * actionMove = [CCMoveTo actionWithDuration:1.5f position:ccp(thePosition.x, screenSize.height * (1.032) )];
        [genericMissle runAction:actionMove];
    }
    
    return genericMissle;
}

-(void) destroy
{
    [self setVisible:NO];
    [self removeFromParentAndCleanup:YES];
}

-(void) processTurn:(CCArray *) gameObjects forTimeDelta:(float) deltaTime
{
    
}


-(BOOL) isOutsideScreen
{
    CGPoint currentSpritePosition = [self position];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    if ((currentSpritePosition.y< 0.0f) || (currentSpritePosition.y > size.height))
    {
        [self destroy];
        return YES;
    }
    return NO;
}

-(void) dealloc{
    [super dealloc];
}
@end
