//
//  AppDelegate.h
//  Space Invaders
//
//  Created by Ruben Flores on 5/1/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

//TEST COMMENT

//TEST COMMENT2

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
