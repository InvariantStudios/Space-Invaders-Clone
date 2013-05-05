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

+(Missile *) CreateMissileWithPosition:(CGPoint) thePosition andDirection:(missileDirection) theDirection
{
    Missile * genericMissile = [[self alloc] initWithFile:@"Icon.png"];
    [genericMissile setPosition:thePosition];
    [genericMissile setDirection:theDirection];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if ( theDirection == up)
    {
        CCAction * actionMove = [CCMoveTo actionWithDuration:1.5f position:ccp(thePosition.x, screenSize.height * (-.032f) )];
        [genericMissile runAction:actionMove];
    }
    else
    {
        CCAction * actionMove = [CCMoveTo actionWithDuration:1.5f position:ccp(thePosition.x, screenSize.height * (1.032) )];
        [genericMissile runAction:actionMove];
    }
    
    return genericMissile;
}

-(void) destroy
{
    [self setVisible:NO];
    [self removeFromParentAndCleanup:YES];
}

-(void) processTurn:(NSMutableArray *) gameObjects forTimeDelta:(float) deltaTime
{
    if ([self isOutsideScreen])
    {
        [gameObjects removeObject:self];
    }
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
