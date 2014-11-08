//
//  TaxiCompanyCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TaxiCompanyCell.h"

@implementation TaxiCompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 75)];
         self._imageView.image=BACK_IMAGE;
        [self addSubview:self._imageView];
        
        
        self.text=[[RTLabel alloc]initWithFrame:CGRectMake(113, 10, 200, 170)];
        //self.text.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        [self addSubview:self.text];
        
        _link=[[UIImageView alloc]initWithFrame:CGRectMake(10, 178, 300, 2)];
        _link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:_link];
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
