//
//  GameObject.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize size;

-(void) processTurn:(CCArray *) gameObjects forTimeDelta:(float) deltaTime
{
    CCLOG(@"Method should be ovewritten!");
}

-(void)dealloc{
    size = nil;
    
    [super dealloc];
}
@end
