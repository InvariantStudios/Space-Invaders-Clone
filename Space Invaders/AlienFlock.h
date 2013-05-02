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

@protocol InvaderFlockDelegate <NSObject>

-(void) invader: (Invader *) theInvader didFireMissile: (Missile *) theMissile;
-(void) flockDidMoveDowntoLocation:(CGPoint) newLocation;
-(void) invaderKilled:(Invader *) theInvader;

@end

@interface AlienFlock : NSObject
{
    CCArray * aliens;
    id <InvaderFlockDelegate> delegate;
    
}

@end
