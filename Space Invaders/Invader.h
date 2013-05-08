//
//  Invader.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"
#import "GameConstants.h"
#import "GameProtocols.h"

@interface Invader : GameObject
{
    int flockRowIndex;
    int rowIndex;
    id <InvaderDelegate> delegate;
}

@property (readwrite) int flockRowIndex;
@property (readwrite) int rowIndex;
@property (nonatomic, retain) id <InvaderDelegate> delegate;

+(Invader *) CreateInvaderWithPosition:(CGPoint) thePosition;

@end


