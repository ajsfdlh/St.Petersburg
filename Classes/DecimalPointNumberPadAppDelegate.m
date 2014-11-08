//
//  DecimalPointNumberPadAppDelegate.m
//  DecimalPointNumberPad
//
//  Created by David Casserly on 13/03/2010.
//  Copyright devedup.com 2010. All rights reserved.
//

#import "DecimalPointNumberPadAppDelegate.h"
#import "TimeAndMoneyViewController.h"

@implementation DecimalPointNumberPadAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
//    [viewController release];
    [window release];
    [super dealloc];
}


@end
