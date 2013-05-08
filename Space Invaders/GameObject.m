//
//  GameObject.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/4/13.
//  Copyright 2013 Invariant Studios. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize size;
@synthesize gameObjectType;

-(void) processTurn:(NSMutableArray *) gameObjects forTimeDelta:(float) deltaTime
{
    CCLOG(@"Method should be ovewritten!");
}

-(void) destroySelfFromGameObjects:(NSMutableArray *) gameObjects
{
    [self setVisible:NO];
    [gameObjects removeObject:self];
    [self removeFromParentAndCleanup:YES];
}

-(void)dealloc{
    size = nil;
    
    [super dealloc];
}
@end
