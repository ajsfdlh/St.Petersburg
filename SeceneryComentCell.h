//
//  SeceneryComentCell.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeceneryComentCell : UITableViewCell
@property(nonatomic,strong)UIImageView*userImage;
@property(nonatomic,strong)UILabel*userName;
@property(nonatomic,strong)UILabel*comentDate;
@property(nonatomic,strong)UIScrollView*_scrollView;
@property(nonatomic,strong)UIImageView*_imageView1;
@property(nonatomic,strong)UIImageView*_imageView2;
@property(nonatomic,strong)UIImageView*_imageView3;
@property(nonatomic,strong)UIImageView*_imageView4;
@property(nonatomic,strong)UIImageView*_imageView5;
@property(nonatomic,strong)UIImageView*_imageView6;
@property(nonatomic,strong)RTLabel*title;
@property(nonatomic,strong)UIButton*record;
@property(nonatomic,strong)UIImageView*addressImage;
@property(nonatomic,strong)UILabel*addressLable;

@property(nonatomic,strong)UIImageView*praiseImage;
@property(nonatomic,strong)UILabel*praiseLable;
@property(nonatomic,strong)UIButton*praise;

@property(nonatomic,strong)UIButton*grade;
@property(nonatomic,strong)UIImageView*gradeImage;
@property(nonatomic,strong)UILabel*gradeLable;

@property(nonatomic,strong)UIButton*comment;
@property(nonatomic,strong)UIImageView*commentImage;
@property(nonatomic,strong)UILabel*commentLable;
@property(nonatomic,strong)UIImageView*link;
@end
