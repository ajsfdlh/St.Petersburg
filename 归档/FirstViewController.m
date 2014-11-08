//
//  FirstViewController.m
//  通信界面
//
//  Created by li on 14-3-28.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "FirstViewController.h"
#import "ManageTableViewCell.h"
#import "UserTableViewCell.h"
#import "JSON.h"
#import "GDataXMLNode.h"

static int a = 1;
@interface FirstViewController ()

@end

@implementation FirstViewController{
    UITableView *myTableView;
    //总数据
    NSMutableArray *dataArray;
    UITextField *textFile;
    
}
backButton
#pragma mark --获取数据--
- (void)viewWillAppear:(BOOL)animated{
    //访问未读得信息
    if (_toTag==0) {
        [self go];
        if (dataArray.count>0) [self refresh];
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(go) userInfo:nil repeats:YES];
    }else if(_toTag==1){
        myTableView.frame = self.view.bounds;
        NSMutableString *urlStr = RussiaUrl3;
        [urlStr appendString:@"getALLUserMessageList"];
        NSString *argumentStr = [NSString stringWithFormat:@"cityid=%@&userid=%@",@"2",_userid];
        NSLog(@"%@",argumentStr);
        postRequestYiBu(argumentStr, urlStr)
    }
    
    
}
//backButton
- (void)go{
    
    if (dataArray.count==0) {
        NSMutableString *urlStr = RussiaUrl3;
        [urlStr appendString:@"getUserMessageList"];
        NSString *argumentStr = [NSString stringWithFormat:@"cityid=%@&userid=%@&typeid=%@",@"2",_userid,_type_id];
        postRequestYiBu(argumentStr, urlStr)
    }
    else {
        [self refresh];
    }
    
}
- (void)refresh{
    NSMutableString *urlStr = RussiaUrl3;
    [urlStr appendString:@"refreshData"];
    NSString *argumentStr = [NSString stringWithFormat:@"cityid=%@&userid=%@&servieid=%@&mid=%@&typeid=%@",@"2",_userid,[defaults objectForKey:QUSE_ID],[[dataArray lastObject]valueForKey:@"ID"],_type_id];
    postRequestYiBu(argumentStr, urlStr)
}
postRequestAgency(datas)
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBu(datas, result, dic)
    
    
   // NSLog(@"result==%d\n",result.length);
    // NSLog(@"result==%@",result);
     NSLog(@"dic===%@",dic);
    // NSLog(@"dics==%@",[dic valueForKey:@"ds"]);
    //空数据不接收
    
    if (result.length>11) {
        if (dataArray.count==0) {
            
            dataArray = [dic valueForKey:@"ds"];
            for (NSDictionary *dic2 in dataArray){
                
                _countCellHeight.text = [dic2 objectForKey:@"Message"];
                [_sayCellHeights addObject: [NSNumber numberWithFloat:_countCellHeight.optimumSize.height+11]];
                
            }
            NSString *dateStr = [[dataArray firstObject] objectForKey:@"PTime"];
            NSDictionary *diction = [NSDictionary dictionaryWithObject:dateStr forKey:@"date"];
            
            [dataArray insertObject:diction atIndex:0];
            [_sayCellHeights insertObject:[NSNumber numberWithFloat:18] atIndex:0];
        }else {
            //接收刷新的数据
            NSString *dateStr = [[[dic valueForKey:@"ds"] firstObject] objectForKey:@"PTime"];
            NSDictionary *diction = [NSDictionary dictionaryWithObject:dateStr forKey:@"date"];
            [dataArray addObject:diction];
            [_sayCellHeights addObject:[NSNumber numberWithFloat:18]];
            
            
            [dataArray addObject:[[dic valueForKey:@"ds"] firstObject]];
            _countCellHeight.text = [[[dic valueForKey:@"ds"] lastObject]objectForKey:@"Message"];
            [_sayCellHeights addObject: [NSNumber numberWithFloat:_countCellHeight.optimumSize.height+10]];
           // NSLog(@"_sayCellHeights  %@",_sayCellHeights);
            
        }
        NSLog(@" dataArray %@",dataArray);
        NSLog(@"_sayCellHeights  %@",_sayCellHeights);
        [myTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
        [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}
#pragma  mark --self view --

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"在线咨询";
    defaults = [NSUserDefaults standardUserDefaults];
    mainScreenFrame=[[UIScreen mainScreen]applicationFrame];
    self.view.frame = CGRectMake(0, mainScreenFrame.origin.y+44, 320, mainScreenFrame.size.height-44);
    hideTabbar
    _countCellHeight = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, 200, 0)];
    // self.view.backgroundColor = [UIColor redColor];
    _viewHeight = self.view.frame.size.height;
    _viewOY = self.view.frame.origin.y;
    _sayCellHeights = [NSMutableArray array];
    dataArray = [NSMutableArray array];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-46) style:UITableViewStylePlain];
    //    myTableView.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"myTableView==%f,%f,%f,%f",myTableView.frame.origin.x,myTableView.frame.origin.y,myTableView.frame.size.width,myTableView.frame.size.height);
    //myTableView.backgroundColor = [UIColor redColor];
    myTableView.delegate =self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.backgroundColor  = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1];
    //去线
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //下bar
    if (_toTag==0) {
        [self addBarView];
        
        
        
        
        //键盘通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(boardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(boardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        //收键盘
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [myTableView addGestureRecognizer:tap];
    }
    noNetButton=NoNetButton(noNetButton);
    
    Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([rea2  currentReachabilityStatus]==NotReachable)
    {
        
        noNetButton.hidden=NO;
    }
    else
    {
        noNetButton.hidden=YES;
    }
}
NetChange(noNetButton)
GO_NET
- (void)addBarView{
    barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-46, 320, 46)];
    barView.layer.borderWidth =.5f;
    barView.layer.borderColor = [UIColor colorWithRed:206.0/255 green:206.0/255 blue:206.0/255 alpha:.8f].CGColor;
    barView.backgroundColor = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1];
    //barView.backgroundColor= [UIColor redColor];
    
    
    textFile = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 240, 36)];
    textFile.borderStyle = UITextBorderStyleRoundedRect;
    textFile.backgroundColor = [UIColor whiteColor];
    textFile.delegate = self;
    [barView addSubview:textFile];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(255, 5, 60, 36);
    btn.layer.borderWidth=.3f;
    btn.layer.cornerRadius = 4.0f;
    btn.layer.borderColor=[UIColor grayColor].CGColor;
    //btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:btn];
    
    [self.view addSubview:barView];
}
- (void)tap{
    [textFile resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    
    [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height)];
    barView.frame =CGRectMake(0, _viewHeight-46, 320, 46);
    [UIView commitAnimations];
}
- (void)send{
    //发送信息并且加到本地数组刷新
    
    if (![textFile.text isEqualToString:@""]) {
        NSMutableString *urlStr;
        NSString *argumentStr;
        if ([[defaults objectForKey:QUSE_ID] intValue]>0&&[[defaults objectForKey:TYPE_ID] intValue]==2&&[[_editDic objectForKey:@"IsService"] intValue]>0) {
            urlStr = RussiaUrl3;
            [urlStr appendString:@"EditReplyMessage"];
            argumentStr = [NSString stringWithFormat:@"mid=%@&serviceid=%@&message=%@",[_editDic objectForKey:@"ID"],[defaults objectForKey:QUSE_ID],textFile.text];
            NSLog(@"%@",argumentStr);
            [dataArray removeObjectAtIndex:btnTag];
            [_sayCellHeights removeObjectAtIndex:btnTag];
            if ([[dataArray objectAtIndex:btnTag-1] objectForKey:@"date"]) {
                [dataArray removeObjectAtIndex:btnTag-1];
                [_sayCellHeights removeObjectAtIndex:btnTag-1];
            }
            _editDic=nil;
        }else if ([_type_id intValue]==1) {
            //访问发送数据接口和解析数据
            urlStr = RussiaUrl3;
            [urlStr appendString:@"AddUserMessage"];
            argumentStr = [NSString stringWithFormat:@"cityid=%@&userid=%@&username=%@&message=%@",@"2",_userid,_userName,textFile.text];
        }else if ([_type_id intValue]==2){
            
            NSString *ID;
            if (_editDic) {
                ID = [_editDic objectForKey:@"ID"];
            }else ID=[[dataArray lastObject] objectForKey:@"ID"];
            NSLog(@"IDIDIDIDIDID   %@",ID);
            urlStr = RussiaUrl3;
            [urlStr appendString:@"ReplyUserMessage"];
            //urlStr = @"http://192.168.0.156:805/ListServicet.asmx/ReplyUserMessage";
            argumentStr = [NSString stringWithFormat:@"cityid=%@&mid=%@&userid=%@&serviceid=%@&replyusername=%@&username=%@&message=%@",@"2",ID,[[dataArray lastObject] objectForKey:@"UserID"],[defaults objectForKey:QUSE_ID],_userName,[[dataArray lastObject] objectForKey:@"UserName"],textFile.text];
            NSLog(@"%@ %@",urlStr,argumentStr);
            _editDic=nil;
        }
        
        
        
        NSURL*url=[[NSURL alloc]initWithString:urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        NSData *data = [argumentStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSData *receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithData:receive options:0 error:nil];
        GDataXMLElement *e1=[document rootElement];
        NSString*result=[e1 stringValue];
        if ([result intValue]<0&&[[defaults objectForKey:TYPE_ID] intValue]==2) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此用户已回复" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [av show];
            return;
        }
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setLocale:[NSLocale currentLocale]];
        //2014/4/24 16:19:43
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSDictionary *diction = [NSDictionary dictionaryWithObject:str forKey:@"date"];
        [dataArray addObject:diction];
        [_sayCellHeights addObject:[NSNumber numberWithFloat:18]];
        
        
        NSDictionary *dic = @{@"ID":result,@"UserName":_userName,@"Message": textFile.text,@"UserID":_userid,@"IsService":[defaults objectForKey:QUSE_ID]};
        [dataArray addObject:dic];
        //获取信息高度
        _countCellHeight.text = [dic objectForKey:@"Message"];
        [_sayCellHeights addObject: [NSNumber numberWithFloat:_countCellHeight.optimumSize.height+10]];
        [myTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
        [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
    textFile.text=@"";
    
}
- (void)boardWillShow:(NSNotification*)notification{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    // NSLog(@"%@",userInfo);
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25f];
    float height=[[userInfo objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue].size.height;
    if (height==216) {
        
        if (a%2&&self.view.frame.size.height==_viewHeight) {
            //第一次弹出英文键盘
            //英文转中文
            myTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-216-46);
            barView.frame =CGRectMake(0, self.view.frame.size.height-216-46, 320, 46);
            [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height-216)];
            a++;
        }else{
            //降
            [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height+252-216)];
            myTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-46);
            barView.frame =CGRectMake(0, self.view.frame.size.height-46, 320, 46);
        }
        
    }else if(height==252){
        if (self.view.frame.size.height==_viewHeight) {
            //中文键盘1次
            myTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-252-46);
            barView.frame =CGRectMake(0, self.view.frame.size.height-252-46, 320, 46);
            [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height-252)];
        }else{
            //中文键盘2次
            myTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-252+216-46);
            barView.frame =CGRectMake(0, self.view.frame.size.height-252+216-46, 320, 46);
            [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height-252+216)];
        }
        
    }
    
    
    [UIView commitAnimations];
    if (dataArray.count>0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
        [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
- (void)boardWillHide:(NSNotification*)notification{
    a--;
    //NSDictionary *userInfo = [notification userInfo];
    //NSLog(@"%@",userInfo);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25f];
    [self.view setFrame:CGRectMake(0, 0, 320, _viewHeight)];
    myTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-46);
    barView.frame =CGRectMake(0, self.view.frame.size.height-46, 320, 46);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    if ([[[dataArray lastObject] objectForKey:@"IsService"] intValue]&&[[defaults objectForKey:TYPE_ID] intValue]==2) {
    //        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不能对客服的回答进行回复！(默认回复最后一个)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [av show];
    //        return NO;
    //    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([[[dataArray lastObject] objectForKey:@"IsService"] intValue]>0&&[[defaults objectForKey:TYPE_ID] intValue]==2&&_editDic==nil) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不能对客服的回答进行回复(默认回复最后一个),请点击客户回复！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
        [textField resignFirstResponder];
        [UIView beginAnimations:nil context:nil];
        
        [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height)];
        barView.frame =CGRectMake(0, _viewHeight-46, 320, 46);
        [UIView commitAnimations];
        return YES;
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textFile resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    
    [self.view setFrame:CGRectMake(0, _viewOY, 320, self.view.bounds.size.height)];
    barView.frame =CGRectMake(0, _viewHeight-46, 320, 46);
    [UIView commitAnimations];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}
#pragma mark -- tableViewDelegate --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d %@",indexPath.row,_sayCellHeights[indexPath.row]);
    if ([_sayCellHeights[indexPath.row] floatValue]>18&&[_sayCellHeights[indexPath.row] floatValue]<=50) {
        return  70;
    }else if ([_sayCellHeights[indexPath.row] floatValue]>50&&[_sayCellHeights[indexPath.row] floatValue]<=60){
        return  [_sayCellHeights[indexPath.row] floatValue]+30;
    }else if ([_sayCellHeights[indexPath.row] floatValue]>60&&[_sayCellHeights[indexPath.row] floatValue]<=200){
        return  [_sayCellHeights[indexPath.row] floatValue]+20;
    }else if ([_sayCellHeights[indexPath.row] floatValue]>200){
        return  [_sayCellHeights[indexPath.row] floatValue]+10;
    }
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //接收信息cell
      NSLog(@"%d %@",indexPath.row,_sayCellHeights[indexPath.row]);
    UserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (!userCell) {
        userCell = [[[NSBundle mainBundle]loadNibNamed:@"UserTableViewCell" owner:self options:nil]lastObject];
    }
    userCell.backgroundColor  = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1];
    //发信息cell
    ManageTableViewCell* manageCell = [tableView dequeueReusableCellWithIdentifier:@"manageCell"];
    if (!manageCell) {
        manageCell = [[[NSBundle mainBundle]loadNibNamed:@"ManageTableViewCell" owner:self options:nil]lastObject];
    }
    //日期时间
    UITableViewCell *dateCell = [tableView dequeueReusableCellWithIdentifier:@"dateCell"];
    if (!dateCell) {
        dateCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dateCell"];
    }
    dateCell.backgroundColor = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1];
    manageCell.backgroundColor  = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1];
    NSDictionary *dic = dataArray[indexPath.row];
    //NSLog(@"dic  %@",dic);
    if ([dic objectForKey:@"date"]) {
        //dateCell.textLabel.text= [dic objectForKey:@"date"];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 320, 20)];
        lab.text = [dic objectForKey:@"date"];
        lab.textColor = [UIColor grayColor];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1];
        [dateCell.contentView addSubview:lab];
        
        return dateCell;
    }else if (([[defaults objectForKey:TYPE_ID] intValue]==2&&[[dic valueForKey:@"IsService"] intValue]>0)||[[dic valueForKey:@"UserName"] isEqualToString:_userName]) {
        //        manageCell.name = [[RTLabel alloc]initWithFrame:CGRectMake(275, 53, 50, 21)];
        //        manageCell.name.textAlignment =NSTextAlignmentCenter;
        //        manageCell.name.text=[dic objectForKey:@"UserName"];
        //        manageCell.name.frame = CGRectMake(270, 53, 50, manageCell.name.optimumSize.height);
        //        [manageCell.contentView addSubview:manageCell.name];
        
        manageCell.sayLable = [[RTLabel alloc]initWithFrame:CGRectMake(10, 15, 200, 50)];
        manageCell.head.image = BACK_IMAGE;
        //[[MineViewController new]loadPic_tableViewIndexPath:indexPath headLabName:GET_USER_DEFAUT(USER_NAME) headView:manageCell.head];
        manageCell.sayLable.font = [UIFont systemFontOfSize:14];
        manageCell.sayLable.text = [dic objectForKey:@"Message"];
        manageCell.sayLable.frame = CGRectMake(320-manageCell.sayLable.optimumSize.width-80, 15, manageCell.sayLable.optimumSize.width, manageCell.sayLable.optimumSize.height);
        manageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *image = [UIImage imageNamed:@"SenderTextNodeBkg"];
        manageCell.backImage = [[UIImageView alloc]init];
        manageCell.backImage.frame = CGRectMake( manageCell.sayLable.frame.origin.x-18, 5, manageCell.sayLable.frame.size.width+40, manageCell.sayLable.frame.size.height+25);
        manageCell.backImage.image =[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [manageCell.contentView addSubview:manageCell.backImage];
        [manageCell.contentView addSubview:manageCell.sayLable];
        if ([[defaults valueForKey:TYPE_ID] intValue]==2&&[[dic valueForKey:@"UserName"] isEqualToString:[defaults objectForKey:USER_NAME]]&&_toTag==0) {
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            b.tag =indexPath.row;
            //b.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1 alpha:.1];
            [b addTarget:self action:@selector(touchCell:) forControlEvents:UIControlEventTouchUpInside];
            b.frame=manageCell.bounds;
            [manageCell.contentView addSubview:b];
        }
        return manageCell;
    }
    
    //    userCell.name = [[RTLabel alloc]initWithFrame:CGRectMake(0, 53, 50, 21)];
    //   // UILabel
    //    userCell.name.textAlignment =NSTextAlignmentCenter;
    //    userCell.name.text=[dic objectForKey:@"UserName"];
    //   // NSLog(@"dic==%@",[dic objectForKey:@"UserName"]);
    //    userCell.name.frame = CGRectMake(0, 53, 50, userCell.name.optimumSize.height);
    //    [userCell.contentView addSubview:userCell.name];
    userCell.head.image = BACK_IMAGE;
    [[MineViewController new]loadPic_tableViewIndexPath:indexPath headLabName:GET_USER_DEFAUT(USER_NAME) headView:userCell.head];
    userCell.sayLable = [[RTLabel alloc]initWithFrame:CGRectMake(80-3, 15, 200, 50)];
    userCell.sayLable.font = [UIFont systemFontOfSize:14];
    userCell.sayLable.text = [dic objectForKey:@"Message"];
    userCell.sayLable.frame = CGRectMake(80-3, 15, userCell.sayLable.optimumSize.width, userCell.sayLable.optimumSize.height);
    //CGRectMake(320-manageCell.sayLable.optimumSize.width-80, 15, manageCell.sayLable.optimumSize.width, manageCell.sayLable.optimumSize.height);
    UIImage *image = [UIImage imageNamed:@"ReceiverTextNodeBkgHL"];
    userCell.backImage = [[UIImageView alloc]init];
    userCell.backImage.frame = CGRectMake(55, 5, userCell.sayLable.frame.size.width+40, userCell.sayLable.frame.size.height+25);
    //userCell.backImage.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 40) resizingMode:UIImageResizingModeTile];
    userCell.backImage.image = [image stretchableImageWithLeftCapWidth: image.size.width/2 topCapHeight:image.size.height/2];
    [userCell.contentView addSubview:userCell.backImage];
    [userCell.contentView addSubview:userCell.sayLable];
    
    userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[defaults valueForKey:TYPE_ID] intValue]==2&&_toTag==0) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.tag =indexPath.row;
        // b.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1 alpha:.1];
        [b addTarget:self action:@selector(touchCell:) forControlEvents:UIControlEventTouchUpInside];
        b.frame=userCell.bounds;
        [userCell.contentView addSubview:b];
        
    }
    return userCell;
}
/*- (void)loadPic_tableViewIndexPath:(NSIndexPath*)indexPath headLabName:(NSString*)name headView:(UIImageView *)headView{
    //NSLog(@"picid %@",picID);
    if (name.length>4) {
        // NSLog(@"[[_dataArr objectAtIndex:indexPath.row] objectForKey:Pic]   %@",[[dataArr objectAtIndex:indexPath.row] objectForKey:picID]);
        NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(name)];
        
        if (pathData.length==0) {
            //[headAiv  startAnimating];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                picPath = [GET_USER_DEFAUT(TYPE_ID) intValue]==2?@"service":@"Personal";
                NSString *picUrl=[GET_USER_DEFAUT(TYPE_ID) intValue]==2?PicUrl:PicUrlWWW;
                NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@",picUrl,picPath,name];
                NSLog(@"picurl %@",urlStr);
                NSURL *url = [NSURL URLWithString:urlStr];
                NSLog(@"url %@",url);
                NSData *data = [NSData dataWithContentsOfURL:url];
                NSLog(@"data  %@",data);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data) {
                        
                        [data writeToFile:PathOfFile(name) atomically:YES];
                        
                        headView.image = [UIImage imageWithData:data];
                        [NSThread sleepForTimeInterval:1];
                        NSLog(@"data is yes");
                        
                    }//else headIV.image = [UIImage imageNamed:@"lack.jpg"];
                    
                    //[headAiv stopAnimating];
                    
                });
            });
        }else headView.image = [UIImage imageWithData:pathData];
        
    }//else  return [UIImage imageNamed:@"lack.jpg"];
}*/
- (void)touchCell:(UIButton *)btn{
    NSLog(@" indexPath.row  %d",btn.tag);
    NSLog(@"%@",dataArray[btn.tag]);
    btnTag=btn.tag;
    [textFile becomeFirstResponder];
    _editDic=dataArray[btn.tag];
    if ([[_editDic objectForKey:@"IsService"] intValue]!=0) {
        textFile.text=[dataArray[btn.tag] objectForKey:@"Message"];
    }//else textFile.text=@"";
    
    
    NSLog(@"_editDic %@",_editDic);
}









- (void)viewWillDisappear:(BOOL)animated{
    
    [_timer invalidate];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
