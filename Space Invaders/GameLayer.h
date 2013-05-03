//
//  GameLayer.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "cocos2d.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyJoystick.h"

/*
    Main Game Layer. This class will cointain all of the current game elements. It will be responsible for adding the elements,
    delegating data between the elements and schedule updates for them.
 */

@interface GameLayer : CCLayer
{
    SneakyJoystick *leftJoystick;
    SneakyButton *attackButton;
}

-(void) initJoystickAndButtons;

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

@end
