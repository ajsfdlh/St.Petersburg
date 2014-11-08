//
//  UserTableViewCell.m
//  通信界面
//
//  Created by li on 14-3-26.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "UserTableViewCell.h"
#import "RTLabel.h"
@implementation UserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
