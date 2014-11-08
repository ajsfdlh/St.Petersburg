//
//  LineDetailCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "LineDetailCell.h"

@implementation LineDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.link=[[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 320, 1)];
        self.link.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self addSubview:self.link];
        
        
        
        UIImageView*_imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 34)];
        _imageView.image=[UIImage imageNamed:@"LineDetail_day.png"];
        [self addSubview:_imageView];
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 60, 34)];
        lable.text=@"第2天";
        lable.textColor=[UIColor whiteColor];
        lable.font=[UIFont systemFontOfSize:15];
        [_imageView addSubview:lable];
        
        
        
        self.titleLable=[[RTLabel alloc]initWithFrame:CGRectMake(10, 40, 300, 60)];
        [self addSubview:self.titleLable];
        
        UIImageView*_imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(260, 5, 50, 20)];
         _imageView2.image=[UIImage imageNamed:@"LineDetail_lookDetail.png"];
        [self addSubview:_imageView2];
        
        
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
