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

-(id) initWithFile: (NSString *) filename position:(CGPoint) thePosition andDirection:(misileDirection) theDirection
{
    if((self = [super initWithFile:filename]))
    {
        [self setPosition:thePosition];
        [self setDirection:theDirection];
    }
    
    return self;
}

-(void) advanceWithTimeDelta:(float) deltaTime
{
    
}

@end
