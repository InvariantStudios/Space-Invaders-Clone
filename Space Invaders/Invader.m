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

@synthesize flockRowIndex;
@synthesize rowIndex;
@synthesize delegate;

+(Invader *) CreateInvaderWithPosition:(CGPoint) thePosition
{
    Invader * theInvader = [[self alloc] initWithFile:@"Invader2.png"];
            
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
               
               [current release];
               
               id action = [CCRotateBy actionWithDuration:0.3f angle:360];
               
               CCSequence * actions = [CCSequence actionOne: action two:[CCCallBlock actionWithBlock:^(void)
                                                                         {
                                                                             [self destroySelfFromGameObjects:gameObjects];
                                                                             [delegate invaderDidDie:self];
                                                                         }]];
               [self runAction:actions];
                                       
               break;
           }
       }
    }
}

-(void) dealloc
{
    [delegate release];
    [super dealloc];
}

@end
