//
//  LineCustomCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-25.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "LineCustomCell.h"

@implementation LineCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=GroupColor;
        self.backgroud=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 250)];
        self.backgroud.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.backgroud];
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 290, 180)];
        self._imageView.image=[UIImage imageNamed:@"homePic_1.jpg"];
        [self.backgroud addSubview:self._imageView];
        
//        self.dayCount=[[UIImageView alloc]initWithFrame:CGRectMake(5, 148, 40, 40)];
////        [self.backgroud addSubview:self.dayCount];
//        self.dayCount.image=[UIImage imageNamed:@"lineDay_one.png"];
        
        
        self.price=[[RTLabel alloc]initWithFrame:CGRectMake(220, 220, 80, 20)];
        self.price.textAlignment=RTTextAlignmentRight;
//        self.price.font=[UIFont systemFontOfSize:13];
//        self.price.textColor=[UIColor grayColor];
//        self.price.text=@"<font size=13>价格:<font color=orange>25860</font>元</font>";
        [self.backgroud addSubview:self.price];
        
        
        self.head=[[UILabel alloc]initWithFrame:CGRectMake(10, 195, 265, 25)];
        self.head.text=@"线路标题线路标题线路标题线路标题";
        [self.backgroud addSubview:self.head];
        
        self.intrdouce=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 265, 20)];
        self.intrdouce.text=@"线路标题线路标题线路标题线路标题";
        self.intrdouce.font=[UIFont systemFontOfSize:13];
        self.intrdouce.textColor=[UIColor grayColor];
        
        [self.backgroud addSubview:self.intrdouce];
//        self.coment=[[UIImageView alloc]initWithFrame:CGRectMake(130+20, 190, 20, 20)];
//        [self.backgroud addSubview: self.coment];
//         self.coment.image=[UIImage imageNamed:@"homeDiscuss.png"];
//        
//        self.comentCount=[[RTLabel alloc]initWithFrame:CGRectMake(155+20, 190, 0, 20)];
//        self.comentCount.text=@"1234";
//         self.comentCount.font=[UIFont systemFontOfSize:13];
//        [self.backgroud addSubview:self.comentCount];
//        
//       self.browse=[[UIImageView alloc]initWithFrame:CGRectMake(205+20, 190, 20, 20)];
//         self.browse.image=[UIImage imageNamed:@"line_collect.png"];
//         [self.backgroud addSubview: self.browse];
//        
//        self.browseCount=[[RTLabel alloc]initWithFrame:CGRectMake(230+20, 190, 0, 20)];
//          self.browseCount.font=[UIFont systemFontOfSize:13];
//        self.browseCount.backgroundColor=[UIColor clearColor];
//        self.browseCount.text=@"4444";
//        
//        [self.backgroud addSubview:self.browseCount];

        
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
