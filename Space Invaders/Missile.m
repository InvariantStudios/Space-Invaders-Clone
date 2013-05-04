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
    Missile * node = [[self alloc] initWithFile:@""];
    [node setPosition:thePosition];
    [node setDirection:theDirection];
    
    return node;
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

@end
