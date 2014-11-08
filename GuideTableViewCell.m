//
//  GuideTableViewCell.m
//  St.Petersburg
//
//  Created by li on 14-4-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "GuideTableViewCell.h"

@implementation GuideTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _iv = [[UIImageView alloc]init];
        _iv.image = BACK_IMAGE;
        _iv.frame = CGRectMake(10, 10, 100, 140);
        [self.contentView addSubview:_iv];
        
        
        
        _nameLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 10, 200, 20)];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        [self.contentView addSubview:_nameLab];
        
        _carLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 32, 200, 20)];
        _carLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_carLab];
        
        _languageLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 50, 200, 20)];
        _languageLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_languageLab];
        
        _sayLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 70, 200, 20)];
        _sayLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_sayLab];
        
        _serviceLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 90, 200, 40)];
        _serviceLab.backgroundColor = [UIColor clearColor];

       // _serviceLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>服务宗旨 :</font> <font size=12 color=black>民族/艺术,历史/文化,宗教/人文</font>"];
        //_serviceLab.frame = CGRectMake(115, 90, 200, _serviceLab.optimumSize.height);
        [self.contentView addSubview:_serviceLab];

        
        _dayLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 130, 200, 20)];
        _dayLab.backgroundColor = [UIColor clearColor];
        //_dayLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>$</font><font size=15 color=orange>520</font><font  size=12 color=gray>/天,每天工作8小时</font>"];
        [self.contentView addSubview:_dayLab];
        _link = [[UIImageView alloc]init];
        _link.image = [UIImage imageNamed:@"entainmentLink"];
        _link.frame = CGRectMake(0, 168, 320, 2);
        [self.contentView addSubview:_link];
        
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
