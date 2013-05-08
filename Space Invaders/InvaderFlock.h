//
//  AlienFlock.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Missile.h"
#import "Invader.h"
#import "GameProtocols.h"


@interface InvaderFlock : NSObject <InvaderDelegate>
{
    NSMutableArray * invaders;
    flockDirection direction;
    CGSize screenSize;
    int invaderCount;
}

@property (readwrite) flockDirection direction;
@property (nonatomic, retain) NSMutableArray * invaders;
@property (readwrite) CGSize screenSize;
@property (readwrite) int invaderCount;


-(void) moveFlockDownYAxis;
-(float) getXBound;
-(float) getYBound;
-(float) getTimeDuration;
-(BOOL) isAtEdge;
-(void) toggleDirection;
-(void) stopMoveByActions;
-(void) stopAllAnimations;
-(CGPoint) getNextPosition;
-(void) processTurn;

@end
