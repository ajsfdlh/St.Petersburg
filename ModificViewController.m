//
//  ModificViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "ModificViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "ClauseDetailView.h"
@interface ModificViewController ()

@end

@implementation ModificViewController

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
hideTabbar
[self.navigationItem setNewTitle:self.pageTitle];

}
-(void)setBlock:(blockFun)aBlock
{
    if (myBlock!=aBlock)
    {
        myBlock=aBlock;
    }
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    phone=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    
    UIImageView*logIn=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 50)];
    logIn.userInteractionEnabled=YES;
   // logIn.image=[UIImage imageNamed:@"memeber_headBack.png"];
    [phone addSubview:logIn];
  
    textFieldName=[[UITextField alloc]initWithFrame:CGRectMake(100, 0, 220, 50)];
    //textFieldName.text=self.phoneNum;
    textFieldName.delegate=self;
    if ([self.pageTitle isEqualToString:@"注册"])
    {
        NSArray*zhuce=[NSArray arrayWithObjects:@"用户名",@"邮箱",@"密码" ,@"确认密码",nil];
         NSArray*zhuce1=[NSArray arrayWithObjects:@"由6~16位英文字母或数字组成",@"请填写你的常用邮箱",@"请填写6~20位密码密码" ,@"请再填写一遍密码",nil];
        for (int i=0; i<[zhuce count]; i++)
        {
              UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20+40*i, 320, 40)];
            imageView.userInteractionEnabled=YES;
            UILabel*l=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
            l.userInteractionEnabled=YES;
//            l.backgroundColor=[UIColor blueColor];
            l.text=[zhuce objectAtIndex:i];
            l.font=[UIFont systemFontOfSize:14];
            [imageView addSubview:l];
            UITextField*textField=[[UITextField alloc]initWithFrame:CGRectMake(85, 0, 220, 40)];
            textField.tag=30+i;
            textField.font=[UIFont systemFontOfSize:14];
            textField.placeholder=[zhuce1 objectAtIndex:i];
            [imageView addSubview:textField];
            textField.delegate=self;
            
            if (i==0)
            {
                imageView.image=[UIImage imageNamed:@"MyDownCell.png"];
            }else if (i==1)
            {
                imageView.image=[UIImage imageNamed:@"MyCenter"];
            }else if (i==3)
            {
                textField.secureTextEntry=YES;
                imageView.image=[UIImage imageNamed:@"MyUpCell"];
             
            }else
            {
               textField.secureTextEntry=YES;
             imageView.image=[UIImage imageNamed:@"MyCenter"];
            
            }
                    [phone addSubview:imageView];
            
            
        }
        
        RTLabel *clauseLab= [[RTLabel alloc] initWithFrame:CGRectMake(50, 200, 250, 10)];
        clauseLab.font = [UIFont systemFontOfSize:10];
        clauseLab.text = @"我已阅读并同意<font color='#006db8'>《俄罗斯旅游中文网会员服务条款》</font>";
        UITapGestureRecognizer *lookClauseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookClause)];
        [clauseLab addGestureRecognizer:lookClauseTap];
        [phone addSubview:clauseLab];
        
        UIImageView *gougou = [[UIImageView alloc] initWithFrame:CGRectMake(33, 199, 12, 12)];
        gougou.image = [UIImage imageNamed:@"注册_03"];
        [phone addSubview:gougou];
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(10, 230, 300, 40);
        [button setBackgroundImage:[UIImage imageNamed:@"mine_log.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(registers:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"提交注册" forState:UIControlStateNormal];
        
        [phone addSubview:button];
        [self.view addSubview:phone];
        
        
    }
    
    
    
    
    if ([self.pageTitle isEqualToString:@"修改手机号"]||[self.pageTitle isEqualToString:@"修改邮政编码"]||[self.pageTitle isEqualToString:@"修改邮箱"])
    {
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        lable.backgroundColor = [UIColor whiteColor];
        lable.textAlignment=NSTextAlignmentLeft;
        [logIn addSubview:lable];
          textFieldName.keyboardType=UIKeyboardTypeNumberPad;
          [logIn addSubview:textFieldName];
        if ([self.pageTitle isEqualToString:@"修改邮政编码"])
        {
          lable.text=@"  邮政编码";
            
        }
        if ([self.pageTitle isEqualToString:@"修改手机号"])
        {
              lable.text=@"  手机号";
            textFieldName.text=self.phoneNum;
        }
        if ([self.pageTitle isEqualToString:@"修改邮箱"])
        {
            lable.text=@"  邮箱";
            textFieldName.text=self.mailNum;
        }
          [self.view addSubview:phone];
       
        
    }
  
    
    
    if ([self.pageTitle isEqualToString:@"修改详细地址"])

    {
//        UIImageView*log=[UIImageView new];
       logIn.frame=CGRectMake(5, 10, 310, 60);
     
        logIn.userInteractionEnabled=YES;
        logIn.image=[UIImage imageNamed:@"memeber_headBack.png"];
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 90,50)];
        lable.text=@"详细地址";
        lable.textAlignment=NSTextAlignmentLeft;
//        [logIn addSubview:lable];

        
        textViw=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 310, 60)];
        textViw.text=self.phoneNum;
        textViw.font=[UIFont systemFontOfSize:17];
        textViw.delegate=self;
        textViw.scrollEnabled=NO;
        
        [logIn addSubview:textViw];
        [self.view addSubview:phone];
    
    }
      if ([self.pageTitle isEqualToString:@"修改个人介绍"])
        
    {
        textViw=[[UITextView alloc]initWithFrame:CGRectMake(5, 10, 310, 100)];
        textViw.text=self.phoneNum;
        textViw.font=[UIFont systemFontOfSize:17];
         textViw.delegate=self;
        textViw.scrollEnabled=NO;

        [self.view addSubview:textViw];
        
    }
    
  
    if ([self.pageTitle isEqualToString:@"修改密码"])
    {
        NSArray*mima=[NSArray arrayWithObjects:@"旧密码",@"新密码", @"确定密码",nil];
          NSArray*mi=[NSArray arrayWithObjects:@"请输入旧密码",@"请输入新密码", @"请重新输入新密码",nil];
        for (int i=0; i<3; i++)
        {
            UIImageView*logIn=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20+50*i, 320, 50)];
            logIn.userInteractionEnabled=YES;
            if (i==0)
            {
                   logIn.image=[UIImage imageNamed:@"mine_logDown.png"];
            }
            if (i==1)
            {
                logIn.image=[UIImage imageNamed:@"mine_logDown.png"];
            }
            if (i==2)
            {
                logIn.image=[UIImage imageNamed:@"mine_logDown.png"];
            }


         
            [self.view addSubview:logIn];
            
            UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(10, (50-20)/2, 90, 20)];
            lable.text=[mima objectAtIndex:i];
            
            lable.textAlignment=NSTextAlignmentLeft;
            [logIn addSubview:lable];
            
           UITextField*textFieldName1=[[UITextField alloc]initWithFrame:CGRectMake(100, 0, 220, 50)];
            textFieldName1.placeholder=[mi objectAtIndex:i];
            textFieldName1.delegate=self;
            textFieldName1.tag=10+i;
            textFieldName1.secureTextEntry=YES;
            [logIn addSubview:textFieldName1];

        }
      
        UIButton*logButton=[UIButton buttonWithType:UIButtonTypeCustom];
        logButton.frame=CGRectMake(5, 200, 310, 40);
        [logButton setBackgroundImage:[UIImage imageNamed:@"mine_log.png"] forState:UIControlStateNormal];
        [logButton setTitle:@"确定" forState:UIControlStateNormal];
        [logButton addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:logButton];

      
    }
    
	// Do any additional setup after loading the view.
}
- (void)lookClause{
    NSLog(@"lookClause");
    [self.navigationController pushViewController:[ClauseDetailView new] animated:NO];
}
//-(BOOL)textv
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

{
   
    if ([string isEqualToString:@"\n"])
       
    {
       
        return YES;
       
    }
  
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
  
    
        if ([toBeString length] > 11)
        {
            if ([self.pageTitle isEqualToString:@"修改手机号"])
            {
                textField.text = [toBeString substringToIndex:11];
                return NO;

            }

            

       }
    
    if ([toBeString length] >6)
    {
        if ([self.pageTitle isEqualToString:@"修改邮政编码"])
        {
            textField.text = [toBeString substringToIndex:6];
            return NO;
            
        }
        
        
        
    }

   
    return YES; 
   
}
-(void)registers:(UIButton*)sender
{

    UITextField*text1=(UITextField*)[self.view viewWithTag:30];
    UITextField*text2=(UITextField*)[self.view viewWithTag:31];
    UITextField*text3=(UITextField*)[self.view viewWithTag:32];
    UITextField*text4=(UITextField*)[self.view viewWithTag:33];
    
    BOOL isValid=[self validateEmail:text2.text];
    NSString *testString =text1.text;
//    NSString *perchar;
    int alength = [testString length];
     int a=0;
    for (int i = 0; i<alength; i++)
    {
        char commitChar = [testString characterAtIndex:i];
       // NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
       // const char *u8Temp = [temp UTF8String];
       
        if (!(((commitChar>64)&&(commitChar<91))||((commitChar>96)&&(commitChar<123))||((commitChar>47)&&(commitChar<58))))
        {
            a=1;
        }
    }
    
    if (text1.text.length>=6&&text1.text.length<=16&&a==0)
    {
        
        if (isValid)
        {
            if ([text3.text isEqualToString:text4.text])
            {
                if (text3.text.length>=6&&text3.text.length<=20)
                {
                    NSString *canshu=[NSString stringWithFormat:@"UserName=%@&PassWord=%@&Email=%@",text1.text,text3.text,text2.text];//设置参数
                    NSMutableString*urlDomain=RussiaUrl
                    NSString*urlMethod=@"UserRegister";
                    [urlDomain appendString:urlMethod];
//                    postRequestTongBu(canshu, urlDomain, received)
//                    dicResultTongbu(received, result, dic)
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        //   dicResultTongbu(data, result, dic);
                         postRequestTongBu(canshu, urlDomain, received)
                        dicResultTongbuNoDic(received, result);

                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSLog(@"result %@",result);
                            int a=[result intValue];
                            if (a)
                            {
                                if (a==-1)
                                {
                                    UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"邮箱已注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                
                                else  if (a==-2)
                                {
                                    UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"注册失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                
                                
                                else
                                {
                                    
                                    
                                    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
                                    [defaults setInteger:a forKey:QUSE_ID];
                                    [defaults setObject:text1.text forKey:USER_NAME];
                                
                                    [defaults synchronize];
                                    
                                    NSString *str=[NSString stringWithFormat:@"uid=%d",a];//设置
                                    NSMutableString*urlDomain=RussiaUrl
                                    NSString*urlMethod=@"getUserInfo";
                                    [urlDomain appendString:urlMethod];
                                    postRequestTongBu(str, urlDomain, received)
                                    
                                    dicResultTongbu(received, result, dic2)
                                    
                                    
                                    NSDictionary*dic4=[[dic2 valueForKey:@"ds"]lastObject];
                                    
                                    
                                    
                                    switch ([[dic4 valueForKey:GUIDE_ID]intValue])
                                    {
                                        case 0:
                                            
                                            [defaults setValue:@"普通会员"forKey:GUIDE_ID];
                                            [defaults synchronize];
                                            break;
                                        case 1:
                                            
                                            [defaults setValue:@"导游会员" forKey:GUIDE_ID];
                                            [defaults synchronize];
                                            break;
                                        case 2:
                                            
                                            [defaults setValue:@"司兼导(租车)会员" forKey:GUIDE_ID];
                                            [defaults synchronize];
                                            break;
                                        case 3:
                                            
                                            [defaults setValue:@"导游兼翻译会员" forKey:GUIDE_ID];
                                            [defaults synchronize];
                                            break;
                                        case 4:
                                            
                                            [defaults setValue:@"导游兼翻译(带车)会员" forKey:GUIDE_ID];
                                            [defaults synchronize];
                                            break;
                                        default:
                                            break;
                                            
                                    }
                                    
                                    if (self.tag==1)
                                    {
                                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3]  animated:NO];
                                    }
                                    else
                                    {
                                        [self.navigationController popViewControllerAnimated:NO];
                                    }
                                    
                                }
                            }
                            
                            else
                            {
                                UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"用户名已存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                        });
                    });

                   
                    
                    
                }
                else
                {
                    UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"请输入6~20位密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                    
                    
                }
                
                
                
            }
            else
            {
                UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"两次输入密码不相同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }

        }
        else
        {
            UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"请输入合法邮箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
      
        
    }
    else
    {
        UIAlertView*alert=[[UIAlertView alloc ]initWithTitle:@"提示" message:@"请输入6~16位英文或字母" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        

    
    }
    
    
    
}
- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    
    
    
    if ([toBeString length] > 65)
    {
        if ([self.pageTitle isEqualToString:@"修改个人介绍"])
        {
            textView.text = [toBeString substringToIndex:65];
            return NO;
            
        }

  //        [textView resignFirstResponder];
//         self.navigationItem.rightBarButtonItem=nil;
    }

  return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
          UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
        float height=34;
        backbutton.frame=CGRectMake(0, (44-height)/2, 60, height) ;
        //    backbutton.backgroundColor=[UIColor redColor];
        
        [backbutton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*backbuttonlable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backbutton.frame.size.width, backbutton.frame.size.height)] ;
        backbuttonlable.text=@"完成";
        backbuttonlable.textAlignment=NSTextAlignmentCenter;
        backbuttonlable.textColor=[UIColor whiteColor];
        [backbutton addSubview:backbuttonlable];
        UIImage *imgSelected = [UIImage imageNamed:@"submit.png"];[backbutton setBackgroundImage:[imgSelected stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton] ;
        self.navigationItem.rightBarButtonItem =backItem;
        
    



    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    if (![self.pageTitle isEqual:@"修改密码"]&&![self.pageTitle isEqual:@"注册"])
    {
        UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
        float height=34;
        backbutton.frame=CGRectMake(0, (44-height)/2, 60, height) ;
        //    backbutton.backgroundColor=[UIColor redColor];
        
        [backbutton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*backbuttonlable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backbutton.frame.size.width, backbutton.frame.size.height)] ;
        backbuttonlable.text=@"完成";
        backbuttonlable.textAlignment=NSTextAlignmentCenter;
        backbuttonlable.textColor=[UIColor whiteColor];
        [backbutton addSubview:backbuttonlable];
        UIImage *imgSelected = [UIImage imageNamed:@"submit.png"];[backbutton setBackgroundImage:[imgSelected stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton] ;
        self.navigationItem.rightBarButtonItem =backItem;

    }
   
    

    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    self.navigationItem.rightBarButtonItem =nil;
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    return YES;
}
-(void)logIn:(UIButton*)sender
{
    UITextField*text1=(UITextField*)[self.view viewWithTag:11];
     UITextField*text2=(UITextField*)[self.view viewWithTag:12];
    UITextField*text=(UITextField*)[self.view viewWithTag:10];

    if ([text1.text isEqualToString:text2.text])
    {
        NSString *str1,*canshu;
        NSMutableString *urlDomain;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2) {
            str1=[NSString stringWithFormat:@"%d",self.useID];
            canshu=[NSString stringWithFormat:@"userid=%@&yPassWord=%@&nPassWord=%@&email=&mobile=",str1,text.text,text1.text];//设置参数
            NSLog(@"canshu   %@",canshu);
            urlDomain=RussiaUrl;
            NSString*urlMethod=@"UpdateServiceInfo";
            [urlDomain appendString:urlMethod];
        }else{
            str1=[NSString stringWithFormat:@"%d",self.useID];
            canshu=[NSString stringWithFormat:@"userid=%@&yPassWord=%@&nPassWord=%@",str1,text.text,text1.text];//设置参数
            urlDomain=RussiaUrl
            NSString*urlMethod=@"UpdatePassword";
            [urlDomain appendString:urlMethod];
        }
        
       
        NSLog(@"%@-----------------%@",urlDomain,canshu);
        postRequestTongBu(canshu, urlDomain, received)
        NSString *str2 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];NSData*data2=[str2 dataUsingEncoding:NSUTF8StringEncoding];
        GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithData:data2 options:0 error:nil];GDataXMLElement *e1=[document rootElement];NSString*result=[e1 stringValue];
 NSLog(@"%@-----------------",result);
        
        if ([result intValue]==2)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"修改失败,请重试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        if ([result intValue]==1)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
//            [self.navigationController popViewControllerAnimated:NO];
            
        }
        if ([result intValue]==0)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"原始密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            //            [self.navigationController popViewControllerAnimated:NO];
            
        }




        
    }
    else
    {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"两次输入的密码不同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    
    }


}
-(void)done:(UIButton*)sender
{
    
    self.navigationItem.rightBarButtonItem=nil;
    [textViw resignFirstResponder];
    [textFieldName resignFirstResponder];
    NSString*str=[NSString stringWithFormat:@"%d",self.useID];
    NSLog(@"%d",self.useID);
    NSString*canshu;
    if ([self.pageTitle isEqualToString:@"修改手机号"]||[self.pageTitle isEqualToString:@"修改邮箱"]){


    if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2) {
        NSString *canshu;
       if ([self.pageTitle isEqualToString:@"修改手机号"]) canshu=[NSString stringWithFormat:@"userid=%@&yPassWord=&nPassWord=&email=&mobile=%@",str,textFieldName.text];
        
       else if ([self.pageTitle isEqualToString:@"修改邮箱"]){
           BOOL isValid=[self validateEmail:textFieldName.text];
           if (!isValid) {
               UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"邮箱格式不对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
               [alert show];
               return;
           }else canshu=[NSString stringWithFormat:@"userid=%@&yPassWord=&nPassWord=&email=%@&mobile=",str,textFieldName.text];
        

       }
        NSLog(@"%@",canshu);
        //设置参数
        NSMutableString *urlDomain=RussiaUrl;
        NSString*urlMethod=@"UpdateServiceInfo";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(canshu, urlDomain)
        return;
    }else
        
    {
        
        canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,textFieldName.text,@"",@"",@"",@"",@"",@""];
        
    }
    }
    if ([self.pageTitle isEqualToString:@"修改详细地址"])
        
    {
        canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,@"",@"",@"",@"",textViw.text,@"",@""];
        
    }
    if ([self.pageTitle isEqualToString:@"修改邮政编码"])
        
    {
        canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,@"",@"",@"",@"",@"",textFieldName.text,@""];
        
    }
    if ([self.pageTitle isEqualToString:@"修改个人介绍"])
        
    {
        canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,@"",@"",@"",@"",@"",@"",textViw.text];
        
    }



     NSMutableString*urlDomina=RussiaUrl
    NSString*urlMethod=@"ModifyUserInfo";
    [urlDomina appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomina)
    
//    myBlock(textFieldName.text);
//    [self.navigationController popViewControllerAnimated:YES];

    


}
postRequestAgency(datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSError*error=nil;
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithData:datas options:0 error:&error];
    GDataXMLElement *e=[document rootElement];
//    NSLog(@"e=%@",[e stringValue]);
//    NSLog(@"e=%d",[[e stringValue]intValue]);
    int a=[[e stringValue]intValue];
    if (a)
    {
        if (textFieldName.text)
        {
              myBlock(textFieldName.text);
        }
        if (textViw.text)
        {
            myBlock(textViw.text);
        }
   
    }
    else
    {

        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"没有修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
