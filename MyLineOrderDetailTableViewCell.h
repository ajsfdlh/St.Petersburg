//
//  MyLineOrderDetailTableViewCell.h
//  St.Petersburg
//
//  Created by kirem-peter on 14-11-3.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLineOrderDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *headLab;
@property (strong, nonatomic) IBOutlet UILabel *cLastName;
@property (strong, nonatomic) IBOutlet UILabel *cFirstName;
@property (strong, nonatomic) IBOutlet UILabel *eLastName;
@property (strong, nonatomic) IBOutlet UILabel *eFirstName;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *bornDate;
@property (strong, nonatomic) IBOutlet UILabel *passportNum;
@property (strong, nonatomic) IBOutlet UILabel *passportDate;


@end
