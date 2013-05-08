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
    Missile * genericMissile = [[self alloc] initWithFile:@"Missile.png"];
    [genericMissile setPosition:thePosition];
    [genericMissile setDirection:theDirection];
    [genericMissile setGameObjectType:missileType];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if ( theDirection == up)
    {
        CCAction * actionMove = [CCMoveTo actionWithDuration:1.0f position:ccp(thePosition.x, screenSize.height * (-.032f) )];
        [genericMissile runAction:actionMove];
    }
    else
    {
        CCAction * actionMove = [CCMoveTo actionWithDuration:1.0f position:ccp(thePosition.x, screenSize.height * (1.032) )];
        [genericMissile runAction:actionMove];
    }
    
    return genericMissile;
}

-(void) processTurn:(NSMutableArray *) gameObjects forTimeDelta:(float) deltaTime
{
    if ([self isOutsideScreen])
    {        
        [self destroySelfFromGameObjects:gameObjects];
    }
}


-(BOOL) isOutsideScreen
{
    CGPoint currentSpritePosition = [self position];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    if ((currentSpritePosition.y< 0.0f) || (currentSpritePosition.y > size.height))
    {
        return YES;
    }
    return NO;
}

@end
