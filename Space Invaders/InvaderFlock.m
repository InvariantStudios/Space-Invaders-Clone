//
//  AlienFlock.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "InvaderFlock.h"

@implementation InvaderFlock

@synthesize invaders;
@synthesize direction;
@synthesize screenSize;
@synthesize invaderCount;

-(void) processTurn
{
    if ([self isAtEdge])
    {
        [self stopMoveByActions];
        [self toggleDirection];
        [self moveFlockDownYAxis];
    }
    else
    {
        for (NSMutableArray * row in invaders)
        {
            for (Invader * theInvader in row)
            {
                id action = [theInvader getActionByTag:kINVADER_MOVEBY_TAG];
                
                if( action != nil)
                {
                    continue;
                }
                else
                {
                    float timeDuration = [self getTimeDuration];
                    CGPoint nextPosition = [self getNextPosition];
                    CCMoveBy * action = [CCMoveBy actionWithDuration:timeDuration position:nextPosition];
                    [action setTag:kINVADER_MOVEBY_TAG];
                    [theInvader runAction:action];
                }
            }
        }
    }
}

-(void) stopMoveByActions
{
    for( NSMutableArray * row in invaders)
    {
        for (Invader * theInvader in row)
            [theInvader stopActionByTag:kINVADER_MOVEBY_TAG];
    }
}

-(void) stopAllAnimations
{
    for( NSMutableArray * row in invaders)
    {
        for (Invader * theInvader in row)
            [theInvader stopAllActions];
    }
}

-(id) init
{
    if ((self = [super init]))
    {
        direction = left;
        invaderCount = 0;
    }
    
    return self;
}

-(void) moveFlockDownYAxis
{
    float yOffset = 3 * kINVADER_Y_OFFSET_FACTOR * screenSize.height;
    
    //CCLOG(@"yOffset: %.1f pixels" , yOffset);
    
    for (NSMutableArray * row in self.invaders)
    {
        for( Invader * invader in row)
        {
            CGPoint oldPosition = [invader position];
            CGPoint newPosition = ccp(oldPosition.x, oldPosition.y - yOffset);
            
            //CCLOG(@"Old Position: x:%.1f , y:%.1f ; newPosition: %.1f, %.1f", oldPosition.x, oldPosition.y, newPosition.x, newPosition.y);
            
            [invader setPosition:newPosition];
        }
    }
    
    CCLOG(@"Flock moved down");
}

-(CGPoint) getNextPosition
{    
    float xBound = [self getXBound];
    
    float xPosition = (direction == left) ? xBound * -1.0f : screenSize.width - xBound;
    
    return ccp(xPosition, 0.0f);
}

-(float) getXBound
{

    float bound;
    
    if (self.direction == left)
    {
        for (int invaderIndex = 0; invaderIndex <= kINVADERS_PER_ROW - 1; ++invaderIndex)
        {
            for (int rowIndex = 0; rowIndex <= kINVADER_ROWS; ++rowIndex)
            {
                for(Invader * theInvader in [self.invaders objectAtIndex:rowIndex])
                {
                    if (theInvader.rowIndex == invaderIndex)
                    {
                        bound = theInvader.position.x - screenSize.width * kINVADER_X_OFFSET_FACTOR;
                        
                        return bound;
                    }
                }
            }
        }
    }
    
    else if( self.direction == right)
    {
        for (int invaderIndex = kINVADERS_PER_ROW - 1; invaderIndex >= 0 ; --invaderIndex)
        {
            for (int rowIndex = 0; rowIndex <= kINVADER_ROWS; ++rowIndex)
            {
                for(Invader * theInvader in [self.invaders objectAtIndex:rowIndex])
                {
                    if (theInvader.rowIndex == invaderIndex)
                    {
                        bound = theInvader.position.x + screenSize.width * kINVADER_X_OFFSET_FACTOR;
                        
                        return bound;
                    }
                }
            }
        }
    }
    
    return kNO_INVADERS_LEFT; //SHOULD NOT HAPPEN
}

-(float) getYBound
{
    float lowerYBound; 
    
    for (int i = kINVADER_ROWS; i >= 0 ; --i)
    {
        NSMutableArray * row = [invaders objectAtIndex:i];
        if ([row count] > 0)
        {
            for (Invader * theInvader in row)
            {
                lowerYBound = theInvader.position.y - screenSize.height * kINVADER_Y_OFFSET_FACTOR;
                return lowerYBound;
            }
        }
    }
    
    return kNO_INVADERS_LEFT; //SHOULD NOT HAPPEN
}

-(float) getTimeDuration
{
    return invaderCount * kTIME_FACTOR;
}

-(BOOL) isAtEdge
{
    float bound = [self getXBound];
    
    return (direction == left) ? (bound <= 0.0f) : (bound >= screenSize.width);
}

-(void) toggleDirection
{
    self.direction = (direction == left) ? right : left;
}

-(CGPoint) randomMissilePosition
{
    int rowSize;
    NSMutableArray * row;
    
    do
    {
        int randomRowIndex = (arc4random()%(kINVADER_ROWS + 1));
        
        row = [invaders objectAtIndex:randomRowIndex];
        
        rowSize = [row count];
        
    } while (rowSize <= 0 && invaderCount > 0);

    
        int randomInvaderIndex = (arc4random()%(rowSize));
    
        Invader * theInvader = [row objectAtIndex:randomInvaderIndex];
    
        return theInvader.position;
}

-(void) dealloc
{
    [invaders release];
    [super dealloc];
}

#pragma mark InvaderDelegate methods

-(void) invaderDidDie:(Invader *)theInvader
{
    NSMutableArray * row = [invaders objectAtIndex:theInvader.flockRowIndex];
    
    [row removeObject:theInvader];
    
    [theInvader release];
    
    --invaderCount;
}

@end
