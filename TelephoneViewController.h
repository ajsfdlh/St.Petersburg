//
//  TelephoneViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-15.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"HTCopyableLabel.h"

@interface TelephoneViewController : UIViewController<UIAlertViewDelegate,HTCopyableLabelDelegate>
@property(strong,nonatomic)IBOutlet UIImageView*imageView;
@property(strong,nonatomic)IBOutlet UIButton*signUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*signimageView;
@property(strong,nonatomic)IBOutlet UILabel*signLable;
@property(strong,nonatomic)IBOutlet UIButton*trafficUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*trafficimageView;
@property(strong,nonatomic)IBOutlet UILabel*trafficLable;
@property(strong,nonatomic)IBOutlet UIButton*embassyUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*embassyimageView;
@property(strong,nonatomic)IBOutlet UILabel*embassyLable;
@property(strong,nonatomic)IBOutlet UIButton*telephoneUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*telephoneimageView;
@property(strong,nonatomic)IBOutlet UILabel*telephoneLable;
@property(strong,nonatomic)IBOutlet UIButton*weatherUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*weatherimageView;
@property(strong,nonatomic)IBOutlet UILabel*weatherLable;
@property(strong,nonatomic)IBOutlet UIButton*moneyUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*moneyimageView;
@property(strong,nonatomic)IBOutlet UILabel*moneyLable;
@property(strong,nonatomic)IBOutlet UIButton*timeUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*timeimageView;
@property(strong,nonatomic)IBOutlet UILabel*timeLable;
@property(strong,nonatomic)IBOutlet UIButton*adviceUIButton;
@property(strong,nonatomic)IBOutlet UIImageView*adviceimageView;
@property(strong,nonatomic)IBOutlet UILabel*adviceLable;


@end
