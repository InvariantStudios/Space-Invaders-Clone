//
//  GameProtocols.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/6/13.
//
//

#ifndef Space_Invaders_GameProtocols_h
#define Space_Invaders_GameProtocols_h

@class Invader;

@protocol InvaderDelegate <NSObject>

@required
-(void) invaderDidDie:(Invader *) theInvader;

@end

@protocol SpaceshipDelegate <NSObject>

-(void) didShootMissilefromPosition:(CGPoint) thePosition;
-(void) playerDidDie;

@end


#endif
