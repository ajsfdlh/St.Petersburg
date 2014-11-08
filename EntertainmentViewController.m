//
//  EntertainmentViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "EntertainmentViewController.h"
#import "entainmentCustomCell.h"
#import "EntertainListViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
@interface EntertainmentViewController ()

@end

@implementation EntertainmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
postRequestAgency(datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    
    [[LineViewController new] endRefresh:refresh];
    dicResultYiBu(datas, result, dic)
    
    [ dataArray removeAllObjects];
    dataArray=[dic valueForKey:@"ds"];
    [_tabView reloadData];
    WriteToFile(dataArray, urlMethod);

}
- (void)viewDidLoad
{
    [self setTitle:@"圣彼得堡娱乐"];
    hideTabbar
    [super viewDidLoad];
    dataArray=[NSMutableArray new];
    NSString*canshu=[NSString stringWithFormat:@"cityid=%d",2];
    NSMutableString*urlDomain=RussiaUrl3;
    urlMethod=@"getTicketTypeList";
    [urlDomain appendString:urlMethod];
    
    
    
    if (FileExists(urlMethod))
    {
        dataArray=[NSMutableArray arrayWithContentsOfFile:PathOfFile(urlMethod)];
    }
    else
    {
        postRequestYiBu(canshu, urlDomain)
        
    }
    

  
    
    head=[NSArray arrayWithObjects:@"歌舞剧",@"游船",@"大马戏",@"其他", nil];
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-49-20) style:UITableViewStylePlain];
    _tabView.delegate=self;
    _tabView.dataSource=self;
    //    _tabView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    _tabView.separatorColor=[UIColor clearColor];
    _tabView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    //    _tabView.separatorInset=UIEdgeInsetsMake(10, 0, 10, 0);
    [self.view addSubview:_tabView];
    refresh=[[UIRefreshControl alloc] init];
    refresh.tintColor=[UIColor darkGrayColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@"松开刷新"];
    
    [refresh addTarget:self action:@selector(refreshing) forControlEvents:UIControlEventValueChanged];
    [_tabView addSubview:refresh];


	// Do any additional setup after loading the view.
}
-(void)refreshing
{

    NSString*canshu=[NSString stringWithFormat:@"cityid=%d",2];
    NSMutableString*urlDomain=RussiaUrl3;
    urlMethod=@"getTicketTypeList";
    [urlDomain appendString:urlMethod];
    postRequestYiBu(canshu, urlDomain)


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString*str=@"cell";
    entainmentCustomCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[entainmentCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.backGround.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell._imageView.image=[UIImage imageNamed:@"homePic_1.jpg"];
    cell.head.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"TicketName"];
    cell.title.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"Content"];
    CGSize size=[cell.title sizeThatFits:CGSizeMake(130, 0)];
    
     cell.title.frame=CGRectMake(cell._imageView.frame.origin.x+cell._imageView.frame.size.width+5, cell.head.frame.origin.y+cell.head.frame.size.height-5,130 , size.height);
    
    
    cell._imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"entainment%d.jpg",indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 122;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    EntertainListViewController*list=[EntertainListViewController new];
    list.navName=@"歌舞剧";
    list.tag=1;
    list.typeId=2;
    list.introduce=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"Content"];
    list.ticketclass=[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"ID"] intValue];
    [self.navigationController pushViewController:list animated:NO];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
