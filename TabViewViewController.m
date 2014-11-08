//
//  TabViewViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TabViewViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
@interface TabViewViewController ()

@end

@implementation TabViewViewController

-(void)viewWillAppear:(BOOL)animated
{


    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
    

}
NetChange(noNetButton)
GO_NET
- (void)viewDidLoad
{
    [super viewDidLoad];
     hideTabbar

    
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-4)*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    [navActivity startAnimating];

    
    top=NO;
    noTop=NO;
    dataArray=[NSMutableArray new];
    topArray=[NSMutableArray new];
    picArray=[NSMutableArray new];
    searchPicArray=[NSMutableArray new];
  
    isDisplay=NO;
    index=0;
    topNum=0;
    if ([self.pageName isEqualToString:@"资讯列表"])
    {
        picPath=@"news";
    }
    else
    {
        picPath=@"travel";

    
    }
    [self.navigationItem setNewTitle:self.pageName];
    if ([self.tag isEqualToString:@"资讯"])
    {
        {
            NSString*cityid=[NSString stringWithFormat:@"%d",2];
            
            NSString*canshu2=[NSString stringWithFormat:@"cityid=%@",cityid];
            NSMutableString*urlDomain2=RussiaUrl2
            NSString *urlMethod2=@"getNewsTop";
            [urlDomain2 appendString:urlMethod2];
            
            postRequestYiBu(canshu2, urlDomain2)
        }
        NSString*pageindex=[NSString stringWithFormat:@"%d",index];
        NSString*cityid=[NSString stringWithFormat:@"%d",2];
        NSString*canshu=[NSString stringWithFormat:@"cityid=%@&title=%@&pagesize=%d&pageindex=%@",cityid,@"",LoadCount,pageindex];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getNewsList";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(canshu, urlDomain)
    }
    if ([self.tag isEqualToString:@"游记"])
    {
       
        
        
        
        if (self.collectID==0)
        {
            {
                NSString*cityid=[NSString stringWithFormat:@"%d",2];
                
                NSString*canshu2=[NSString stringWithFormat:@"cityid=%@",cityid];
                NSMutableString*urlDomain2=RussiaUrl2
                NSString *urlMethod2=@"getTravelTop";
                [urlDomain2 appendString:urlMethod2];
                
                postRequestYiBu(canshu2, urlDomain2)
            }
            
            NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&pagesize=%d&pageindex=%d",2,@"",LoadCount,0];
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getTravelList";
            [urlDomain appendString:urlMethod];
            postRequestYiBu(canshu, urlDomain)
            
        }
        else
        {
            NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
            NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
            
            NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectID],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",0],@"pageindex", nil];
            
            NSMutableString*str=RussiaUrl4
            [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:_dic andDelegate:self];
            
            
            
            
        }
        

        
        
    }
    
    
    
    
    remindAlert=[[UIAlertView alloc]initWithTitle:@"正在加载..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    act.frame=CGRectMake(120, 48, 37, 37);
    [remindAlert addSubview:act];


    
   _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-49-20) style:UITableViewStylePlain];
    _tabView.delegate=self;
    _tabView.dataSource=self;
//    _tabView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    _tabView.separatorColor=[UIColor clearColor];
    _tabView.backgroundColor=GroupColor;
//    _tabView.separatorInset=UIEdgeInsetsMake(10, 0, 10, 0);
    [self.view addSubview:_tabView];
    noNetButton=NoNetButton(noNetButton);
      Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];if ([rea2  currentReachabilityStatus]==NotReachable){noNetButton.hidden=NO;}else{noNetButton.hidden=YES;}
    [self createTableFooter:@"上拉显示更多"];

   
    refresh=[[UIRefreshControl alloc] init];
    refresh.tintColor=[UIColor clearColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@""];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_tabView addSubview:refresh];

   
       //        NSString *urlStr=[NSString
    
  

    UIButton *backbutton2 = [[UIButton alloc]init] ;
    
    float height=20;
    backbutton2.frame=CGRectMake(0, (44-height)/2, height, height) ;
    
    backbutton2.titleLabel.font=[UIFont systemFontOfSize:14];
    [backbutton2 addTarget:self action:@selector(seach) forControlEvents:UIControlEventTouchUpInside];
    [backbutton2 setImage:[UIImage imageNamed:@"hotel_search.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:backbutton2] ;
    if (self.collectID==0)
    {
        self.navigationItem.rightBarButtonItem =backItem2;
    }
 

    
   [self creatSearchBar];
    
    if (_count==1000) {
        UIView *bv = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 120)];
        //bv.backgroundColor = [UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1];
        [self.view addSubview:bv];
        
        UIImageView *star = [[UIImageView alloc]initWithFrame:CGRectMake(125, 0, 71, 71)];
        star.image = [UIImage imageNamed:@"star"];
        [bv addSubview:star];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 320, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text =[NSString stringWithFormat:@"您还没有收藏过%@",self.title];
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.textColor = [UIColor lightGrayColor];
        [bv addSubview:lab];
    }
	// Do any additional setup after loading the view.
}
-(void)seach
{
    
    searchDisplayC.searchResultsDataSource=self;
    searchDisplayC.searchResultsDelegate=self;
    self.navigationController.navigationBar.hidden=YES;
    self.navigationItem.hidesBackButton=YES;
    [self.view addSubview:searchBar];
    [searchBar becomeFirstResponder];
    
    
}

-(void)creatSearchBar
{
    
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    searchBar.tintColor=[UIColor brownColor];
    searchBar.placeholder=@"搜索";
    searchDisplayC=[[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayC.searchResultsTableView.backgroundColor=GroupColor;    searchDisplayC.searchResultsTableView.separatorColor=[UIColor clearColor];
    
    searchDisplayC.delegate=self;
    
    
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
    [searchBar resignFirstResponder];
    [searchBar removeFromSuperview];
    
    
}

-(void)refreshData
{
      [navActivity startAnimating];

    if ([self.tag isEqualToString:@"资讯"])
    {
        {
            NSString*cityid=[NSString stringWithFormat:@"%d",2];
            
            NSString*canshu2=[NSString stringWithFormat:@"cityid=%@",cityid];
            NSMutableString*urlDomain2=RussiaUrl2
            NSString *urlMethod2=@"getNewsTop";
            [urlDomain2 appendString:urlMethod2];
            
            postRequestYiBu(canshu2, urlDomain2)
        }
       
        NSString*pageindex=[NSString stringWithFormat:@"%d",0];
        NSString*cityid=[NSString stringWithFormat:@"%d",2];
        NSString*canshu=[NSString stringWithFormat:@"cityid=%@&title=%@&pagesize=%d&pageindex=%@",cityid,@"",LoadCount,pageindex];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getNewsList";
        [urlDomain appendString:urlMethod];
        //        NSString *urlStr=[NSString stringWithFormat:@"%@Service1.asmx/UserLogin",RussiaUrl];
        postRequestYiBu(canshu, urlDomain)
    }
    if ([self.tag isEqualToString:@"游记"])
    {
       
        
        
        if (self.collectID==0)
        {
            {
                NSString*cityid=[NSString stringWithFormat:@"%d",2];
                
                NSString*canshu2=[NSString stringWithFormat:@"cityid=%@",cityid];
                NSMutableString*urlDomain2=RussiaUrl2
                NSString *urlMethod2=@"getTravelTop";
                [urlDomain2 appendString:urlMethod2];
                
                postRequestYiBu(canshu2, urlDomain2)
            }
            
            NSString*cityid=[NSString stringWithFormat:@"%d",2];
            NSString*canshu=[NSString stringWithFormat:@"cityid=%@&title=%@&pagesize=%d&pageindex=%d",cityid,@"",LoadCount,0];
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getTravelList";
            [urlDomain appendString:urlMethod];
            //        NSString *urlStr=[NSString stringWithFormat:@"%@Service1.asmx/UserLogin",RussiaUrl];
            postRequestYiBu(canshu, urlDomain)
            
            
        }
        else
        {
            NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
            NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
            
            NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectID],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",0],@"pageindex", nil];
            
            NSMutableString*str=RussiaUrl4
            [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:_dic andDelegate:self];
            
            
            
            
        }
        

        
    }



}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset= scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x/bounds.size.width];
    
}
backButton
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
//    tabView.tableHeaderView
    // Dispose of any resources that can be recreated.
}
postRequestAgencyAndRefeshAndAlert(datas, refresh, remindAlert ,navActivity)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [remindAlert dismissWithClickedButtonIndex:0 animated:YES];//取消
    [navActivity stopAnimating];
    dicResultYiBu(datas, result, dic)
    NSLog(@"result=%@",result);
    [[LineViewController new]endRefresh:refresh];
    NSArray*array=[dic valueForKey:@"ds"];
    if (isDisplay==YES)
    {
          [dataForSearchArray removeAllObjects];
        if ([[array lastObject] valueForKey:@"Title"])
        {
            dataForSearchArray=[NSMutableArray arrayWithArray:array];
            [searchPicArray removeAllObjects];
            for (int i=0; i<dataForSearchArray.count; i++)
            {
                
                NSMutableString*urlStr=PicUrl;
                NSString*str=[NSString stringWithFormat:@"%@/%@",picPath,[[dataForSearchArray objectAtIndex:i] valueForKey:@"Pic"]] ;
                [urlStr appendString:str];
                int a=[[[dataForSearchArray objectAtIndex:i] valueForKey:@"ID"]integerValue];
                
                Data*data=[Data new];
                [self downPic:urlStr andData:data andTag:a andPath:picPath andTableView:searchDisplayC.searchResultsTableView];
                if ([self.pageName isEqualToString:@"游记列表"])
                {
                      NSMutableString*urlStr=PicUrl;
                    NSString*str2=[NSString stringWithFormat:@"Personal/%@",[[dataForSearchArray objectAtIndex:i] valueForKey:@"ImgTouX"]] ;
                    [urlStr appendString:str2];
                    NSString*path=[NSString stringWithFormat:@"%@%@",picPath,@"user"];
                    [self downPicHead:urlStr andData:data andTag:a andPath:path andTableView:searchDisplayC.searchResultsTableView];
                    
                }
                [searchPicArray addObject:data];
                
            }
            

        }

          [searchDisplayC.searchResultsTableView reloadData];
            return;
    }
    
    
    if ([[array lastObject] valueForKey:@"Title"]==nil)
       {
       
        [self loadDataEnd:@""];
       }
    
    if ([[array lastObject] valueForKey:@"Title"])
    {
      
       
          [self loadDataEnd:@"上拉显示更多"];
        if ([[[array lastObject]valueForKey:@"IsTop"]integerValue]==1)
        {
            
            [topArray removeAllObjects];

            top=YES;
            topArray=[NSMutableArray arrayWithArray:array];
            _tabView.tableHeaderView=[self creatTabHead];
          

            for (int i=0; i<topArray.count; i++)
            {
                
                NSMutableString*urlStr=PicUrl;
                NSString*str=[NSString stringWithFormat:@"%@/big/%@",picPath,[[topArray objectAtIndex:i] valueForKey:@"Pic"]] ;
                [urlStr appendString:str];
                NSString*zhiding=[NSString stringWithFormat:@"%@%@",picPath,@"zhiding"];
                [self downPic:urlStr andTag:i andPath:zhiding];
                
            }

            
        }

        if ([[[[array lastObject]valueForKey:@"IsTop"]stringValue]isEqualToString:@"0" ]||self.collectID!=0)
        {
            [dataArray removeAllObjects];
            noTop=YES;
            topNum++;
            dataArray=[NSMutableArray arrayWithArray:array];
            [picArray removeAllObjects];
            for (int i=0; i<dataArray.count; i++)
            {
                NSMutableString*strUrl=PicUrl;
                NSString*str=[NSString stringWithFormat:@"%@/%@",picPath,[[dataArray objectAtIndex:i] valueForKey:@"Pic"]] ;
                [strUrl appendString:str];
                int a=[[[dataArray objectAtIndex:i] valueForKey:@"ID"]integerValue];

                 Data*data=[Data new];
                [self downPic:strUrl andData:data andTag:a andPath:picPath andTableView:_tabView];
                if ([self.pageName isEqualToString:@"游记列表"])
                {
                      NSMutableString*strUrl=PicUrl;
                      NSString*str2=[NSString stringWithFormat:@"Personal/%@",[[dataArray objectAtIndex:i] valueForKey:@"ImgTouX"]] ;
                     [strUrl appendString:str2];
                    NSString*path=[NSString stringWithFormat:@"%@%@",picPath,@"user"];
                      [self downPicHead:strUrl andData:data andTag:a andPath:path andTableView:_tabView];
                    
                }

                
                
                [picArray addObject:data];

            }
           
        }
        
        
        if ((top==YES&&noTop==YES))
        {
                _tabView.tableHeaderView=tabview;
              [_tabView reloadData];
            NSLog(@"刷新刷新");
            
        }
        if (topNum==2||self.collectID!=0)
        {
           
              [_tabView reloadData];
        }
      
 
}

  
}
-(void)downPic:(NSString*)url andTag:(int)_tag1 andPath:(NSString*)path
{
    
    dispatch_queue_t queue0=dispatch_queue_create("download0", NULL);
    dispatch_async(queue0, ^{
        //下载图片的代码
        NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        
        UIImage*image=[[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           
                           
                           UIButton*buuton=(UIButton*)[self.view viewWithTag:100+_tag1];
                           [buuton setImage:image forState:UIControlStateNormal];
                           NSString*str=[NSString stringWithFormat:@"%@%d",path,_tag1];
                           if (![path isEqualToString:@""])
                           {
                               WriteToFile(data, str);
                               
                           }
                           
                       });
    });
    
    
    
    
    
    
}
-(void)downPic:(NSString*)url andData:(Data*)_data  andTag:(int)_tag1  andPath:(NSString*)path andTableView:(UITableView*)TableView
{
    
    NSLog(@"url======%@",url);
    dispatch_queue_t queue0=dispatch_queue_create("download0", NULL);
    dispatch_async(queue0, ^{
        //下载图片的代码
        NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        
        _data.image=[[UIImage alloc] initWithData:data];
        
        
        
        //        NSDictionary*dic2;
        
        
        //        UITableViewCell*cell=[_tabView ]
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           
                           for (NSIndexPath *indexPath in TableView.indexPathsForVisibleRows)
                           {
                               
                               Data*tempData;
                               if (TableView==_tabView)
                               {
                                   tempData=[picArray objectAtIndex:indexPath.row];
                               }
                               else
                               {
                                   tempData=[searchPicArray objectAtIndex:indexPath.row];
                                   
                               }
                               
                               if (tempData==_data)
                               {
                                   
                                   [TableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                               }
                               
                           }
                           NSString*str=[NSString stringWithFormat:@"%@%d",path,_tag1];
                           if (![path isEqualToString:@""])
                           {
                               WriteToFile(data, str);
                           }
                           
                           
                       });
    });
}
-(void)downPicHead:(NSString*)url andData:(Data*)_data  andTag:(int)_tag1  andPath:(NSString*)path andTableView:(UITableView*)TableView
{
    
    NSLog(@"url======%@",url);
    dispatch_queue_t queue0=dispatch_queue_create("download0", NULL);
    dispatch_async(queue0, ^{
        //下载图片的代码
        NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        if (data) {
            _data.headImage=[[UIImage alloc] initWithData:data];
        }
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           for (NSIndexPath *indexPath in TableView.indexPathsForVisibleRows)
                           {
                               
                               Data*tempData;
                               if (TableView==_tabView)
                               {
                                   tempData=[picArray objectAtIndex:indexPath.row];
                               }
                               else
                               {
                                   tempData=[searchPicArray objectAtIndex:indexPath.row];
                                   
                               }
                               
                               if (tempData==_data)
                               {
                                   
                                   [TableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                               }
                               
                           }
                           NSString*str=[NSString stringWithFormat:@"%@%d",path,_tag1];
                           if (![path isEqualToString:@""])
                           {
                               WriteToFile(data, str);
                           }
                           
                           
            });
        });
  
}



-(UIView*)creatTabHead
{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    _scrollView.showsHorizontalScrollIndicator=NO;
    tabview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    [tabview addSubview:_scrollView];
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((320-200)/2+120,  _scrollView.frame.origin.y+_scrollView.frame.size.height-20, 200, 20)];
    _scrollView.contentSize=CGSizeMake(320*topArray.count, 180);
    pageControl.numberOfPages=topArray.count;
    pageControl.currentPage=0;
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _scrollView.delegate=self;
    for (int i=0; i<topArray.count; i++)
    {
        
        UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
        view.frame=CGRectMake(0+320*i, 0, 320, 180);
        [view setImage:[UIImage imageNamed:@"defaultBig.gif"] forState:UIControlStateNormal];
        view.tag=100+i;
        RTLabel*lable=[[RTLabel alloc]initWithFrame:CGRectMake(5, view.frame.size.height-20, 200, 20)];
        lable.text=[[topArray objectAtIndex:i]valueForKey:@"Title"];
        lable.font=[UIFont systemFontOfSize:15];
        lable.textColor=[UIColor whiteColor];
        [view addSubview:lable];
        [view addTarget:self action:@selector(touches:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:view];
        
    }
    [tabview addSubview:pageControl];
    return tabview;
}
-(void)touches:(UIButton*)sender
{
    
    if ([self.tag isEqualToString:@"资讯"])
    {

    InfomDetailViewController*inform=[InfomDetailViewController new];
    inform.ID=[[[topArray objectAtIndex:sender.tag-100] valueForKey:@"ID"] integerValue];
    [self.navigationController pushViewController:inform animated:NO];
    }
    if ([self.tag isEqualToString:@"游记"])
    {
        TravelViewController*inform=[TravelViewController new];
        inform.ID=[[[topArray objectAtIndex:sender.tag-100] valueForKey:@"ID"] integerValue];
        [self.navigationController pushViewController:inform animated:NO];

    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{


    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"cell";
    NSMutableArray*_array;
    NSMutableArray*_picArray;

    if ([self.tag isEqualToString:@"资讯"])
    {
        CustomCell2 *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if (cell==nil)
        {
            cell=[[CustomCell2 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        if (tableView==_tabView)
        {
            _array=[NSMutableArray arrayWithArray:dataArray];
            _picArray=[NSMutableArray arrayWithArray:picArray];
        }
        else
        {
        
            _array=[NSMutableArray arrayWithArray:dataForSearchArray];
            _picArray=[NSMutableArray arrayWithArray:searchPicArray];

        }
        if (_picArray.count>0)
        {
            Data*data=[_picArray objectAtIndex:indexPath.row];
            cell._imageView.image=data?data.image:BACK_IMAGE;
        }
     
        cell.lableHead.text=[[_array objectAtIndex:indexPath.row]valueForKey:@"Title"];
        cell.lableDetail.text=[[_array objectAtIndex:indexPath.row]valueForKey:@"Summary"];
        cell.lableDetail.frame=CGRectMake(8+100+5, 30+8, 310-100-15, 30);
        NSString*_str1=[[_array objectAtIndex:indexPath.row]valueForKey:@"PTime"];
        _str1=[_str1 stringByReplacingOccurrencesOfRegex:@"/" withString:@"."];
        cell.data.text=_str1;
        
        UIImageView*jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 20, 20)];
        jiantou.image=[UIImage imageNamed:@"cellJianTou.png"];
        
        return cell;
    }
    if ([self.tag isEqualToString:@"游记"])
    {
        
        CustomCell3 *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if (cell==nil)
        {
            cell=[[CustomCell3 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        
        if (tableView==_tabView)
        {
            _array=[NSMutableArray arrayWithArray:dataArray];
            _picArray=[NSMutableArray arrayWithArray:picArray];
        }
        else
        {
            _array=[NSMutableArray arrayWithArray:dataForSearchArray];
            _picArray=[NSMutableArray arrayWithArray:searchPicArray];
        }
        cell._imageView.image=[UIImage imageNamed:@"homePic_1.jpg"];
        if (_picArray.count>0)
        {
            
            Data *data=[_picArray objectAtIndex:indexPath.row];
            cell._imageView.image=data.image?data.image:BACK_IMAGE;
            cell.headImage.image=data.headImage?data.headImage:BACK_IMAGE;
           // cell.headImage.image=data.headImage;
            
        }
        
        cell.lableHead.text=[[_array objectAtIndex:indexPath.row]valueForKey:@"Title"];
        CGSize size=[cell.lableHead sizeThatFits:CGSizeMake(195, 0)];
        cell.lableHead.frame=CGRectMake(115,15, 195, size.height);
        cell.useName.text=[[_array objectAtIndex:indexPath.row]valueForKey:@"UserName"];
       NSString*_str1=[[_array objectAtIndex:indexPath.row]valueForKey:@"PTime"];
        _str1=[_str1 stringByReplacingOccurrencesOfString:@"/" withString:@"."];
        cell.data.text=_str1;
        
        return cell;
    }

  
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==searchDisplayC.searchResultsTableView)
    {
        
        if (isDisplay==NO)
        {
            NSLog(@"!!!!!");
            NSString*canshu;
            NSString *urlMethod;
            if ([self.pageName isEqualToString:@"资讯列表"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&pagesize=%d&pageindex=%d",2,searchBar.text,LoadCount,0];
                urlMethod=@"getNewsList";
            }
            if ([self.pageName isEqualToString:@"游记列表"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&pagesize=%d&pageindex=%d",2,searchBar.text,LoadCount,0];
                urlMethod=@"getTravelList";
            }

            
            NSMutableString*urlDomain=RussiaUrl2
            
            [urlDomain appendString:urlMethod];
            
            postRequestYiBu(canshu, urlDomain)
            
            
            isDisplay=YES;
            
            
        }
        
        
        return dataForSearchArray.count;
        
        
        
    }


    return [dataArray count];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    isDisplay=NO;
    
    NSLog(@"%s",__func__);
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CustomCell3*cell=(CustomCell3*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableArray*_array;
    if (tableView==_tabView)
    {
         _array =[NSMutableArray arrayWithArray:dataArray];
    }
    else
    {
        _array =[NSMutableArray arrayWithArray:dataForSearchArray];
    
    }
  
    
    if ([self.tag isEqualToString:@"资讯"])
    {
        InfomDetailViewController*inform=[InfomDetailViewController new];
        inform.ID=[[[_array objectAtIndex:indexPath.row]valueForKey:@"ID"]intValue];
        [self.navigationController pushViewController:inform animated:NO];
    }
    
    if ([self.tag isEqualToString:@"游记"])
    {
        TravelViewController*inform=[TravelViewController new];
        inform.ID=[[[_array objectAtIndex:indexPath.row]valueForKey:@"ID"]intValue];
        //inform.userImage=cell.headImage.image;
        [self.navigationController pushViewController:inform animated:NO];
    }


}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // 下拉到最底部时显示更多数据
    
    if(!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height+10)))
        
    {
        
        [self loadDataBegin];
        
    }
    
}


// 开始加载数据

- (void) loadDataBegin

{
    
    if (_loadingMore == NO)
        
    {
        
        _loadingMore = YES;
      
        UILabel*view=(UILabel*)[self.view viewWithTag:2];
        view.text=@"";
        UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150.0f, 10.0f, 20.0f, 20.0f)];
        
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        [tableFooterActivityIndicator startAnimating];
        
        [_tabView.tableFooterView addSubview:tableFooterActivityIndicator];
        [self loadDataing];
        
    }
    
}


// 加载数据中

- (void) loadDataing

{
    [navActivity stopAnimating];
    index++;
    if ([self.tag isEqualToString:@"资讯"])
    {
       
        NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&pagesize=%d&pageindex=%d",2,@"",LoadCount,index];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getNewsList";
        [urlDomain appendString:urlMethod];
        //        NSString *urlStr=[NSString stringWithFormat:@"%@Service1.asmx/UserLogin",RussiaUrl];
        postRequestYiBu(canshu, urlDomain)
    }
    if ([self.tag isEqualToString:@"游记"])
    {
      
      
        
        
        
        if (self.collectID==0)
        {
            NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&pagesize=%d&pageindex=%d",2,@"",LoadCount,index];
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getTravelList";
            [urlDomain appendString:urlMethod];
            //        NSString *urlStr=[NSString stringWithFormat:@"%@Service1.asmx/UserLogin",RussiaUrl];
            postRequestYiBu(canshu, urlDomain)
            
            
        }
        else
        {
            NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
            NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
            
            NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectID],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",0],@"pageindex", nil];
            
            NSMutableString*str=RussiaUrl4
            [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:_dic andDelegate:self];
    
        }
        
        
        
    }
}


// 加载数据完毕

- (void) loadDataEnd:(NSString*)text

{
    
    _loadingMore = NO;
    
    [self createTableFooter:text];
    
}


// 创建表格底部

- (void) createTableFooter:(NSString*)text

{
    
    _tabView.tableFooterView = nil;
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tabView.bounds.size.width, 40.0f)];
   
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 40.0f)];
     loadMoreText.tag=2;
    [loadMoreText setCenter:tableFooterView.center];
    
    [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    loadMoreText.textAlignment=NSTextAlignmentCenter;
//    [loadMoreText setText:text];
    
    [tableFooterView addSubview:loadMoreText];
    
    
    
    _tabView.tableFooterView = tableFooterView;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];
    
}
@end
