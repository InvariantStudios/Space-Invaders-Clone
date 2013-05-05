//
//  Invader.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "Invader.h"
#import "GameConstants.h"

@implementation Invader

+(Invader *) CreateInvaderWithPosition:(CGPoint) thePosition
{
    Invader * theInvader = [[self alloc] initWithFile:@"Invader.png"];
    
    [theInvader setPosition:thePosition];
    [theInvader setGameObjectType: invaderType];
    
    return theInvader;
}

-(void) processTurn:(NSMutableArray *) gameObjects forTimeDelta:(float) deltaTime
{
    for( GameObject *current in gameObjects)
    {
       if (current.gameObjectType == missileType)
       {
           if (CGRectIntersectsRect([self boundingBox], [current boundingBox]))
           {
               [current destroySelfFromGameObjects:gameObjects];
               
               id action = [CCRotateBy actionWithDuration:0.5f angle:360];
               
               CCSequence * actions = [CCSequence actionOne: action two:[CCCallBlock actionWithBlock:^(void)
                                                                         {
                                                                             [self destroySelfFromGameObjects:gameObjects];
                                                                         }]];
                                       
               [self runAction:actions];
                                       
               break;
           }
       }
    }
}

@end
