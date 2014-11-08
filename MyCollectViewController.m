//
//  MyCollectViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-13.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MyCollectDetailViewController.h"
#import "GDataXMLNode.h"
#import "json.h"
@interface MyCollectViewController ()

@end

@implementation MyCollectViewController
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    hideTabbar
    self.title = @"我的收藏";
    numberArr = [NSArray array];
    images=[NSArray arrayWithObjects:@"homeLine1.png",@"homeLine2.png",@"homeLine3.png",@"homeLine4.png",@"homeLine5.png",@"homeLine6.png",@"homeLine7.png",@"homeLine8.png", nil];
    titles=[NSArray arrayWithObjects:@"线路",@"景点",@"住宿",@"美食",@"购物",@"娱乐",@"导游",@"租车", nil];
    dataArr = [NSMutableArray array];
    myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    NSMutableString *urlStr = RussiaUrl4;
    [urlStr appendString:@"GetTypeListCount"];
    NSString *argStr = [NSString stringWithFormat:@"cityid=2&userid=%@",GET_USER_DEFAUT(QUSE_ID)];
    postRequestYiBu(argStr, urlStr)
    
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
postRequestAgency(datas);
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   // dicResultYiBu(datas, result, dic)
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:datas options:0 error:nil];
    GDataXMLElement *e = [document rootElement];
    if ([[e stringValue] componentsSeparatedByString:@","].count >1) {
        numberArr=[[e stringValue] componentsSeparatedByString:@","];
        [myTableView reloadData];
    }
    
    NSLog(@"%@",numberArr);
    NSLog(@" e  %@",[e stringValue]);
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else return .5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    UIImageView*link2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 10, 21, 21)];
    link2.image=[UIImage imageNamed:@"cellJianTou.png"];
    [cell addSubview:link2];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 39.5, 310, .5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [cell addSubview:line];
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 25, 25)];
    [cell.contentView addSubview:iv];
    UILabel *tittle = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 50, 20)];
    tittle.font = [UIFont systemFontOfSize:15.5];
    [cell.contentView addSubview:tittle];
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(270, 10, 15, 17)];

    detailLab.text = [NSString stringWithFormat:@"(%@)",numberArr.count>1?[numberArr objectAtIndex:indexPath.row]:@"0"];
    
   
    detailLab.textColor = [UIColor lightGrayColor];
    detailLab.font = [UIFont systemFontOfSize:11];
    [cell.contentView addSubview:detailLab];
    if (indexPath.section==0) {
        iv.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
        tittle.text = [titles objectAtIndex:indexPath.row];
        
    }else {
        iv.image = [UIImage imageNamed:@"travel"];
        tittle.text = @"游记";
        
        detailLab.text = [NSString stringWithFormat:@"(%@)",numberArr.count>1?[numberArr objectAtIndex:8]:@"0"];
        
       
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    NSString *dicStr = [[NSBundle mainBundle]pathForResource:@"collect List" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicStr];
    MyCollectDetailViewController *mcdv = [MyCollectDetailViewController new];
    if (indexPath.section==0)  mcdv.title = [titles objectAtIndex:indexPath.row];
    else mcdv.title = @"游记";
    
   // 1是游记，2是线路，3是酒店，4是门票，5是餐厅，6是购物，7是景点，8是导游/翻译或租车，9是代理商租车
    
//    NSDictionary*navName= [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"navName" ofType:@"plist"]];
//
    if (indexPath.section==0) mcdv.typeID = [dic objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    else mcdv.typeID = [dic objectForKey:@"8"];
    NSLog(@"%@",numberArr);
    if (numberArr.count>1) {
        if ([mcdv.typeID intValue]!=1) {
          mcdv.count = [numberArr[indexPath.row] intValue]==0?1000:[numberArr[indexPath.row] intValue];
        }else mcdv.count = [numberArr[8] intValue]==0?1000:[numberArr[indexPath.row] intValue];
        
    }else mcdv.count = 1000;
    [self.navigationController pushViewController:mcdv animated:YES];

   }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
