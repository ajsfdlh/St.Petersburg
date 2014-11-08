//
//  MainTabarController.h
//  Russia Online
//
//  Created by 刘 吕琴 on 13-12-19.
//  Copyright (c) 2013年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface MainTabarController : UITabBarController<UITabBarControllerDelegate>
{
    NSArray *highlightImageNames;
     NSArray *normalImageNames;
    int count;
    NSArray*buttonArray;
    NSArray*highbuttonArray;
}
@property (nonatomic,strong)NSArray* imageArray;
@property (nonatomic,strong)NSArray* tittleArray;
@property (nonatomic,strong)NSArray* buttonImageArray;
@property (nonatomic,strong)NSArray* highbuttonImageArray;

@property (nonatomic,retain)UIImageView* sliderImageView;


@property(nonatomic,strong)UIView* customizedBar;

@property(nonatomic,strong)UIButton* tabbarItem;


@end
