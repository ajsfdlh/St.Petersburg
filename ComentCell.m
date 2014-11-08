//
//  ComentCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-4.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "ComentCell.h"

@implementation ComentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = BLACK_VIEW_COLOR;
        self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 40, 40)];
        self.headImage.image = BACK_IMAGE;
        [self.contentView addSubview:self.headImage];
        
        self.name=[[RTLabel alloc]initWithFrame:CGRectMake(60, 8, 250, 20)];
       // self.name.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"skyBlue.png"]];
        self.name.font=[UIFont systemFontOfSize:12.5];
        [self.contentView addSubview:self.name];
        
        self.date=[[RTLabel alloc]initWithFrame:CGRectMake(145, 10, 155, 20)];
        self.date.textColor=[UIColor grayColor];
        self.date.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.date];
        
        self.comment=[[RTLabel alloc]initWithFrame:CGRectMake(60, 30, 250, 0)];
        self.comment.font=[UIFont systemFontOfSize:12.5];
        [self.contentView addSubview:self.comment];
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 320, 2)];
        self._imageView.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self.contentView addSubview: self._imageView];
        
        self.feedBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //self.feedBackBtn.frame = CGRectMake(250, 20, 50, 30);
        [self.feedBackBtn setImage:[UIImage imageNamed:@"feedback.png"] forState:UIControlStateNormal];
        [self.feedBackBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 19)];
        
        [self.feedBackBtn setTitle:@"投诉" forState:UIControlStateNormal];
        [self.feedBackBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.feedBackBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.feedBackBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [self.contentView addSubview:self.feedBackBtn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
