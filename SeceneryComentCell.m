//
//  SeceneryComentCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SeceneryComentCell.h"

@implementation SeceneryComentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"groupTableView.png"]];
        self.userImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 35, 35)];
        self.userImage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        [self addSubview:self.userImage];
        
        self.userName=[[UILabel alloc]initWithFrame:CGRectMake(50, 15, 80, 15)];
        self.userName.font=[UIFont systemFontOfSize:12];
        self.userName.text=@"yonghuming";
        self.userName.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
      
        
        [self addSubview:self.userName];
        
        self.comentDate=[[UILabel alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x+self.userName.frame.size.width+5, 15, 200, 15)];
        self.comentDate.font=[UIFont systemFontOfSize:12];
        self.comentDate.textColor=[UIColor grayColor];
        self.comentDate.text=@"2014.3.21 4.4";
        [self addSubview:self.comentDate];

        
        self._scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(50, 35, 260, 195)];
        self._scrollView.pagingEnabled=YES;
        [self addSubview:self._scrollView];
        
        
        self.title=[[RTLabel alloc]initWithFrame:CGRectMake(50, self._imageView1.frame.origin.y+self._imageView1.frame.size.height+5, 260, 40)];
        
        [self addSubview:self.title];
        
        
      
        
        
        self.addressImage=[[UIImageView alloc]initWithFrame:CGRectMake(10,  self.title.frame.origin.y+self.title.frame.size.height+5, 10, 10)];
        self.addressImage.image=[UIImage imageNamed:@"secenery_location"];
        [self addSubview:self.addressImage];
        
        self.addressLable=[[UILabel alloc]initWithFrame:CGRectMake(22,self.addressImage.frame.origin.y, 100, 10)];
        self.addressLable.font=[UIFont systemFontOfSize:12];
        self.addressLable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        self.addressLable.text=@"圣彼得堡友谊大街5号";
        [self addSubview:self.addressLable];
        
      
        
        self.commentLable=[[UILabel alloc]initWithFrame:CGRectMake(270, 0, 40, 12)];
        self.commentLable.text=@"评论1";
        self.commentLable.textColor=[UIColor grayColor];
        self.commentLable.font=[UIFont systemFontOfSize:12];
        CGSize size2=[self.commentLable sizeThatFits:CGSizeMake(0, 10)];
      
        
    
       
       
        
        
        
        self.commentImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        self.commentImage.image=[UIImage imageNamed:@"secenery_commentCount.png"];
        
      
        
        self.comment=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.comment setBackgroundImage:[UIImage imageNamed:@"groupColor.png"] forState:UIControlStateNormal];
        self.comment.frame=CGRectMake(310-12-size2.width, self.addressImage.frame.origin.y, 12+size2.width, 12);
        
         self.commentImage.frame=CGRectMake(0, 0, 12, 12);
        
        self.commentLable.frame=CGRectMake(12, 0, size2.width, 12);
        
        [self addSubview:self.comment];
        [self.comment addSubview:self.commentImage];
        [self.comment addSubview:self.commentLable];
       
        
        
        self.gradeLable=[[UILabel alloc]initWithFrame:CGRectMake(270, 80, 40, 10)];
        self.gradeLable.text=@"总分20";
        self.gradeLable.textColor=[UIColor grayColor];
        self.gradeLable.font=[UIFont systemFontOfSize:12];
        CGSize size3=[self.gradeLable sizeThatFits:CGSizeMake(0, 10)];
       
      
        self.gradeImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.gradeLable.frame.origin.x-12, 80, 12, 12)];
        self.gradeImage.image=[UIImage imageNamed:@"secenery_gradeCount.png"];
       
        self.grade=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.grade setBackgroundImage:[UIImage imageNamed:@"groupColor.png"] forState:UIControlStateNormal];
        
        self.grade.frame=CGRectMake(self.comment.frame.origin.x-12-size3.width-5, self.addressImage.frame.origin.y, 12+size3.width, 12);
        self.gradeLable.frame=CGRectMake(12, 0, size3.width, 12);
        self.gradeImage.frame=CGRectMake(0, 0, 12, 12);
        
        [self addSubview:self.grade];
        [self.grade addSubview:self.gradeImage];
        [self.grade addSubview:self.gradeLable];

        
        
        self.praiseLable=[[UILabel alloc]initWithFrame:CGRectMake(270, 80, 40, 10)];
        self.praiseLable.text=@"赞3";
        self.praiseLable.textColor=[UIColor grayColor];
        self.praiseLable.font=[UIFont systemFontOfSize:12];
        CGSize size4=[self.praiseLable sizeThatFits:CGSizeMake(0, 10)];
        
        
        self.praiseImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.praiseLable.frame.origin.x-12, 80, 12, 12)];
        self.praiseImage.image=[UIImage imageNamed:@"secenery_praise.png"];
        
        self.praise=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.praise setBackgroundImage:[UIImage imageNamed:@"groupColor.png"] forState:UIControlStateNormal];
        
        self.praise.frame=CGRectMake(self.grade.frame.origin.x-12-size4.width-5, self.addressImage.frame.origin.y, 12+size4.width, 12);
        self.praiseLable.frame=CGRectMake(12, 0, size3.width, 12);
        self.praiseImage.frame=CGRectMake(0, 0, 12, 12);
        
        [self addSubview:self.praise];
        [self.praise addSubview:self.praiseImage];
        [self.praise addSubview:self.praiseLable];
        
        
        self.link=[[UIImageView alloc]initWithFrame:CGRectMake(10,  self.praise.frame.origin.y+self.praise.frame.size.height+18, 300, 2)];
        self.link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:self.link];
        
       
        
        // Initialization code
    }
    return self;
}
-(void)changeFram:(id)sener
{

    self._imageView1.frame=CGRectMake(50, 35, 260, 0);
    self.title.frame=CGRectMake(50, self._imageView1.frame.origin.y+self._imageView1.frame.size.height+5, 260, 40);
    self.addressImage.frame=CGRectMake(10,  self.title.frame.origin.y+self.title.frame.size.height+5, 10, 10);
    
    self.addressImage.frame=CGRectMake(10,  self.title.frame.origin.y+self.title.frame.size.height+5, 10, 10);
    self.addressLable.frame=CGRectMake(22,self.addressImage.frame.origin.y, 100, 10);

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"cell" object:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
