//
//  CarAndGuideReseverViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-18.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CarAndGuideReseverViewController.h"
#import "GDataXMLNode.h"
#import "OrderViewController.h"
#import "GCCalenderViewController.h"
@implementation CarAndGuideReseverViewController

backButton

- (void)viewWillAppear:(BOOL)animated{
//    NSLog(@"arr = %@",self.CGArr);
    //roomInformationStr = [[NSMutableString alloc] init];
    //userConnectInformationStr = [[NSMutableString alloc] init];
    if (self.CGArr)
    {
        if ([self.peopleCountStr integerValue] == 0)
        {
            [jian setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateNormal];
            jian.enabled=NO;
            zhong.text = @"0";
            [jia setBackgroundImage:[UIImage imageNamed:@"jia2"] forState:UIControlStateNormal];
            jia.enabled=NO;
        }
        else
        {
            zhong.text = @"1";
            [jia setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
            jia.enabled=YES;
        }

        NSMutableString *addDateStr = [NSMutableString string];
        _selectDateStr = [NSMutableString string];
       // UILabel *checkLab = (UILabel *)[sv viewWithTag:11];
        for (NSString *str in [self.CGArr sortedArrayUsingSelector:@selector(compare:)])
        {
            
            if(_selectDateStr.length)
            {
                [_selectDateStr appendString:[NSString stringWithFormat:@",%@",str]];
                [addDateStr appendString:[NSString stringWithFormat:@",%@",str]];
            }
            else
            {
                [_selectDateStr appendString:str];
                [addDateStr appendString:str];
            }
           // checkLab.text = addDateStr;
                NSLog(@"select = %@",_selectDateStr);
            price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",_RMB.intValue*zhong.text.intValue,_dollar.intValue*zhong.text.intValue];
            }
//            if (_tag==2) {
    //            0, headerLab.frame.size.height+10+i*43, 320, 43
    //            116, 13.5, 150, 16
    //            296.5, 13.5, 16, 16
                RTLabel *dateLabe = (RTLabel*)[self.view viewWithTag:11];
                UIButton *dateBtn = (UIButton*)[self.view viewWithTag:100];
                UIButton *orderCountBtn = (UIButton*)[self.view viewWithTag:101];
                UIButton *travellerCountBtn;
                UIButton *jiantouBtn = (UIButton*)[self.view viewWithTag:99];
                UIButton *Btn = (UIButton*)[self.view viewWithTag:12];

                
                dateLabe.text = addDateStr;
                float height = dateLabe.optimumSize.height+13;
                dateLabe.frame = CGRectMake(dateLabe.frame.origin.x, dateLabe.frame.origin.y, 185, height);
                Btn.frame = dateLabe.frame;
                dateBtn.frame = CGRectMake(0, dateBtn.frame.origin.y, 320, height>43?height+10:43);
                jiantouBtn.frame = CGRectMake(296.5, (dateBtn.frame.size.height-16)/2, 16, 16);
                orderCountBtn.frame = CGRectMake( 0, dateBtn.frame.origin.y+dateBtn.frame.size.height, 320, 43);
                float y;
                if (_ProdType.intValue==1) {
                  y = orderCountBtn.frame.origin.y+orderCountBtn.frame.size.height;
                }else {
                    
                    travellerCountBtn = (UIButton*)[self.view viewWithTag:102];
                    travellerCountBtn.frame = CGRectMake(0, orderCountBtn.frame.origin.y+orderCountBtn.frame.size.height, 320, 43);
                    y = travellerCountBtn.frame.origin.y+travellerCountBtn.frame.size.height;
                    NSLog(@"y %f",y);
                }
                
                footerView.frame = CGRectMake(0, y, 320, footerViewHeight);
                float headViewHeight = _ProdType.intValue==1?0:53;
                NSLog(@"headViewHeight %f",headViewHeight);
                [sv setContentSize:CGSizeMake(320, 40+43+dateBtn.frame.size.height+footerViewHeight+90+headViewHeight)];
        }

//    }
}
-(void)viewDidLoad{
    viewHeight=0;
    NSLog(@"_ProdType  %@",_ProdType);
    NSLog(@"_startDate2Str  %@",_startDate2Str);
    self.view.backgroundColor = BLACK_VIEW_COLOR;
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"MM月dd日"];
    
    _components = [[NSDateComponents alloc] init];
    [_components setDay:1];
    
    //加入sv
    sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.backgroundColor = BLACK_VIEW_COLOR;
    [self.view addSubview:sv];
    
    paytype=@"1";
    // _dayCount=@"1";
    
    //表头
    [self addHeaderView];
    
    //填写资料
    //  [self changeUserDataView:@"1"];
    
    //联系人、
    [self addLinkmanView];
    
    //预订须知
    [self addReseverKnowView];
    
    //支付方式
    [self addPayView];
    
    //下bar
    [self addBottomBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = rect.size.height;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    sv.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-height);
    [UIView commitAnimations];
    
}


- (void)keyboardWillHide:(NSNotification *)notif {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    sv.frame = self.view.bounds;
    [UIView commitAnimations];
}

- (void)addHeaderView{
    RTLabel *headerLab;
    if (_tag==2) {
        if (_ProdType.intValue==1) {
            
            headerLab = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
            headerLab.text=[NSString stringWithFormat:@"<font  size=14 color=black><b>%@</b></font> <font  size=12 color=gray>%@ %@</font> <font size=12>%@</font>",_nameStr,_countryStr,_sexStr,_carAndGuideTypeStr];
            headerLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
            NSLog(@"%@",headerLab.text);
            //headerLab.font = [UIFont boldSystemFontOfSize:18];
            [sv addSubview:headerLab];
            
        }else if (_ProdType.intValue==2){
            headerLab = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, 300, 42)];
            headerLab.text=[NSString stringWithFormat:@"<font  size=16 color=red><b>%@</b></font>\n<font  size=12 color=black>%@</font> ",_nameStr,_CNUStudentStr];
            //headerLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
            headerLab.lineSpacing=3;
            NSLog(@"%@",headerLab.text);
            //headerLab.font = [UIFont boldSystemFontOfSize:18];
            [sv addSubview:headerLab];
        }
    }else if (_tag==3){
        headerLab = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
        headerLab.text=[NSString stringWithFormat:@"<font  size=14 color=black><b>%@</b></font> <font  size=12 color=gray>%@ %@</font> <font size=12>%@ %@ %@</font>",_nameStr,_countryStr,_sexStr,_peopleCountStr,_carTypeStr,_jichengStr];
        headerLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        [sv addSubview:headerLab];
    }
    int count = 2;
    if (_ProdType.intValue==2) {
        count = 3;
    }
    NSArray *imageNames = @[@"住宿预订第1步_03",@"导游预订第1步（企业）_03",@"住宿预订第1步_03-09"];
    NSArray *names = @[@"选择日期",@"预订数量",@"游客数量"];
    for (int i=0; i<count; i++) {
        
        UIButton *bv = [[UIButton alloc]initWithFrame:CGRectMake(0, headerLab.frame.size.height+10+i*43, 320, 43)];
        UIImage *image ;
        if (count==2) {
            image  = [UIImage imageNamed:i==0?@"MyDownCell":@"MyUpCell"];
        }else image = [UIImage imageNamed:i==0?@"MyDownCell":i==2?@"MyUpCell":@"MyCenter"];
        [bv setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2] forState:UIControlStateNormal];
        [sv addSubview:bv];
        bv.tag =100+i;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13.5, 16, 16)];
        iv.image=[UIImage imageNamed:imageNames[i]];
        [bv addSubview:iv];
        
        UILabel *name= [[UILabel alloc] initWithFrame:CGRectMake(36, 14, 70, 16)];
        name.font = [UIFont systemFontOfSize:16];
        name.text = names[i];
        name.textColor = [UIColor grayColor];
        [bv addSubview:name];
        switch (i) {
            case 0:{
                [bv setBackgroundImage:[UIImage imageNamed:@"mine_newsAndSet_h"] forState:UIControlStateHighlighted];
                [bv addTarget:self action:@selector(gotoChangeDate:) forControlEvents:UIControlEventTouchUpInside];
                //前日期
                RTLabel *date= [[RTLabel alloc] initWithFrame:CGRectMake(116, 13, 185, 16)];
                date.font = [UIFont systemFontOfSize:16];
                date.userInteractionEnabled = YES;
                date.tag = 11;
                [bv addSubview:date];
                
                UIButton *btn1 = [[UIButton alloc]init];
                btn1.frame = date.frame;
                btn1.tag = 12;
                [btn1 addTarget:self action:@selector(gotoChangeDate:) forControlEvents:UIControlEventTouchUpInside];
                [bv addSubview:btn1];
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:@"cellJianTou"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(296.5, 13.5, 16, 16);
                btn.tag = 99;
                [bv addSubview:btn];
            }
                
                
                break;
            case 1:{
                
                [bv setBackgroundImage:[UIImage imageNamed:@"MyCenter"] forState:UIControlStateHighlighted];
                UIView *v = [[UIView alloc]initWithFrame:CGRectMake(116, 7, 60+41, 29)];
                jian = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 29)];
                [jian setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateNormal];
                [jian setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateHighlighted];
                [jian addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
                jian.tag = 1;
                jian.enabled=NO;
                [v addSubview:jian];
                
                zhong = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, 41, 29)];
                zhong.textAlignment = NSTextAlignmentCenter;
                zhong.textColor = [UIColor colorWithRed:0 green:109/255.0 blue:184/255.0 alpha:1];
                zhong.enabled = NO;
                zhong.layer.contents = (id)[UIImage imageNamed:@"zhong"].CGImage;
                zhong.text = @"1";
                [v addSubview:zhong];
                
                jia = [[UIButton alloc]initWithFrame:CGRectMake(71, 0, 30, 29)];
                [jia setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                [jia setBackgroundImage:[UIImage imageNamed:@"jia2"] forState:UIControlStateHighlighted];
                [jia addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
                jia.tag = 2;
                [v addSubview:jia];
                [bv addSubview:v];
                
            }
                
                break;
            case 2:{
                
                [bv setBackgroundImage:[UIImage imageNamed:@"MyUpCell"] forState:UIControlStateHighlighted];
                UIView *v = [[UIView alloc]initWithFrame:CGRectMake(116, 7, 60+41, 29)];
                jian2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 29)];
                [jian2 setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateNormal];
                [jian2 setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateHighlighted];
                [jian2 addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
                jian2.tag = 1;
                jian2.enabled=NO;
                [v addSubview:jian2];
                
                zhong2 = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, 41, 29)];
                zhong2.textAlignment = NSTextAlignmentCenter;
                zhong2.textColor = [UIColor colorWithRed:0 green:109/255.0 blue:184/255.0 alpha:1];
                zhong2.enabled = NO;
                zhong2.layer.contents = (id)[UIImage imageNamed:@"zhong"].CGImage;
                zhong2.text = @"1";
                [v addSubview:zhong2];
                
                jia2 = [[UIButton alloc]initWithFrame:CGRectMake(71, 0, 30, 29)];
                [jia2 setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                [jia2 setBackgroundImage:[UIImage imageNamed:@"jia2"] forState:UIControlStateHighlighted];
                [jia2 addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
                jia2.tag = 2;
                [v addSubview:jia2];
                [bv addSubview:v];
               
            }
                break;
            default:
                break;
        }
    }
    
    //    RTLabel *lastLab = [[RTLabel alloc] initWithFrame:CGRectMake(10, 254, 300, 40)];
    //    lastLab.font = [UIFont systemFontOfSize:10];
    //    lastLab.textColor = [UIColor grayColor];
    //    lastLab.text = @"• 请如实填写入住人的真实信息，信息需与护照信息一致。\n• 入住人信息一经提交后，不可更改。请慎重填写，以免影响入住。";
    //    [sv addSubview:lastLab];
    
}
- (void)gotoChangeDate:(UIButton*)btn{
    
    GCCalenderViewController *mcvc = [GCCalenderViewController new];
    mcvc.title = @"选择日期";
//    mcvc.RMB = _RMB;
//    mcvc.dollar = _dollar;
//    mcvc.ProdType = _ProdType;
    mcvc.CGRV = self;
    mcvc.guideType = _ProdType;
    mcvc.ID = _ID;
//    mcvc.startDate2Str = _startDate2Str;
//    if (_selectDays) {
//        mcvc.selectDays = _selectDays;
//    }
    [self.navigationController pushViewController:mcvc animated:NO];
    
}
- (void)changeCount:(UIButton*)btn{
    if (btn.superview.superview.tag==101) {
        switch (btn.tag) {
                
            case 1:{
                //第一个减
                
                zhong.text = [NSString stringWithFormat:@"%d",[zhong.text intValue]-1];
                
            }
                
                break;
            case 2://第一个加
            {
                
                zhong.text = [NSString stringWithFormat:@"%d",[zhong.text intValue]+1];
            }
                break;
                
                
            default:
                break;
                
                
        }
        if (zhong.text.intValue==1) {
            [jian setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateNormal];
            jian.enabled=NO;
        }
        else if([self.peopleCountStr integerValue] >= 10 ||
                 [self.peopleCountStr integerValue] == 0)
        {
            if (zhong.text.integerValue == 10)
            {
                [jia setBackgroundImage:[UIImage imageNamed:@"jia2"] forState:UIControlStateNormal];
                jia.enabled=NO;
            }
            else
            {
                [jian setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
                jian.enabled=YES;
                
                [jia setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                jia.enabled=YES;
            }
        }
        else
        {
            if (zhong.text.intValue==[self.peopleCountStr integerValue])
            {
                [jia setBackgroundImage:[UIImage imageNamed:@"jia2"] forState:UIControlStateNormal];
                jia.enabled=NO;
            }else{
                [jian setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
                jian.enabled=YES;
                
                [jia setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                jia.enabled=YES;
            }
 
        }
            
            }else if(btn.superview.superview.tag==102){
        switch (btn.tag) {
                
            case 1:{
                //第一个减
                
                zhong2.text = [NSString stringWithFormat:@"%d",[zhong2.text intValue]-1];
                
            }
                
                break;
            case 2://第一个加
            {
                
                zhong2.text = [NSString stringWithFormat:@"%d",[zhong2.text intValue]+1];
            }
                break;
                
                
            default:
                break;
                
                
        }
        if (zhong2.text.intValue==1) {
            [jian2 setBackgroundImage:[UIImage imageNamed:@"jian2"] forState:UIControlStateNormal];
            jian2.enabled=NO;
        }else if (zhong2.text.intValue==10){
            [jia2 setBackgroundImage:[UIImage imageNamed:@"jia2"] forState:UIControlStateNormal];
            jia2.enabled=NO;
        }else{
            [jian2 setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
            jian2.enabled=YES;
            
            [jia2 setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
            jia2.enabled=YES;
        }
    }
    int days=1;
    if (_selectDays) {
        days = _selectDays.count;
    }
    price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",_RMB.intValue*zhong.text.intValue*days ,_dollar.intValue*zhong.text.intValue*days];
    
}
- (void)addLinkmanView{
    footerViewHeight = 0;
   // UIView *btnView = [self.view viewWithTag:2];btnView.frame.origin.y+btnView.frame.size.height+
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    
    UIView *linkmanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 248)];
    NSArray *linkmanNames = @[@"联系人信息",@"姓名",@"联系电话",@"电子邮箱",@"QQ",@"微信"];
    for (int i=0; i<6; i++) {
        UIButton *bv = [[UIButton alloc]initWithFrame:CGRectMake(0, 10+i*43, 320, 43)];
        [bv setBackgroundImage:[UIImage imageNamed:i==0?@"MyDownCell":i==5?@"MyUpCell":@"MyCenter"] forState:UIControlStateNormal];
        [linkmanView addSubview:bv];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 13.5, 140, 16)];
        name.font = [UIFont systemFontOfSize:i==0?12.5:16];
        name.text = linkmanNames[i];
        name.textColor =  i==0?[UIColor blackColor]:[UIColor grayColor];
        [bv addSubview:name];
        
        if (i!=0) {
            UITextField *file = [[UITextField alloc] initWithFrame:CGRectMake(116, 0, 230, 43)];
            file.tag = [NSString stringWithFormat:@"100%d",i].intValue;
            file.font = [UIFont systemFontOfSize:16];
            file.delegate = self;
            [bv addSubview:file];
            if (i==4||i==5) {
                file.placeholder = @"选填";
            }
        }
    }
    [footerView addSubview:linkmanView];
    footerViewHeight = 248;
    [sv addSubview:footerView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:NO];
    return YES;
}
- (void)addReseverKnowView{
    
    if (_reseverKnowStr.length>0) {
        RTLabel *content = [[RTLabel alloc] initWithFrame:CGRectMake(10, 43+10, 300, 0)];
        content.text = _reseverKnowStr;
        content.font = [UIFont systemFontOfSize:11];
        content.frame = CGRectMake(10, 43+10, 300, content.optimumSize.height);
        
        UIView *rkv = [[UIView alloc] initWithFrame:CGRectMake(0, footerViewHeight+20, 320, 43+content.optimumSize.height+10)];
        
        for (int i=0; i<2; i++) {
            
            UIImageView *bv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43*i, 320, i==0?43:content.optimumSize.height+20)];
            [bv setImage:[UIImage imageNamed:i==0?@"MyDownCell":@"MyUpCell"]];
            [rkv addSubview:bv];
            if (i==0) {
                UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 15.5, 15.5)];
                iv.image = [UIImage imageNamed:@"预订须知"];
                [bv addSubview:iv];
                
                UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(35.5, 0, 70, 43)];
                name.font = [UIFont systemFontOfSize:12.5];
                name.text = @"预订须知";
                [bv addSubview:name];
            }
        }
        footerViewHeight = footerViewHeight+20+43+content.optimumSize.height+10;
        [footerView addSubview:rkv];
        [rkv addSubview:content];
    }
    
    
    // [sv setContentSize:CGSizeMake(320, 763+53+content.optimumSize.height+80)];
}
- (void)addPayView{
    pointIVArr = [NSMutableArray array];
    int count=_payWay.intValue==1?6:7;
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, footerViewHeight+20, 320, count*43)];
    // payView.backgroundColor = [UIColor redColor];
    NSArray *names = @[@"选择支付方式",@"微信支付",@"支付宝客户端支付",@"支付宝网页支付",@"手机银联支付",@"信用卡支付",@"当面支付"];
    NSArray *imageNames = @[@"",@"weixin",@"zhi",@"zhifubao",@"yinlian",@"xinyongka",@"dangmian"];
    for (int i=0; i<count; i++) {
        UIImageView *bv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10+i*43, 320, 43)];
        [bv setImage:[UIImage imageNamed:i==0?@"MyDownCell":i==6?@"MyUpCell":@"MyCenter"]];
        bv.userInteractionEnabled = YES;
        [payView addSubview:bv];
        
        UILabel *name = [[UILabel alloc]init];
        name.text = names[i];
        if (i!=0) {
            name.frame = CGRectMake(64, 0, 140, 43);
            name.font = [UIFont systemFontOfSize:16];
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 44, 29)];
            iv.image = [UIImage imageNamed:imageNames[i]];
            [bv addSubview:iv];
            
            //点点
            UIImageView *point = [[UIImageView alloc] initWithFrame:CGRectMake(290, 12.5, 20, 20)];
            point.tag = i;
            point.image = [UIImage imageNamed:i==1?@"住宿预订第1步_19":@"住宿预订第1步_19-14"];
            point.userInteractionEnabled = YES;
            [bv addSubview:point];
            [pointIVArr addObject:point];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPayWay:)];
            [point addGestureRecognizer:tap];
        }else{
            name.frame = CGRectMake( 10, 0, 140, 43);
            name.font = [UIFont systemFontOfSize:12.5];
        }
        [bv addSubview:name];
        
    }
    UIView *btnView = [self.view viewWithTag:_ProdType.intValue==1?101:102];
    
#warning Changed...     注释下面两行，并把选择支付方式挪到下个页面
//    [footerView addSubview:payView];
//    footerViewHeight = footerViewHeight+10+count*43;
    footerView.frame = CGRectMake(0, btnView.frame.origin.y+btnView.frame.size.height, 320, footerViewHeight);
    //[sv setContentSize:CGSizeMake(320, footerViewHeight+80+_ProdType.intValue==1?188:230)];
    float headViewHeight = _ProdType.intValue==1?188:230;
    [sv setContentSize:CGSizeMake(320, headViewHeight+footerViewHeight+60)];
    // NSLog(@"1 vjiewHeight %f footerViewheight %f",viewHeight,footerViewHeight);
    
}
- (void)selectPayWay:(UITapGestureRecognizer*)tap{
    NSLog(@"tag  %d",tap.view.tag);
    paytype = [NSString stringWithFormat:@"%d",tap.view.tag];
    UIImageView *iv = (UIImageView*)tap.view;
    for (int i=1;  i<=pointIVArr.count; i++) {
        if (tap.view.tag==i) {
            iv.image = [UIImage imageNamed:@"住宿预订第1步_19"];
        }else{
            [(UIImageView*)pointIVArr[i-1] setImage:[UIImage imageNamed:@"住宿预订第1步_19-14"]];
        }
    }
}
- (void)addBottomBar{
    UIImageView*guding=[[UIImageView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-45, 320, 45)];
    guding.userInteractionEnabled=YES;
    guding.image=[UIImage imageNamed:@"guding.png"];
    [self.view addSubview:guding];
    //价格和预订
    
    price=[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, 150, 25)];
    price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",_RMB,_dollar];
    price.font = [UIFont systemFontOfSize:13.5];
    [guding addSubview:price];
    
    //预订按钮////////////////////////////////////
    UIButton*orderButton=[UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.layer.cornerRadius=4;
    orderButton.titleLabel.font = [UIFont systemFontOfSize:13.5];
    orderButton.frame=CGRectMake(240,10, 72.5, 25);
    //orderButton.tag = [[dataArray[index] objectForKey:@"ID"] integerValue];
    orderButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"13"]];
    [orderButton addTarget:self action:@selector(goUpOrder) forControlEvents:UIControlEventTouchUpInside];
    [orderButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [guding addSubview:orderButton];
}
//埋单 提交数据
- (void)goUpOrder{
    
    UILabel *lab = (UILabel*)[sv viewWithTag:11];
    

    if (lab.text.length==0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:[NSString  stringWithFormat:@"日期不能为空"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
        // roomInformationStr=[NSMutableString new];
        return;
    }
    
    //判断联系人输入内容
    for (int i=1; i<=5; i++) {
        UITextField *file = (UITextField*)[sv viewWithTag:[NSString stringWithFormat:@"100%d",i].intValue];
        NSLog(@"file %@",file.text);
        if (file.text.length==0&&i<4) {
            NSString *name = i==1?@"姓名":i==2?@"联系电话":@"电子邮箱";
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@不能为空",name] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [av show];
           // userConnectInformationStr=[NSMutableString new];
            return;
        }
        
    }
    
    NSMutableString *urlStr = RussiaUrl5;
    [urlStr appendString:@"getAddGuideOrder"];
    int days = 1;
    if (_selectDays) {
        days=_selectDays.count;
    }
    int d = [_RMB intValue]*[zhong.text intValue]*days;
    int r = [_dollar intValue]*[zhong.text intValue]*days;
    // price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",d,r];
//  导游/租车预订：参数（prodid：导游/租车产品ID，prodtype：1是导游订单2是租车订单，classid：预订代理商的产品类别，userid：预订人的用户ID,username：预订人的用户名,sdate：所选日期,pcount：游客数量，gcount：所需导游数/车辆数,cmoney：人民币,umoney：美元,uname：姓名,phone：电话,email：邮箱,qq：qq,weixin：微信,paytype：1微信支付，2支付宝客户端支付，3支付宝网页支付，4手机银联支付，5信用卡支付，6当面支付）
    int typeCount;
    NSString *classStr;
    if (_ProdType.intValue==1) {
        classStr=@"0";
    }else classStr = _CNUStudentStr;
    if (_tag==2) {
        typeCount=1;
    }else typeCount = 2;
    
#warning Changed...     把 paytype = %@，paytype改为了 paytype = %d，0
    NSString *argStr = [NSString stringWithFormat:@"prodid=%@&prodtype=%d&classid=%@&userid=%@&username=%@&sdate=%@&pcount=%@&gcount=%@&cmoney=%d&umoney=%d&uname=%@&phone=%@&email=%@&qq=%@&weixin=%@&paytype=%d",_ID,
                        typeCount,
                        classStr,
                        GET_USER_DEFAUT(QUSE_ID),
                        GET_USER_DEFAUT(USER_NAME),
                        _selectDateStr,zhong.text,
                        _ProdType.intValue==2?zhong2.text:@"0",
                        d,r,[(UITextField*)[footerView viewWithTag:1001] text],[(UITextField*)[footerView viewWithTag:1002] text],[(UITextField*)[footerView viewWithTag:1003] text],[(UITextField*)[footerView viewWithTag:1004] text],[(UITextField*)[footerView viewWithTag:1005] text],0];
    NSLog(@"%@",argStr);
    
    postRequestYiBu(argStr, urlStr)
    
}
postRequestAgency(datas)
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBuNoDic(datas, result)
    NSLog(@"result %@",result);
    if (result.intValue>0) {
        OrderViewController *ovc = [OrderViewController sharedOrderViewController];
        ovc.presentWay = 0;
        ovc.orderNumber = result;
        ovc.RMB=_RMB;
        ovc.dollar=_dollar;
        ovc.dayCount=@"1";
        ovc.roomCount=[NSString stringWithFormat:@"%d",zhong.text.intValue];
        ovc.selectPayWay=paytype;
        ovc.productDescription=_roomFacilityStr;
//      ovc.productName=[NSString stringWithFormat:@"%@ %@",_chineseStr,_roomTypeStr];
        [self.navigationController pushViewController:ovc animated:NO];
    }else if (result.intValue==0){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"预订失败，请重新预订。" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [av show];
    }else if (result.intValue==-1){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"已经超出了预订时间，请重新预订。" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [av show];
    }
}
@end
