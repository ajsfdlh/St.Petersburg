//
//  MyTravelingViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-9.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyTravelingViewController.h"
#import "MyTravelingTableViewCell.h"
#import "GDataXMLNode.h"
#import "JSON.h"
#import "MyTravelingDetailViewController.h"
#import "WriteMyTravelingViewController.h"

@interface MyTravelingViewController ()

@end

@implementation MyTravelingViewController

backButton
- (void)viewWillAppear:(BOOL)animated{
    
    
    [_myTableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated{

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_dataArr];
    if (data.length>255) {
        NSLog(@"length %d",data.length);
        [data writeToFile:PathOfFile(@"MyTravelDatas") options:NSDataWritingAtomic error:nil];
    }
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
   
    self.title = @"我的游记";
    hideTabbar;
    datas = [NSMutableData data];
    _dataArr= [NSMutableArray array];
    //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tittleArr = @[@"评论(99)",@"编辑",@"删除"];
    imageNameArr = @[@"travel_say.png",@"travel_pen.png",@"travel_trash.png"];
    
    float height=35;UIButton *backbutton = [[UIButton alloc]init];backbutton.frame=CGRectMake(0, (44-height)/2, 40, height);[backbutton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(-5, 10, 16, 16)];imageView.image=[UIImage imageNamed:@"sendtravel"];[backbutton addSubview:imageView];UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(17, 0, 40, 35)]; lable.font=[UIFont systemFontOfSize:15];lable.textColor=[UIColor whiteColor];lable.text=@"发布";[backbutton addSubview:lable];UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton];self.navigationItem.rightBarButtonItem =backItem;
    
    
    _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_myTableView];
    
    refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新..."];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_myTableView addSubview:refresh];

    foolerView = [[UIView alloc]init];
    foolerView.frame = CGRectMake(0, 0, 320, 90);
    foolerLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 320, 30)];
    foolerLab.textAlignment =NSTextAlignmentCenter;
    foolerLab.text = @"上拉刷新...";
    [foolerView addSubview:foolerLab];
    
    foolerAiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    foolerAiv.frame = CGRectMake(145, 10, 30, 30);
   // [foolerAiv startAnimating];
    [foolerView addSubview:foolerAiv];
    
    
    if ([[NSData dataWithContentsOfFile:PathOfFile(@"MyTravelDatas") ] length]==0) {
        aiv=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        aiv.frame=CGRectMake(65+(8-4)*10, (44- aiv.frame.size.height)/2, aiv.frame.size.width,  aiv.frame.size.height);
        [aiv startAnimating];
        [self.navigationController.navigationBar addSubview:aiv];

        NSMutableString *urlStr = RussiaUrl4;
        [urlStr appendString:@"getTravelList"];
        NSString *aruStr = [NSString stringWithFormat:@"cityid=2&userid=%@&pagesize=5&pageindex=%d",GET_USER_DEFAUT(QUSE_ID),0];
        postRequestYiBu(aruStr, urlStr)
    }else {
        NSData *data=[NSData dataWithContentsOfFile:PathOfFile(@"MyTravelDatas") ];
        _dataArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (_dataArr.count>4) {
            
            _myTableView.tableFooterView = foolerView;
            // NSLog(@"rect  %f",rect.origin.y);
        }
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
static int a = 0 ;
- (void)send{
    [self.navigationController pushViewController:[WriteMyTravelingViewController new] animated:YES];
    
    
    
    /*
    NSMutableString *urlStr = RussiaUrl4;
    [urlStr appendString:@"getAddTravelInfo"];
    NSString *contentStr = @"啊发酵时间放假啊放假啊积分拉德斯基法律框架阿卡的房间卡电视就放假啊都是发生纠纷卡了手机发来看";
    NSString *tittle = [NSString stringWithFormat:@"++沙发%d",a++];
    NSString *argStr = [NSString stringWithFormat:@"userid=%@&username=%@&title=%@&pic=&content=%@&cityid=2",GET_USER_DEFAUT(QUSE_ID),GET_USER_DEFAUT(USER_NAME),tittle,contentStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        postRequestTongBu(argStr, urlStr, received)
       // dicResultTongbu(received, result, dic)
        dicResultTongbuNoDic(received, result)
        NSLog(@"send result %@",result);
        if ([result intValue]>0) {
            NSDictionary *dic2 = @{@"ID":result,@"Content":contentStr,@"Msgcount":@"0",@"Pic":@"",@"Title":tittle};
            [_dataArr addObject:dic2];

//            CityID = 2;
//            Content =
//            ID = 4;
//            IsTop = 1;
//            Msgcount = 1;
//            PTime = "2014/4/3 17:51:02";
//            Pic = "201404031751511941.jpg";
//            Row = 1;
//            Status = 1;
//            Title = "\U5723\U5f7c\U5f97\U5821\U5217\U74e6\U5927\U8857\U6e38";
//            UserID = 217;
//            UserName = aaaaaa;
//            Viewcount = 15;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_myTableView reloadData];
        });
    });
*/
    
}
postRequestAgency(datas)
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBu(datas, result, dic)
    if (result.length>11&&[dic objectForKey:@"ds"]) {
  
        //_dataArr=nil;
       _dataArr = [dic objectForKey:@"ds"];
       // NSLog(@"%@",_dataArr);
        
        //[NSThread sleepForTimeInterval:2];
        [aiv stopAnimating];
        
       // CGRect rect = [_myTableView rectForFooterInSection:0];
       if (_dataArr.count>4) {
            
            _myTableView.tableFooterView = foolerView;
           // NSLog(@"rect  %f",rect.origin.y);
        }
        [_myTableView reloadData];
    }
    if (_dataArr.count==0) {
        bv = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 120)];
        bv.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //[bv  setAlpha:.5];
        [self.view addSubview:bv];
        
        UIImageView *star = [[UIImageView alloc]initWithFrame:CGRectMake(130, 0, 71, 71)];
        star.image = [UIImage imageNamed:@"travel_book.png"];
        [bv addSubview:star];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 320, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text =[NSString stringWithFormat:@"您还没有发布过游记"];
        lab.font = [UIFont boldSystemFontOfSize:16.5];
        lab.textColor = [UIColor lightGrayColor];
        [bv addSubview:lab];
    }else [bv removeFromSuperview];
    [aiv stopAnimating];
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"targetContentOffset   %f",targetContentOffset->y);
    if (targetContentOffset->y==-82) [refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:@"加载中..."]];
    NSLog(@"contentOffset %f",scrollView.contentOffset.y);
}
- (void)refresh{
    
    [refresh beginRefreshing];
    
    [NSThread sleepForTimeInterval:.5];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"加载中");
        NSMutableString *urlStr = RussiaUrl4;
        [urlStr appendString:@"getTravelList"];
        NSString *aruStr = [NSString stringWithFormat:@"cityid=2&userid=%@&pagesize=5&pageindex=%d",GET_USER_DEFAUT(QUSE_ID),0];
        postRequestTongBu(aruStr, urlStr, received)
        dicResultTongbu(received, result, dic)
        if (result.length>11&&[dic objectForKey:@"ds"]) {
            _dataArr = [dic objectForKey:@"ds"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            footerTag=0;
            [refresh endRefreshing];
            [_myTableView reloadData];
            refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新..."];
            return ;
            
        });
    });
    NSLog(@" 上拉  result   footerTag  %d",footerTag);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     NSLog(@"%s",__func__);
    NSLog(@"contentSize.height %f  contentOffset.y %f  _myTableView.frame.size.height %f",scrollView.contentSize.height,scrollView.contentOffset.y,_myTableView.frame.size.height);
    if (_myTableView.tableFooterView&&scrollView.contentOffset.y>scrollView.contentSize.height-_myTableView.frame.size.height+20) {
        [foolerAiv startAnimating];
        foolerLab.text = @"加载中...";
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"加载中");
            NSMutableString *urlStr = RussiaUrl4;
            [urlStr appendString:@"getTravelList"];
            NSString *aruStr = [NSString stringWithFormat:@"cityid=2&userid=%@&pagesize=5&pageindex=%d",GET_USER_DEFAUT(QUSE_ID),++footerTag];
            postRequestTongBu(aruStr, urlStr, received)
            dicResultTongbu(received, result, dic)
            
           
            if (result.length>11&&[dic objectForKey:@"ds"]) {
                for (NSDictionary *dic2 in [dic objectForKey:@"ds"]) {
                    [_dataArr addObject:dic2];
                    //接上数据  加上缓存
                    //NSLog(@"%@",result);
//                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[dic objectForKey:@"ds"]];
//                    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    NSLog(@" _dataArr  %@",_dataArr);
                   // [datas appendData:data];
                }
                
            }else footerTag--;
            [NSThread sleepForTimeInterval:.5];
            dispatch_async(dispatch_get_main_queue(), ^{
                [foolerAiv stopAnimating];
                [_myTableView reloadData];
                foolerLab.text = @"上拉刷新...";
                
            });
        });
        // NSLog(@" 上拉  result   footerTag  %d",footerTag);
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    MyTravelingTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!myCell) {
        myCell = [[MyTravelingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    for (UIView *v in myCell.contentView.subviews) {
        [v removeFromSuperview];
    }
    if (_dataArr.count>0) {
        UIImageView*headIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 75)];
        headIV.backgroundColor = [UIColor grayColor];
        [myCell.contentView addSubview:headIV];
        
        UIActivityIndicatorView *headAiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
       // headAiv.frame = CGRectMake(0, 0, 30, 30);
        //headAiv.center=headIV.center;
        headAiv.frame = CGRectMake(35, 25, 30, 30);
        
        [headIV addSubview:headAiv];
        
        
        UILabel *headLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 0, 200, 50)];
        headLab.numberOfLines = 2;
        headLab.font = [UIFont boldSystemFontOfSize:14];
        headLab.text = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Title"];
        [myCell.contentView addSubview:headLab];
        
        NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(headLab.text)];
        
        
        if ([[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Pic"] length]>4) {
            NSLog(@"[[_dataArr objectAtIndex:indexPath.row] objectForKey:Pic]   %@",[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Pic"]);
            if (pathData.length==0) {
                [headAiv  startAnimating];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSString *urlStr = [NSString stringWithFormat:@"%@%@",PicUrlTravel,[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Pic"]];
                    NSURL *url = [NSURL URLWithString:urlStr];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                   // [NSThread sleepForTimeInterval:2];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (data) {
                            [data writeToFile:PathOfFile(headLab.text) atomically:YES];
                            headIV.image = [UIImage imageWithData:data];
                            [NSThread sleepForTimeInterval:1];
                            
                        }else headIV.image = [UIImage imageNamed:@"lack.jpg"];
                        
                        [headAiv stopAnimating];
                        
                    });
                });
            }else headIV.image = [UIImage imageWithData:pathData];
   
        }else  headIV.image = [UIImage imageNamed:@"lack.jpg"];
      
        
        
        
        UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 42, 200, 25)];
        dateLab.font = [UIFont systemFontOfSize:13];
        dateLab.textColor = [UIColor grayColor];
        dateLab.text =[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"PTime"];
        [myCell.contentView addSubview:dateLab];
        

        
        
        NSString *title = [NSString stringWithFormat:@"评论(%@)",[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Msgcount"]];
        for (int i = 0; i < 3; i++) {
            UIButton *say = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [say setTitle:i==0?title:[tittleArr objectAtIndex:i] forState:UIControlStateNormal];
            say.tag = i;
            [say addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
            say.titleLabel.font = [UIFont systemFontOfSize:13];
            [say setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            say.showsTouchWhenHighlighted=YES;
            say.titleLabel.textAlignment = NSTextAlignmentLeft;
            say.frame = i==0?CGRectMake(126, 65, 60, 25):CGRectMake(150+55*i, 65, 30, 25);
            [myCell.contentView addSubview:say];
            
            
            UIImageView *tittleIV=[[UIImageView alloc]init];
            tittleIV.frame =i==0?CGRectMake(115, 70, 15, 15):CGRectMake(135+55*i, 70, 15, 15);
            tittleIV.image = [UIImage imageNamed:[imageNameArr objectAtIndex:i]];
            tittleIV.backgroundColor = [UIColor blueColor];
            [myCell.contentView addSubview:tittleIV];
        }
    }
    return myCell;
}
- (void)btnTouch:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            NSLog(@"sender 点评  %d",btn.tag);
            break;
        case 1:
            NSLog(@"sender 编辑  %d",btn.tag);
            break;
        case 2:
            NSLog(@"sender 删除  %d",btn.tag);
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    MyTravelingDetailViewController *mtdv = [MyTravelingDetailViewController new];
    mtdv.htmlStr = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Content"];
    mtdv.title =[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"Title"];
    [self.navigationController pushViewController:mtdv animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
