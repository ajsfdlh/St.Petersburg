//
//  TaxiPersonageCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TaxiPersonageCell.h"

@implementation TaxiPersonageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 75)];
        self._imageView.image=BACK_IMAGE;
        [self addSubview:self._imageView];
        self.nameCountrySexSeatCountCarClassJicheng=[[RTLabel alloc]initWithFrame:CGRectMake(115, 10, 205, 20)];
        self.nameCountrySexSeatCountCarClassJicheng.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        [self addSubview:self.nameCountrySexSeatCountCarClassJicheng];
        self.carBrand=[[RTLabel alloc]initWithFrame:CGRectMake(115, 30, 200, 20)];
        self.carBrand.backgroundColor=[UIColor clearColor];
        [self addSubview:self.carBrand];
        self.zongZhi=[[RTLabel alloc]initWithFrame:CGRectMake(115, 50, 198, 40)];
        [self addSubview:self.zongZhi];
        
        self.priceHour=[[RTLabel alloc]initWithFrame:CGRectMake(115, 85, 198, 20)];
        [self addSubview:self.priceHour];

        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 113, 300, 2)];
        imageView.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:imageView];
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
