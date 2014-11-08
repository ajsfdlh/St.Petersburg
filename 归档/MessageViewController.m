//
//  MessageViewController.m
//  St.Petersburg
//
//  Created by li on 14-4-22.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MessageViewController.h"
#import "GDataXMLNode.h"
#import "FirstViewController.h"
#import "json.h"
#import "AppDelegate.h"
#import "NumberView.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

backButton
- (void)viewWillAppear:(BOOL)animated{
    //访问多客户来信接口
    //[(AppDelegate*)[UIApplication sharedApplication].delegate numberGo];
    [self changeNumber];
    newsNumber = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeNumber) userInfo:nil repeats:YES];
    
    
    [self go];
    
    
    timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(go) userInfo:nil repeats:YES];
}

- (void)changeNumber{
    NSMutableString *urlStr = RussiaUrl3;
    [urlStr appendString:@"getUserMessageCount"];
    NSString *argumentStr = [NSString stringWithFormat:@"cityid=%@&userid=%d&typeid=%@",@"2",[[[NSUserDefaults standardUserDefaults] objectForKey:QUSE_ID] intValue],[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID]];
    NSURL*url=[[NSURL alloc]initWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    NSData *data = [argumentStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSData *receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithData:receive options:0 error:nil];
    GDataXMLElement *e1=[document rootElement];
    NSString*result=[e1 stringValue];
    if ([result intValue]>0) {
        _btnLab.hidden=NO;
        [_btnLab setText:[NSString stringWithFormat:@"(%@)",result]];
    }else _btnLab.hidden=YES;
}
- (void)go{
    [self request1];
    [self request2];
}

- (void)request1{
    NSMutableString *urlStr = RussiaUrl3;
    NSString *urlStr2 = [NSString stringWithFormat:@"getReplyMessageList?cityid=2"];
    NSString *urlStr3 = [NSString stringWithFormat:@"%@%@",urlStr,urlStr2];
    
    NSURL *url = [NSURL URLWithString:urlStr3];
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request1 queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dicResultTongbu(data, result, dic)
        if (result.length>11) {
            _messages =[dic objectForKey:@"ds"];
        }//else _messages=nil;
        if (fromTag==0) {
            arr=_messages;
        }
        [self performSelectorOnMainThread:@selector(reload) withObject:result waitUntilDone:YES];
    }];
    
   
    
}
- (void)request2{
    NSMutableString *urlStr = RussiaUrl3;
    NSString *urlStr2 = [NSString stringWithFormat:@"getALLMessageList?cityid=2"];
    NSString *urlStr3 = [NSString stringWithFormat:@"%@%@",urlStr,urlStr2];
    NSURL *url = [NSURL URLWithString:urlStr3];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dicResultTongbu(data, result, dic)
        if (result.length>11) {
            _oldMessages =[dic objectForKey:@"ds"];
        }//else _oldMessages=nil;
        
        [self performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone:YES];
    }];
    
}
- (void)reload{
    [_tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    hideTabbar
    // Do any additional setup after loading the view.
    
    defaults=[NSUserDefaults standardUserDefaults];
    queue = [[NSOperationQueue alloc]init];
    [queue setMaxConcurrentOperationCount:1];
    _messages = [NSMutableArray array];
    _oldMessages = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:0.9f];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    //leftView.backgroundColor = [UIColor redColor];
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 120, 50);
    [btn setTitle:@"最新留言" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:19.0/255 green:87.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"messageleft2"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:btn];
    _btnLab = [[NumberLabel alloc]initWithFrame:CGRectMake(89, 18, 40, 20)];
    [btn addSubview:_btnLab];
//    NumberView *NV = [[NumberView alloc]initWithFrame:CGRectMake(89, 18, 40, 20)];
   // NV.center = CGPointMake(button.frame.size.width-10, 10);
//    if ([NV.numberLabel.text isEqualToString:@"0"]) {
//        NV.hidden = YES;
//    }else NV.hidden = NO;
//    [btn addSubview:NV];
    
    
    btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(0, 50, 120, 50);
    [btn2 setTitle:@"已回复" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"messageleft1"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(touchLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1;
    [leftView addSubview:btn2];
    [self.view addSubview:leftView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(120, 0, 200, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)touchLeftBtn: (UIButton*)button{
    NSLog(@"tag==%d",button.tag);
    fromTag=button.tag;
    if(button.tag==0){
        [btn setBackgroundImage:[UIImage imageNamed:@"messageleft2"] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"messageleft1"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:19.0/255 green:87.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        arr=_messages;
        [_tableView reloadData];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"messageleft1"] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"messageleft2"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithRed:19.0/255 green:87.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
        arr=_oldMessages;
        [_tableView reloadData];
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        
    }
    cell.imageView.image = [UIImage imageNamed:@"blueBackGround"];
    cell.textLabel.text = [arr[indexPath.row] objectForKey:@"UserName"];
    cell.textLabel.textColor = [UIColor colorWithRed:19.0/255 green:87.0/255 blue:169.0/255 alpha:1];
    cell.detailTextLabel.text= [arr[indexPath.row] objectForKey:@"PTime"];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstViewController *first = [FirstViewController new];
    first.userName= _userName;
    first.userid = [arr[indexPath.row] objectForKey:@"UserID"];
    first.type_id=@"2";
    first.toTag=fromTag;
    [self.navigationController pushViewController:first animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:@"numberMessage" object:nil];
    [timer invalidate];
    [newsNumber invalidate];
}
-(void)dealloc{
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"numberMessage" object:nil];
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
