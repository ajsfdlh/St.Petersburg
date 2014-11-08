//
//  NumberView.h
//  button
//
//  Created by li on 14-4-1.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTLabel;
@interface NumberView : UIView
@property (nonatomic , retain)UIImageView *IV;
@property (nonatomic , retain)RTLabel *numberLabel;
- (void)received:(NSNotification*)notfi;
@end
