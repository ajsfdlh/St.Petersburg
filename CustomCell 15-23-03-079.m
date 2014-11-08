//
//  CustomCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.userInteractionEnabled=YES;
            [button setImage:[UIImage imageNamed:@"mine_newsAndSet.png"] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"mine_newsAndSet_h.png"] forState:UIControlStateHighlighted];

            button.frame=CGRectMake(5, 0, 310, 60);
            [self addSubview:button];
            UILabel*lable1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 60)];
//            lable1.backgroundColor=[UIColor redColor];
        
            [button addSubview:lable1];
            UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 150, 60)];
//            lable2.backgroundColor=[UIColor blueColor];
            NSLog(@"%@lable2",self.textArray);
       
            [button addSubview:lable2];
            
       
        
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
