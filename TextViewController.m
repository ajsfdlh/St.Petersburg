//
//  TextViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setNewTitle:self.navBarName];
 hideTabbar

}


    - (void)viewDidLoad
    {
        [super viewDidLoad];
        UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        [self.view addSubview:sv];
        sv.backgroundColor=GroupColor;
        RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
        lab1.text = @"       俄罗斯签证分为五种：俄罗斯旅游签证、俄罗斯商务签证、俄罗斯工作签证(打工卡)、俄罗斯留学签证、俄罗斯过境签证。\n<br><b>俄罗斯旅游签证所需材料：</b>\n<br>◆ 有效护照及护照主页复印件：护照尾页需持照人亲笔签名，有效期需至少半年以上，护照至少有2页供使用的签证空白页，如有旧护照必须全部提供；\n<br>◆ 身份证复印件：正反面复印件一份，内容必须清晰;\n<br>◆ 照片：白底彩色照片，2张，两寸(35mm X 45mm);\n<br>◆ 签证申请表：应回答表内所有的问题，此信息的真实性及完整性，直接影响签证结果；\n<br>◆ 邀请函：俄罗斯旅行社签发的确认迎接外国旅游者函原件及其复印件。\n              <br><b>俄罗斯商务签证所需材料：</b>\n<br>◆ 有效护照及护照主页复印件：护照尾页需持照人亲笔签名，有效期需至少半年以上，护照至少有2页供使用的签证空白页，如有旧护照必须全部提供；\n<br>◆ 身份证复印件：正反面复印件一份，内容必须清晰;\n<br>◆ 照片：白底彩色照片，2张，两寸(35mm X 45mm)；\n<br>◆ 签证申请表：应回答表内所有的问题，此信息的真实性及完整性，直接影响签证结果。多次签证必要填补充信息表；\n<br>◆ 邀请函：俄罗斯移民局或外交部签发的邀请函原件；\n<br>◆ 国内派出单位的介绍信或工作证。\n<br><b>俄罗斯工作签证(打工卡)所需材料：</b>\n<br>◆ 有效护照及护照主页复印件：护照尾页需持照人亲笔签名，有效期需至少半年以上，护照至少有2页供使用的签证空白页，如有旧护照必须全部提供;\n<br>◆ 身份证复印件：正反面复印件一份，内容必须清晰;<\n><br><br>◆ 照片：白底彩色照片，2张，两寸(35mm X 45mm);\n<br>◆ 签证申请表：应回答表内所有的问题，此信息的真实性及完整性，直接影响签证结果；\n<br>◆ 邀请函：俄罗斯移民局签发的邀请函原件；\n<br>◆ 劳动许可证：俄罗斯移民局签发的劳动许可证及其复印件；\n<br>◆ 俄罗斯邀请单位的营业执照复印件；\n<br>◆ 有效(有效期为3个月)健康证明书、爱滋病检疫报告（如在俄罗斯停留的时间超过90天）；\n<br>◆ 国外派劳动培训合格证原件及其复印件。\n       <br><b>俄罗斯留学签证所需材料：</b>\n<br>◆ 有效护照及护照主页复印件：护照尾页需持照人亲笔签名，有效期需至少半年以上，护照至少有2页供使用的签证空白页，如有旧护照必须全部提供；\n<br>◆ 身份证复印件：正反面复印件一份，内容必须清晰;\n<br>◆ 照片：白底彩色照片，2张，两寸(35mm X 45mm)；\n<br>◆ 签证申请表：应回答表内所有的问题，此信息的真实性及完整性，直接影响签证结果；\n<br>◆ 邀请函：俄罗斯移民局签发的邀请函原件；\n<br>◆ 俄罗斯邀请学院(大学)的有效邀请函原件及其复印件；\n<br>◆ 申请人与该学院(大学)的有效合同原件及其复印件；\n<br>◆ 申请人毕业证书复印件；\n<br>◆ 有效(有效期为3个月)健康证明书、爱滋病检疫报告(如在俄罗斯停留的时间超过90天)；\n<br>◆ 证明有足够支付能力的银行存款证明(如是父母的账户必要提供户口本证明亲属关系)；\n<br>◆ 18岁以下的孩子应提供父母同意的公证件。\n<br><br><b>俄罗斯过境签证所需材料：</b>\n<br>◆ 有效护照及护照主页复印件：护照尾页需持照人亲笔签名，有效期需至少半年以上，护照至少有2页供使用的签证空白页，如有旧护照必须全部提供；\n<br>◆ 身份证复印件：正反面复印件一份，内容必须清晰;\n<br>◆ 照片：白底彩色照片，2张，两寸(35mm X 45mm)；\n<br>◆ 签证申请表：应回答表内所有的问题，此信息的真实性及完整性，直接影响签证结果；\n<br>◆ 目的地国家的有效签证；\n<br>◆ 经俄罗斯到第三国家的全程票。";
        lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
        [sv addSubview:lab1];

        [sv setContentSize:CGSizeMake(320, lab1.frame.origin.y+lab1.frame.size.height+30)];
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
