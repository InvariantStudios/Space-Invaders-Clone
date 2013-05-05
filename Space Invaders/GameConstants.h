//
//  GameConstants.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/2/13.
//
//

#ifndef Space_Invaders_GameConstants_h
#define Space_Invaders_GameConstants_h

#define kDEFAULTSCORE 0

#define kSPACESHIPTAG 10

//Helps detect if a misile was shot by our ship or by an invader
typedef enum
{ up, down, noDirection } missileDirection;

typedef enum
{
   spaceshipType,
    invaderType,
    invaderFlockType,
    missileType
} gameObjectType;

#endif
