//
//  TelephoneViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-15.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TelephoneViewController.h"
#import "HTCopyableLabel.h"
@interface TelephoneViewController ()

@end

@implementation TelephoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.view.backgroundColor=GroupColor;
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    [self.view addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(320, 500);
    NSArray*titleArray=[NSArray arrayWithObjects:@"火警",@"救护车",@"报警",@"市内电话查询",@"中国驻圣彼得堡领事馆",@"圣彼得堡银行",@"圣彼得堡市中心医院",@"市医院No4o",@"圣彼得堡牙科诊所", nil];
    
    NSArray*numArray=[NSArray arrayWithObjects:@"01",@"03",@"02",@"09",@"7137605",@"3295050",@"3105838",@"4374075,4370970",@"1350766,1352396", nil];
    for (int i=0; i<9; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 50*i, 320, 50);
        
//        [button setBackgroundImage:[UIImage imageNamed:@"groupColor.png"] forState:UIControlStateNormal];
        button.backgroundColor=GroupColor;
        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(10, 48, 300, 2)];
        link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [button addSubview:link];
        
        UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 160, 50)];
        
        
        if (i==4)
        {
            title.frame=CGRectMake(5, 0, 180, 50);
        }
        title.text=[titleArray objectAtIndex:i];
        
        [button addSubview:title];
        
        
//    HTCopyableLabel*num=[[HTCopyableLabel alloc]initWithFrame:CGRectMake(160, 0, 140, 50)];
//        num.copyMenuArrowDirection=UIMenuControllerArrowDown;
//        if (i>=0&&i<=3) {
//            num.frame = CGRectMake(280, 0, 20, 50);
//        }
        
//        num.copyableLabelDelegate=self;
//        num.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
//        num.textAlignment=NSTextAlignmentRight;
//        num.text=[numArray objectAtIndex:i];
//        num.backgroundColor = [UIColor redColor];
//        [button addSubview:num];
        
//        UITextField *num = [[UITextField alloc]initWithFrame:CGRectMake(160, 0, 140, 50)];
//        num.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
//        num.textAlignment=NSTextAlignmentRight;
//        num.text=[numArray objectAtIndex:i];
//        num.delegate = self;
//        num.backgroundColor = [UIColor redColor];
//
//        [button addSubview:num];
        
        UIButton *num = [UIButton buttonWithType:UIButtonTypeCustom];
        num.frame = CGRectMake(150, 0, 150, 50);
        [num setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]] forState:UIControlStateNormal];
        [num setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [num setTitle:[numArray objectAtIndex:i] forState:UIControlStateNormal];
        [num addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        num.tag = i;
        [button addSubview:num];
        
        [scrollView addSubview:button];
        
    }
    
    
    
   	// Do any additional setup after loading the view.
}
- (void)call:(UIButton *)btn{
    NSString *message = [NSString stringWithFormat:@"您确定要拨打电话%@吗",btn.currentTitle];
    
    UIAlertView *av;
    
    
    switch (btn.tag) {
        case 0:{
              av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 1:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 2:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 3:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 4:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 5:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 6:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        }
            
            break;
        case 7:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打4374075",@"拨打4370970" , nil];
        }
            
            break;
        case 8:{
            av = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打1350766",@"拨打1352396" , nil];
        }
            
            break;
            
            
        default:
            break;
            
    }
    av.tag = btn.tag;
    [av show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   // NSLog(@"%d",buttonIndex);
    if (buttonIndex==1) {
        switch (alertView.tag) {
            case 0:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://01"] ];
                break;
            case 1:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://03"] ];
                break;
            case 2:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://02"] ];
                break;
            case 3:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://09"] ];
                break;
            case 4:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://7137605"] ];
                break;
            case 5:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://3295050"] ];
                break;
            case 6:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://3105838"] ];
                break;
            case 7:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%d",buttonIndex==1?4374075:4370970]] ];
                break;
            case 8:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%d",buttonIndex==1?1350766:1352396]]];
                break;
            default:
                break;
        }

    }
}
- (NSString *)stringToCopyForCopyableLabel:(HTCopyableLabel *)copyableLabel
{
    NSLog(@"%s",__func__);
    copyableLabel.frame=CGRectMake(copyableLabel.frame.origin.x+50, copyableLabel.frame.origin.y, copyableLabel.frame.size.width, copyableLabel.frame.size.height);
    return @"复制";
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setNewTitle:@"常用电话"];
    
   hideTabbar
}
backButton

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
