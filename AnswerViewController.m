//
//  AnswerViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-5-6.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

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
    [self.navigationItem setNewTitle:@"常见问题详细"];
    self.view.backgroundColor=GroupColor;
    UIImageView*question=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    question.image=[UIImage imageNamed:@"toolQuestion.png"];
    NSLog(@"head %d",self.head.length);
    if (self.head.length<=15) {
        question.frame = CGRectMake(10, 15, 20, 20);
    }
    [self.view addSubview:question];
    
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(42, 10, 270, 30)];
    lable.font=[UIFont systemFontOfSize:17];
    lable.text=self.head;
    lable.numberOfLines=0;
    CGSize size=[lable sizeThatFits:CGSizeMake(270, 0)];
    if (size.height>30)
    {
        lable.frame=CGRectMake(42, 10, 270, size.height);
    }
  
    [self.view addSubview:lable];
    
    UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(10, lable.frame.origin.y+lable.frame.size.height+10, 300, 2)];
    link.image=[UIImage imageNamed:@"entainmentLink.png"];
    [self.view addSubview:link];
    
    
    
    UIImageView*answer=[[UIImageView alloc]initWithFrame:CGRectMake(10, link.frame.origin.y+15, 20, 20)];
    answer.image=[UIImage imageNamed:@"toolAnswer.png"];
    [self.view addSubview:answer];
    
    RTLabel*lable2=[[RTLabel alloc]initWithFrame:CGRectMake(42, answer.frame.origin.y, 270, 0)];
    lable2.font=[UIFont systemFontOfSize:16];
    lable2.lineSpacing=8;
    lable2.text=self.text;
    lable2.textColor=[UIColor grayColor];
  
    CGSize size2=[lable2 optimumSize];
   
    lable2.frame=CGRectMake(42, answer.frame.origin.y+1.5, 270, size2.height);
    
    
    [self.view addSubview:lable2];

    
	// Do any additional setup after loading the view.
}
backButton
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
