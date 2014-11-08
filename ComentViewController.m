//
//  ComentViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "ComentViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "ComentCell.h"
#import "FeedBackViewController.h"
@interface ComentViewController ()

@end

@implementation ComentViewController


-(void)viewWillAppear:(BOOL)animated
{
     hideTabbar
    [self.navigationItem setNewTitle:self.pageName];
    NSString*canshu=[NSString stringWithFormat:@"ID=%d&classid=%d&pagesize=%d&pageindex=%d",self.ID,self.type,10,index1];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"getProductMessage";
    [urlDomain appendString:urlMethod];

    postRequestYiBu(canshu, urlDomain)


}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BLACK_VIEW_COLOR;
    picArray=[NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-64-60+10) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = BLACK_VIEW_COLOR;
    _tableView.separatorColor=[UIColor clearColor];
    
    
    
    refresh=[[UIRefreshControl alloc] init];
    refresh.tintColor=[UIColor darkGrayColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@"松开刷新"];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refresh];
    //点评头
    [self commentHeadView];
    array=[NSMutableArray new];
    
    
    //下bar
    if (GET_USER_DEFAUT(USER_NAME)) {
        tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(-.5, DeviceHeight-113.5, 321, 50)];
        tableFooterView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        tableFooterView.layer.borderWidth = .5;
        tableFooterView.layer.borderColor = [UIColor grayColor].CGColor;
        [self.view addSubview:tableFooterView];
        
        _textField=[[UITextView alloc]initWithFrame:CGRectMake(10, 9.5, 233, 31)];
        _textField.layer.contents = (id)([UIImage imageNamed:@"travel_reply2.png"].CGImage);
        [tableFooterView addSubview:_textField];
        
        UIButton*send=[UIButton buttonWithType:UIButtonTypeCustom];
        send.frame=CGRectMake(253, 9.5, 57, 31);
        send.layer.borderWidth = .3;
        send.layer.cornerRadius = 4;
        send.layer.borderColor = [UIColor grayColor].CGColor;
        [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        [send setTitle:@"发送" forState:UIControlStateNormal];
        [send setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tableFooterView addSubview:send];
        isComent=NO;
    }else _tableView.frame = CGRectMake(0, 0, 320, DeviceHeight-64+10);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddKeyboard)];
    [_tableView addGestureRecognizer:tap];
    
}
- (void)commentHeadView{
    //头view
    UIView*headView=[[UIView alloc]init];
    //俄文
    RTLabel*head=[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 0)];
    head.font=[UIFont boldSystemFontOfSize:18];
    head.text=self.eTittle==nil?self.head:self.eTittle;
    
    CGSize size=[head optimumSize];
    head.lineSpacing = 1;
    head.frame=CGRectMake(10, 10, 300, size.height);
    [headView addSubview:head];
    //中文
    RTLabel*ehead=[[RTLabel alloc]initWithFrame:CGRectMake(10, 0, 300, 0)];
    ehead.font=[UIFont boldSystemFontOfSize:14];
    ehead.text=self.eTittle==nil?nil:self.head;
    CGSize size2=[ehead optimumSize];
    ehead.textColor = [UIColor grayColor];
    ehead.frame=CGRectMake(10,self.eTittle==nil?head.frame.size.height+10:head.frame.size.height+15, 300, size2.height);
    [headView addSubview:ehead];
    
    UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, ehead.frame.origin.y+ehead.frame.size.height+10, 320, 2)];
    link.image=[UIImage imageNamed:@"entainmentLink"];
    [headView addSubview:link];
    
    headView.frame=CGRectMake(10, 0, 300, ehead.frame.origin.y+ehead.frame.size.height+10);
    _tableView.tableHeaderView=headView;
    headView.backgroundColor = BLACK_VIEW_COLOR;
    [self.view addSubview:_tableView];
}
- (void)hiddKeyboard{
    [_textField resignFirstResponder];
}

-(void)refreshData
{

    NSString*canshu=[NSString stringWithFormat:@"ID=%d&classid=%d&pagesize=%d&pageindex=%d",self.ID,self.type,10,index1];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"getProductMessage";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)



}

//发评论
-(void)send
{
    [_textField resignFirstResponder];

    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int b=[defaults integerForKey:@"QuseID"];
    if (b)
    {
        if (_textField.text.length)
        {
            NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
            NSString*canshu=[NSString stringWithFormat:@"ID=%@&classid=%d&userid=%d&username=%@&content=%@",ID,self.type,b,[defaults valueForKey:@"useName"],_textField.text];
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getAddProductMessage";
            [urlDomain appendString:urlMethod];
            postRequestYiBu(canshu, urlDomain)
            isComent=YES;
        }
        else
        {
            UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"评论不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertView show];
            
        }
        
    }
    else
    {
        MineViewController*mine=[MineViewController new];
        mine.tag=1;
        [self.navigationController pushViewController:mine animated:NO];
        
    }
    
    
    
}
postRequestAgencyAndRefesh(datas, refresh)
-(void) keyboardWillShow:(NSNotification *)note{
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [_tableView convertRect:keyboardBounds toView:nil];
	CGRect containerFrame = CGRectMake(0, 0, 320, DeviceHeight-64-60+10);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
  
    _tableView.frame = CGRectMake(0, 0, containerFrame.size.width, containerFrame.size.height-keyboardBounds.size.height);
    tableFooterView.frame = CGRectMake(-.5, DeviceHeight-keyboardBounds.size.height-113.5, 321, 50);
    
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [_tableView convertRect:keyboardBounds toView:nil];
	CGRect containerFrame = _tableView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    _tableView.frame = CGRectMake(0, 0, containerFrame.size.width, containerFrame.size.height+keyboardBounds.size.height);
    tableFooterView.frame = CGRectMake(-.5, DeviceHeight-113.5, 321, 50);
	[UIView commitAnimations];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"cell";
    ComentCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[ComentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
        NSString*str2=[[array objectAtIndex:indexPath.row]valueForKey:@"PTime"];
    //_dayLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>$</font><font size=15 color=orange>520</font><font  size=12 color=gray>/天,每天工作8小时</font>"];
    cell.name.text = [NSString stringWithFormat:@"<font color='#006db8'>%@</font> <font size=10 color=gray>%@</font>",[[array objectAtIndex:indexPath.row]valueForKey:@"UserName"],[str2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
//    cell.name.text=[[array objectAtIndex:indexPath.row]valueForKey:@"UserName"];
//    cell.date.text=[str2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    cell.comment.text=[[array objectAtIndex:indexPath.row]valueForKey:@"Content"];
    CGSize size=[cell.comment optimumSize];
    cell.comment.frame=CGRectMake(60, 30, 250, size.height);
    NSLog(@"%f %f %f %f",10.0, cell.comment.frame.origin.y+cell.comment.frame.size.height, 300.0, 2.0);
     float linkFrameHeigh = cell.comment.frame.origin.y+cell.comment.frame.size.height<53?66:cell.comment.frame.origin.y+cell.comment.frame.size.height+24;
    cell._imageView.frame=CGRectMake(10, linkFrameHeigh, 300, 2);
    
    //投诉按钮
    cell.feedBackBtn.frame = CGRectMake(280, cell._imageView.frame.origin.y-6.5-11, 30, 11);
    cell.feedBackBtn.tag = indexPath.row;
    [cell.feedBackBtn addTarget:self action:@selector(goFeedBack:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [LINE_VIEW_C loadPic_tableViewDataArray:array objectAtIndex:indexPath.row objectForKey:@"ImgTouX" picHeadUrlStr:PicUrlWWW picUrlPathStr:@"Personal" PicLoadName:cell.name.text headView:cell.headImage];
    return cell;
    
}
//投诉
- (void)goFeedBack:(UIButton *)btn{
    if (GET_USER_DEFAUT(USER_NAME)&&[GET_USER_DEFAUT(QUSE_ID) intValue]!=[[array[btn.tag] objectForKey:@"UserID"] intValue]) {
        FeedBackViewController *feedBack = [FeedBackViewController new];
        feedBack.mesid = [array[btn.tag] objectForKey:@"ID"];
        [self.navigationController pushViewController:feedBack animated:NO];
    }else if ([GET_USER_DEFAUT(QUSE_ID) intValue]==[[array[btn.tag] objectForKey:@"UserID"] intValue]){
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"不能投诉自己的评论!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
    } else{
    
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"请您先登录!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        av.tag = 1;
        [av show];
        
    
    }
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            MineViewController*mine=[MineViewController new];
            mine.tag=1;
            [self.navigationController pushViewController:mine animated:NO];
        }
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComentCell*cell=(ComentCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGRect rect = cell.comment.frame;
//    float height = rect.origin.y+rect.size.height+13;
    float linkFrameHeigh = cell.comment.frame.origin.y+cell.comment.frame.size.height<53?68:cell.comment.frame.origin.y+cell.comment.frame.size.height+24+2;
    return  linkFrameHeigh;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    if (refresh.refreshing)
    {
        //时间的格式化输出，你还记得吗？自己看了吗？
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d,h:mm:ss a"];
        NSString *lastUp=[NSString stringWithFormat:@"上次更新时间：%@",[formatter stringFromDate:[NSDate date]]];
        refresh.attributedTitle=[[NSAttributedString alloc] initWithString:lastUp];
        [refresh endRefreshing];
    }

    
    
    
    dicResultYiBu(datas, result, dic)
    
    NSLog(@"dic=%@",dic);
    NSLog(@"result=%@",result);
    
    if (result.length>11)
    {
        
        array=[dic valueForKey:@"ds"];
     
        
        
    }

    if (array.count==0&&(result.length<12&&result.intValue==0)) {
        bv = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.tableHeaderView.frame.size.height+63, 320, 120)];
        bv.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView addSubview:bv];
        
        UIImageView *star = [[UIImageView alloc]initWithFrame:CGRectMake(124.5, 0, 71, 71)];
        star.image = [UIImage imageNamed:@"coment_noNumber.png"];
        [bv addSubview:star];
        
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 320, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text =[NSString stringWithFormat:@"暂无点评，快来点评一下吧~"];
        lab.font = [UIFont boldSystemFontOfSize:17];
        lab.textColor = [UIColor lightGrayColor];
        [bv addSubview:lab];
    }else {
        [bv removeFromSuperview];
        [_tableView reloadData];

    }
    
        //发表评论
    if (isComent==YES)
    {
        isComent=NO;
        if ([result intValue])
        {
            _textField.text=@"";
            UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"评论成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            NSString*canshu=[NSString stringWithFormat:@"ID=%d&classid=%d&pagesize=%d&pageindex=%d",self.ID,self.type,10,index1];
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getProductMessage";
            [urlDomain appendString:urlMethod];
            
            postRequestYiBu(canshu, urlDomain)
            
        }
        else
        {
            UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"评论失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];

        
        }
        
    }
    

    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
