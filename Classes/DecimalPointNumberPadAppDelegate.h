//
//  DecimalPointNumberPadAppDelegate.h
//  DecimalPointNumberPad
//
//  Created by David Casserly on 13/03/2010.
//  Copyright devedup.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeAndMoneyViewController;

@interface DecimalPointNumberPadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TimeAndMoneyViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TimeAndMoneyViewController *viewController;

@end

