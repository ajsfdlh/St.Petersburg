//
//  SupplierTableViewCell.m
//  St.Petersburg
//
//  Created by li on 14-4-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SupplierTableViewCell.h"

@implementation SupplierTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _iv = [[UIImageView alloc]init];
        _iv.image = BACK_IMAGE;
        _iv.frame = CGRectMake(10, 10, 100, 70);
        [self.contentView addSubview:_iv];
        
       
        
        _nameLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 10, 200, 20)];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        [self.contentView addSubview:_nameLab];
        
        _carLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 33, 200, 20)];
        _carLab.backgroundColor = [UIColor clearColor];
        _carLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        _carLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_carLab];
        
        _languageLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 50, 200, 20)];
        _languageLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_languageLab];
        
        _sayLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 70, 200, 20)];
        _sayLab.backgroundColor = [UIColor clearColor];
        _sayLab.textColor = [UIColor grayColor];
        _sayLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_sayLab];

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
