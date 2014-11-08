//
//  MyTravelingTableViewCell.m
//  St.Petersburg
//
//  Created by li on 14-5-9.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyTravelingTableViewCell.h"

@implementation MyTravelingTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, 97, 320, 3)];
        link.image=[UIImage imageNamed:@"entainmentLink"];
        [self addSubview:link];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIImageView*link2=[[UIImageView alloc]initWithFrame:CGRectMake(300, 40, 20, 20)];
        link2.image=[UIImage imageNamed:@"cellJianTou.png"];
        [self addSubview:link2];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
