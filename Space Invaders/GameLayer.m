//
//  GameLayer.m
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//
//

#import "GameLayer.h"

@implementation GameLayer

+(CCScene *) scene
{
	// Container to hold the game layer.
	CCScene *scene = [CCScene node];
	
	// Create an autoreleased object of the game layer
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		

	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
