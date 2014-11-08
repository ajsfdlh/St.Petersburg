//
//  TextImageViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextImageViewController : UIViewController
{
    Navbar*navBar;
    UIScrollView*_scrollView;
    float a;
}
@property(nonatomic,strong)NSString*navName;
@property(nonatomic,assign)int tag;
@property(nonatomic,strong)NSArray*titleArray;
@property(nonatomic,strong)NSArray*imageArray;
@property(nonatomic,assign)int collectTag;

@end
