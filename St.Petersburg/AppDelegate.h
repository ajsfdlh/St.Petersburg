//
//  AppDelegate.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-8.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL isTime;
@property (strong, nonatomic)Reachability*rea;

- (void)numberGo;

@end
