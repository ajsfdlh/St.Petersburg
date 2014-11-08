//
//  ComentCell.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-4.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComentCell : UITableViewCell
@property(nonatomic,strong)UIImageView*headImage;
@property(nonatomic,strong)RTLabel*name;
@property(nonatomic,strong)RTLabel*date;
@property(nonatomic,strong)RTLabel*comment;
@property(nonatomic,strong)UIImageView*_imageView;
@property(nonatomic,strong)UIButton* feedBackBtn;

@end
