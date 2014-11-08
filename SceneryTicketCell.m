//
//  SceneryTicketCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SceneryTicketCell.h"

@implementation SceneryTicketCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        self.backGround=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        self.backGround.userInteractionEnabled=YES;
        [self addSubview: self.backGround];
        
        
        self.head=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
        //self.head.text=@"成人票";
        self.head.font=[UIFont systemFontOfSize:16];
        [self.backGround addSubview:self.head];
        
        self.validData=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 240, 15)];
        //self.validData.text=@"有效期:2014.03.21-2014.04.01";
        self.validData.font=[UIFont systemFontOfSize:14];
        self.validData.textColor=[UIColor grayColor];
        [self.backGround addSubview:self.validData];
        
        
        self.price=[[RTLabel alloc]initWithFrame:CGRectMake(230, 10, 80, 30)];
        //self.price.text=@"¥<font size=20 color=orange>520</font>";
        self.price.textAlignment=RTTextAlignmentRight;
        [self.backGround addSubview:self.price];
        
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(250, 40, 59, 25);
        _button.layer.cornerRadius=4;
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        [_button setTitle:@"预订" forState:UIControlStateNormal];
        
        [self.backGround addSubview:_button];

        
        
        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, 84, 320, 1)];
        link.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self.backGround addSubview:link];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
