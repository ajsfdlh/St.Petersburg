//
//  FeedBackViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-6-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "FeedBackViewController.h"
#import "GDataXMLNode.h"
#import "JSON.h"
#import "LookDetailViewController.h"
@implementation FeedBackViewController
backButton
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UILabel *headLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    headLab.text = @"请选择投诉原因";
    headLab.textColor = [UIColor grayColor];
    headLab.font = [UIFont boldSystemFontOfSize:15.5];
    [self.view addSubview:headLab];
    //gougou
    UIImageView *pitchUp = [[UIImageView alloc] initWithFrame:CGRectMake(293, 12.5, 18, 18)];
    pitchUp.tag = 100;
    pitchUp.image = [UIImage imageNamed:@"pitchUp"];
    //选择框
    arr = @[@"色情",@"欺诈",@"骚扰",@"侵权",@"其他"];
    for (int i = 0 ; i < 5;  i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 44+43*i, 320, 43);
        btn.tag = i;
        if (i==0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"MyDownCell.png"] forState:UIControlStateNormal];
            [btn addSubview:pitchUp];
            _feedBackReason = arr[0];
        }else if (i==4){
        [btn setBackgroundImage:[UIImage imageNamed:@"MyUpCell.png"] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"MyCenter.png"] forState:UIControlStateNormal];
        }
        
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(11.5, 10, 11.5, 275)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.5]];
        [btn addTarget:self action:@selector(touchOnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    //了解详情
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, self.view.frame.size.height-44-57, 320, 20);
    [bottomBtn setTitle:@"了解详情" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:BLUE_SKY_COLOR forState:UIControlStateNormal];
    [bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [bottomBtn addTarget:self action:@selector(lookDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    //发送
    UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    float height=34;
    backbutton.frame=CGRectMake(0, (44-height)/2, 60, height) ;
    //    backbutton.backgroundColor=[UIColor redColor];
    
    [backbutton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
   UILabel *backbuttonlable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backbutton.frame.size.width, backbutton.frame.size.height)] ;
    backbuttonlable.text=@"发送";
    backbutton.tag=50;
    backbuttonlable.textAlignment=NSTextAlignmentCenter;
    backbuttonlable.textColor=[UIColor whiteColor];
    [backbutton addSubview:backbuttonlable];
    UIImage *imgSelected = [UIImage imageNamed:@"submit.png"];[backbutton setBackgroundImage:[imgSelected stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton] ;
    self.navigationItem.rightBarButtonItem =backItem;
    
    
    
}
- (void)sendFeedBack{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSMutableString *urlStr = RussiaUrl4;
    [urlStr appendString:@"AddTouSuInfo"];
    NSString *argStr = [NSString stringWithFormat:@"userid=%@&username=%@&mesid=%@&content=%@",GET_USER_DEFAUT(QUSE_ID),GET_USER_DEFAUT(USER_NAME),_mesid,_feedBackReason];
    NSLog(@"arg %@",argStr);
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPBody:[argStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"post"];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dicResultYiBuNoDic(data, result)
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([result intValue]==1) {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"投诉成功!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [av show];
            }else if ([result intValue]==2) {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"不能重复投诉!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [av show];
            }
            else{
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"投诉失败!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [av show];
            }
            [self.navigationController popViewControllerAnimated:NO];
        });
      
        NSLog(@"result %@",result);
    }];
}
- (void)touchOnBtn:(UIButton *)btn{
    for (UIImageView *pitch in btn.subviews) {
        if (pitch.tag == 100) {
            return;
        }
    }
    UIImageView *pitchView = (UIImageView*)[self.view viewWithTag:100];
    [pitchView removeFromSuperview];
    [btn addSubview:pitchView];
    _feedBackReason = arr[btn.tag];
}
- (void)lookDetail{
    [self.navigationController pushViewController:[LookDetailViewController new] animated:NO];
   // NSLog(@"hello");
}
@end
