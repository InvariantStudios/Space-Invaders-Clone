//
//  Spaceship.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "Spaceship.h"
#import "GameConstants.h"


@implementation Spaceship

//Create accessor and mutator methods for our instance variables
@synthesize score;
@synthesize isActive;
@synthesize delegate;
@synthesize attackButton;
@synthesize leftJoystick;

/*
 *  This method informs the delegate that we want our spaceship to fire
 *  a missile. 
 */
-(void) shootMissile
{
    [self.delegate didShootMissile];
}

/*
 *  Main AI method for the spaceship. This method will do the following:
 *  1) Check for collisions from enemy missiles (contained in gameObjects)
 *  2) Update its position from joystick
 *  3) Check if the user pressed the attack button and inform the delegate
 */
-(void) processTurn:(CCArray *) gameObjects forTimeDelta:(float) deltaTime
{
    //TODO # 1
    
    /* Update Position */
    [self applyJoystickForTimeDelta:deltaTime];
    
    
    /* Check if user wants to shoot */
    if (attackButton.value == 0)
        isActive = YES;
    
    if ( attackButton.value == 1 && isActive)
    {
        isActive = NO;
        [delegate didShootMissile];
    }
}

/*
 * This method updates the spaceship position by adjusting the current position
 *  with the joystick's velocity multiplied by the difference in time since the 
 *  last update
 *  X = X0 + Vdt (see kinnematic equation for possition)
 */
-(void)applyJoystickForTimeDelta:(float) deltaTime
{
    // Scale the Joystick's velocity relative to the device's screen size
    CGPoint scaledVelocity = ccpMult(leftJoystick.velocity, 320.0f);
    
    // Spaceship's new position based on the equation X = X0 + Vdt, y coordinate does not change
    CGPoint newPosition = ccp(self.position.x + scaledVelocity.x * deltaTime, self.position.y /*+ scaledVelocity.y * deltaTime*/);
    
    [self setPosition:newPosition];
    
    // Make sure the spaceship stays within the screen bounds
    [self checkBounds];
}

/*
 * Checks that the spaceship never moves out of the screen
 */
-(void) checkBounds
{
    CGPoint currentPosition = [self position];
    
    // If the spaceship's left bound moves to close to the screen's left edge clamp the sprite's position, same for right bound.
    if (currentPosition.x < 24.0f)
        [self setPosition:ccp(24.0f, currentPosition.y)];
    
    else if (currentPosition.x > 296.0f)
        [self setPosition:ccp(296.0f, currentPosition.y)];
}

+(Spaceship *) MakeSpaceShipWithPosition:(CGPoint) thePosition attackButton:(SneakyButton *) attackButton andJoystick: (SneakyJoystick *) leftJoystick{
    Spaceship *genericShip = [[Spaceship alloc] init];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    [genericShip setPosition:ccp( screenSize.width /2 , screenSize.height/2 )];
    
    [genericShip setAttackButton:attackButton];
    [genericShip setLeftJoystick:leftJoystick];
    
    return genericShip;
}

-(void) dealloc{
    [delegate release];
    [attackButton release];
    [leftJoystick release];
    [score release];
    [delegate release];
    [super dealloc];
}



@end
