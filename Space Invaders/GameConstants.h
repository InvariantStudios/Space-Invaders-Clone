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

#define kINVADER_MOVEBY_TAG 50

#define kINVADER_X_OFFSET_FACTOR 0.05f

#define kINVADER_Y_OFFSET_FACTOR 0.025f

#define kINVADER_ROWS 4

#define kSPACESHIP_POSITION_FACTOR 0.8f

#define kY_BOUND_FACTOR 0.734f

#define kNO_INVADERS_LEFT 3000.0f  //random number to flag if no invaders are left

#define kINVADERS_PER_ROW 5

#define  kTIME_FACTOR 0.5f

#define kINVADER_MISSILE_DELAY 4.0f

typedef enum
{   up,
    down,
    noDirection
} missileDirection;

typedef enum
{
    spaceshipType,
    invaderType,
    missileType
} gameObjectType;

typedef enum
{
    left,
    right
} flockDirection;

#endif
