//
//  LookDetailViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-6-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "LookDetailViewController.h"

@implementation LookDetailViewController
backButton
- (void)viewDidLoad{
    self.title = @"了解详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    RTLabel *lab = [[RTLabel alloc]initWithFrame:CGRectMake(10, 0, 300, self.view.frame.size.height)];
    lab.text = @"\n       俄罗斯旅游中文网一直致力于为用户提供绿色、健康的沟通环境，为了保障用户的合法权益，根据国家有关法律法规和用户协议，我们坚决打击各类违法、违规的内容和行为。\n\n       如果你在使用过程中发现有淫秽色情、欺诈（盗号、钓鱼、诈骗）、骚扰、侵权，以及其他不适当的信息和行为，请立即向我们投诉。我们会依法处理，并适时将查证属实的投诉结果通过站内私信向你反馈。\n\n       在处理过程中可能会需要你协助提供相关证明材料，期待你的支持和配合，和我们共建和谐、安全的沟通平台。\n\n                                                     俄罗斯旅游中文网";
    lab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lab];
    
}
@end
