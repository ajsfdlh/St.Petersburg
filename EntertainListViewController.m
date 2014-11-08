//
//  EntertainListViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "EntertainListViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "CustomSceneryCell.h"
#import "TaxiPersonageCell.h"
#import "GuideTableViewCell.h"
#import "SupplierTableViewCell.h"
#import "GuideDetailViewController.h"
#import "SupplierTableViewController.h"
#import "TaxiCompanyCell.h"
@interface EntertainListViewController ()

@end

@implementation EntertainListViewController

-(void)viewWillAppear:(BOOL)animated
{
    guideAndTransitionArr=[NSMutableArray new];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
}
backButton
NetChange(noNetButton)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tittles = @[@"中国留学生导游",@"专业俄籍导游",@"普通俄籍导游",@"专业中国导游",@"随行简单翻译",@"专业翻译",@"公务、商务翻译",@"专家翻译"];
    priceKey = @[@"CNUStudent",@"CNUSpasice",@"RUUPutong",@"RUUSpasice",@"SuiUFanyi",@"ZYUFanYi",@"GWUFanyi",@"ZJUFanYi"];
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-[self.navName length])*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    
    

//    searchPicArray=[NSMutableArray new];
//    [searchPicArray removeAllObjects];
    
    if ([self.navName isEqualToString:@"景点列表"])
    {
        picPath=@"view";
        picName=@"ViewPic";
        picID=@"ViewID";
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
        picPath=@"hotel";
        picName=@"HotelPic";
        picID=@"HotelID";
        
       
    }
    if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
        picPath=@"rest";
         picName=@"Pic";
        picID=@"RestID";
        
        
      
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        picPath=@"shop";
         picName=@"Pic";
        picID=@"ShopID";
        
      
    }
    if (self.tag==1)
    {
        picPath=@"ticket";
         picName=@"TicketCName";
        picID=@"TicketID";
        
        
     

    }
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
        picPath=@"guide";
        picName=@"Pic";
        picID=@"GuideID";
        
        
        
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
        picPath=@"guide";
        picName=@"Pic2";
        picID=@"GuideID";
        
    }



    
    
    
//    picArray=[NSMutableArray new];
//    [picArray removeAllObjects];
    sendTag=100;
    isSave=10;
    hideTabbar
    [self setTitle:self.navName];
    if (self.collectId==0)
    {
         [self creatSection];
    }
   
    _loadingMore=NO;
    isFilter=NO;
    headerArray=[NSMutableArray new];

  
    arearArray=[NSMutableArray new];
    oldArearArray=[NSMutableArray new];
    
    starArray=[NSMutableArray new];
    oldStarArray=[NSMutableArray new];
    
    SkilledArray=[NSMutableArray new];
    oldSkilledArray=[NSMutableArray new];

    oldTranslateArray=[NSMutableArray new];
    TranslateArray=[NSMutableArray new];

    

    
    arear=[NSMutableString stringWithString:@""];
    star=[NSMutableString stringWithString:@""];
    
    oldStartData=@"";
    oldEndData=@"";
    startData=@"";
    endData=@"";
    SkilledStr=[NSMutableString stringWithString:@""];
  TranslateStr=[NSMutableString stringWithString:@""];
    
    remindAlert=[[UIAlertView alloc]initWithTitle:@"正在加载..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    act.frame=CGRectMake(120, 48, 37, 37);
    [remindAlert addSubview:act];
   

    
    if ([self.navName isEqualToString:@"歌舞剧"])
    {
        [self crectIntroduce];
    }
    [self creatTableView];
    [self creatFilter];
    [self creatSelectType];
    [self creatSelectData];
    [self creatSelectPrice];
    [self creatSelectPlace];
    
    if ([self.navName isEqualToString:@"圣彼得堡租车"]||[self.navName isEqualToString:@"圣彼得堡导游"])
    {
        [self creatSelectCountry];
        [self creatSelectSeX];
        [self creatSelectSkilled];

    }
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
        [self creatTranslateSkilled];
       
    }

    
    isDisplay=NO;
    dataArray=[NSMutableArray new];
    dataForSearchArray=[NSMutableArray new];
    
    hotelListName=@"getHotelList";
    adervtProdPics=[NSString stringWithFormat:@"getAdervtProdPics%d",self.typeId];
    
    noNetButton=NoNetButton(noNetButton);

    [self refreshDataIndex:index1 andIsRefreshBody:YES andIsRefreshHead:YES andAnimal:NO];

    
    UIButton *backbutton2 = [[UIButton alloc]init] ;
    
    float height=20;
    backbutton2.frame=CGRectMake(0, (44-height)/2, height, height) ;
    
    backbutton2.titleLabel.font=[UIFont systemFontOfSize:14];
    [backbutton2 addTarget:self action:@selector(seach) forControlEvents:UIControlEventTouchUpInside];
    [backbutton2 setImage:[UIImage imageNamed:@"hotel_search.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:backbutton2] ;
    if (self.collectId==0)
    {
        self.navigationItem.rightBarButtonItem =backItem2;

    }
   
    [self creatSearchBar];
    if (_count==1000) {
        UIView *bv = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 120)];
        //bv.backgroundColor = [UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1];
        [self.view addSubview:bv];
        
        UIImageView *star2 = [[UIImageView alloc]initWithFrame:CGRectMake(125, 0, 71, 71)];
        star2.image = [UIImage imageNamed:@"star"];
        [bv addSubview:star2];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 320, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text =[NSString stringWithFormat:@"您还没有收藏过%@",self.title];
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.textColor = [UIColor lightGrayColor];
        [bv addSubview:lab];
    }

}
GO_NET
-(void)getAdervtProdPics
{
    NSString*canshu=[NSString stringWithFormat:@"cityid=%d&typeid=%d",2,self.typeId];
    NSString *urlMethod=@"getAdervtProdPics";
    NSMutableString*urlDomain=RussiaUrl3;
    [urlDomain appendString:urlMethod];
    postRequestYiBu(canshu, urlDomain)


}
-(void)creatSearchBar
{

    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    searchBar.text=@"";
    searchBar.tintColor=[UIColor brownColor];
    searchBar.placeholder=@"搜索";
    searchDisplayC=[[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayC.searchResultsTableView.backgroundColor=GroupColor;
    searchDisplayC.searchResultsTableView.separatorColor=[UIColor clearColor];
    searchDisplayC.delegate=self;
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
    [searchBar resignFirstResponder];
    [searchBar removeFromSuperview];
    isDisplay=NO;
    
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    isDisplay=NO;
    return YES;
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
postRequestAgencyAndRefeshAndAlert(datas, refresh, remindAlert,navActivity)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [navActivity stopAnimating];
       [remindAlert dismissWithClickedButtonIndex:0 animated:YES];
    dicResultYiBu(datas, result, dic)
    NSLog(@"dic============%@",dic);
    if (refresh.refreshing)
    {
        if ([[[dic valueForKey:@"ds"]  lastObject]valueForKey:@"ProdID"]==nil&&[[[dic valueForKey:@"ds"] lastObject]valueForKey:@"Row"]==nil)
        {
            _tabView.tableHeaderView=nil;
        }
        
        [refresh endRefreshing];
    }
    

    
    
    if ([[[dic valueForKey:@"ds"]  lastObject]valueForKey:@"ProdID"])
    {
        [headerArray removeAllObjects];
        headerArray=[dic valueForKey:@"ds"];
        _tabView.tableHeaderView=[self creatHeadView];
        WriteToFile(headerArray, adervtProdPics);
        return;
    }
    
    if (isDisplay==YES)
    {
         [dataForSearchArray removeAllObjects];
        
        NSLog(@"dic==========%@",dic);
        
        
        if ([[[dic valueForKey:@"ds"] lastObject]valueForKey:@"Row"])
        {
             NSLog(@"dic==========%@",dic);
             dataForSearchArray=[dic valueForKey:@"ds"];
        }
        
       
       
        [searchDisplayC.searchResultsTableView reloadData];
        
        
    }
    else
      {
          
        
          if (_loadingMore==NO)
          {
            
              
              if ([[[dic valueForKey:@"ds"] lastObject]valueForKey:@"Row"]||isFilter==YES)
              {
                  //isFilter 当筛选结果为空时，如果不加这个判断条件，进程将不会走进来
                  if (isFilter==YES)
                  {
                       isFilter=NO;
                  }
                 
              
                 [dataArray removeAllObjects];
                  dataArray=[dic valueForKey:@"ds"];
                  for (int i=0; i<dataArray.count; i++)
                  {
                      
                       NSMutableString*urlStr=PicUrl;
                      NSString*str=[NSString stringWithFormat:@"%@/%@",picPath,[[dataArray objectAtIndex:i] valueForKey:picName]] ;
                      [urlStr appendString:str];
                      
//                      int a=[[[dataArray objectAtIndex:i] valueForKey:picID]integerValue];
//                      Data*_data=[Data new];
                      
                      
                      NSString*path;
                      if (![self.navName isEqualToString:@"圣彼得堡租车"])
                      {
                          path=picPath;
                      }
                      else
                      {
                      
                          path=[NSString stringWithFormat:@"%@%@",picPath,picName];
                      }
                    //  [self downPic:urlStr andData:_data andTag:a andPath:path andTableView:_tabView];
                      
                      
                   //   [picArray addObject:_data];
                      
                      
            
                      
                  }

                 
              
              NSLog(@"111111111");
              if (isSave==10)
              {
                    WriteToFile(dataArray, dataMethod);
              }
              
                 
              }
          }
          else
          {
          
              if ([[[dic valueForKey:@"ds"] lastObject]valueForKey:@"Row"])
              {
//                  
//                  for (int j=0; j<[[dic valueForKey:@"ds"] count]; j++)
//                  {
//                      [dataArray addObject:[[dic valueForKey:@"ds"] objectAtIndex:j]];
//                        NSMutableString*urlStr=PicUrl;
//                      
//                            NSString*str=[NSString stringWithFormat:@"%@/%@",picPath,[[[dic valueForKey:@"ds"] objectAtIndex:j] valueForKey:picName]] ;
//                        [urlStr appendString:str];
//                          int a=[[[[dic valueForKey:@"ds"] objectAtIndex:j] valueForKey:picID]integerValue];
//                          Data*_data=[Data new];
//                       //   [self downPic:urlStr andData:_data andTag:a andPath:picPath andTableView:_tabView];
//                          
//                          
//                          [picArray addObject:_data];
//                      
//                  }
                  
                  
                  if (isSave==10)
                  {
                      WriteToFile(dataArray, dataMethod);
                  }

                 
                  [self loadDataEnd:@"上拉显示更多"];
              }
              else
              {
              
                  [self loadDataEnd:@""];

              }
              
              
          }
          
      
       }
    
          [_tabView reloadData];
    
}



#pragma mark--创建表头
-(UIView*)creatHeadView
{
       UIView*headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
  
    [headView addSubview:_scrollView];
       pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((320-200)/2+120,  _scrollView.frame.origin.y+_scrollView.frame.size.height-20, 200, 20)];
    
    
    _scrollView.contentSize=CGSizeMake(320*headerArray.count, 180);
    pageControl.numberOfPages=headerArray.count;
    pageControl.currentPage=0;
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _scrollView.delegate=self;
    
    for (int i=0; i<headerArray.count; i++)
    {
        UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
        [view setImage:[UIImage imageNamed:@"defaultBig.gif"] forState:UIControlStateNormal];
        [view addTarget:self action:@selector(touchHeader:) forControlEvents:UIControlEventTouchUpInside];
        view.tag=930+i;
        view.frame=CGRectMake(0+320*i, 0, 320, 180);
        NSString*str=[NSString stringWithFormat:@"%@%@%d",picPath,@"zhiding",i];
        if (FileExists(str))
        {
            NSData*data=[NSData dataWithContentsOfFile:PathOfFile(str)];
             [view setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        }
       
        RTLabel*lable=[[RTLabel alloc]initWithFrame:CGRectMake(5, 160, 200, 20)];
        lable.text=[[headerArray objectAtIndex:i] valueForKey:@"Title"];
        lable.font=[UIFont systemFontOfSize:15];
        lable.textColor=[UIColor whiteColor];
        [view addSubview:lable];
        [_scrollView addSubview:view];
    }

    [headView addSubview:pageControl];
    
    
    
   
    return headView;
}
-(void)pushNext:(int)senderTag andArray:(NSMutableArray*)_array andIndexPath:(NSIndexPath*)indexPath
{

    EntainDetailViewController*detail=[EntainDetailViewController new];
    detail.picPath2=picPath;
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
        detail.navName=@"酒店介绍";
        detail.classID=3;
        if ([_array isEqualToArray:headerArray])
        {
            detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ID"]integerValue];
            detail.picPath2 = @"hotel";
//            if ([self.navName isEqualToString:@"圣彼得堡住宿"])
//            {
//                picPath=@"hotel";
//                picName=@"HotelPic";
//                picID=@"HotelID";
//                
//                
//            }
            
        }
        else
        {
          
            detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"HotelID"]integerValue];
        
        }
    }
    //娱乐
    if (self.tag==1)
    {
        detail.navName=@"介绍";
        detail.classID=4;
        detail.tag=1;
        if ([_array isEqualToArray:headerArray])
        {
              detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
           
        }
        else
        {
           detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"TicketID"]integerValue];
        }

    }
    
    if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
        detail.navName=@"餐厅介绍";
        detail.classID=5;
        if ([_array isEqualToArray:headerArray])
        {

            detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
        }
        else
        {
            
        detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"RestID"]integerValue];
           
        }


    }
    
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        detail.navName=@"购物介绍";
        detail.classID=6;
        if ([_array isEqualToArray:headerArray])
        {

        detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
        }
        else
        {
          
        detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ShopID"]integerValue];
       
        }

    }
    if ([self.navName isEqualToString:@"景点列表"])
    {
        if ([_array isEqualToArray:headerArray])
        {
            detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
        }
        else
        {
           detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ViewID"]integerValue];
       
        }
        detail.classID=7;
        detail.navName=@"景点介绍";
        
    }
 

   
    [self.navigationController pushViewController:detail animated:NO];


}
-(void)touchHeader:(UIButton*)sender
{
   
    [self pushNext:sender.tag-930 andArray:headerArray andIndexPath:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset= scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x/bounds.size.width];
    
}
-(void)creatTableView
{

    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40.5, 320, DeviceHeight-44-20-45) style:UITableViewStylePlain];
    
    if ([self.navName isEqualToString:@"歌舞剧"])
    {
        
        _tabView.frame=CGRectMake(0, 170, 320, DeviceHeight-44-20-170);
        
    }

    if (self.tag==1)
    {
           _tabView.frame=CGRectMake(0, 40.5, 320, DeviceHeight-44-20-45);
    }
    if (self.collectId!=0)
    {
        _tabView.frame=CGRectMake(0, 0, 320, DeviceHeight-44-20);
    }

    _tabView.tag=1;
    _tabView.delegate=self;
    _tabView.dataSource=self;
    _tabView.delaysContentTouches=YES;

   
    [UIColor groupTableViewBackgroundColor];
       //    _tabView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    _tabView.separatorColor=[UIColor clearColor];
    _tabView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tabView.tableFooterView=[self createTableFooter:@"上拉显示更多"];
    //    _tabView.separatorInset=UIEdgeInsetsMake(10, 0, 10, 0);
    [self.view addSubview:_tabView];

    refresh=[[UIRefreshControl alloc] init];
    refresh.tintColor=[UIColor clearColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@""];
    
    [refresh addTarget:self action:@selector(refreshing) forControlEvents:UIControlEventValueChanged];
    [_tabView addSubview:refresh];


}
-(void)refreshing
{
    index1=0;
    [self refreshDataIndex:index1 andIsRefreshBody:YES andIsRefreshHead:YES andAnimal:NO];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];
//    [navActivity stopAnimating];

}
-(void)refreshDataIndex:(int)_index andIsRefreshBody:(BOOL)body andIsRefreshHead:(BOOL)head andAnimal:(BOOL)animal
{
    
  
    [navActivity startAnimating];
    
    
    if (self.collectId!=0)
    {

        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
      
        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectId],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",index1],@"pageindex", nil];
        
        NSMutableString*str=RussiaUrl4
        [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:dic andDelegate:self];
        
    }
    else
    {
//    [picArray removeAllObjects];
    NSString*canshu;
    NSMutableString*urlDomain=RussiaUrl3;
    if ([self.navName isEqualToString:@"圣彼得堡租车"]||[self.navName isEqualToString:@"圣彼得堡导游"])
    {
        urlDomain=RussiaUrl4;
    }
    
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
        
       canshu=[NSString stringWithFormat:@"cityid=%d&hname=%@&arear=%@&star=%@&lprice=%d&hprice=%d&orderby=%d&pagesize=%d&pageindex=%d",2,@"",arear,star,lowprice,higprice,orderbystr,LoadCount,_index];
        
        dataMethod=@"getHotelList";
        
        
        
    }
    
    if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
        canshu=[NSString stringWithFormat:@"cityid=%d&rname=%@&area=%@&restype=%@&lprice=%d&hprice=%d&orderby=%d&pagesize=%d&pageindex=%d",2,@"",arear,star,lowprice,higprice,orderbystr,LoadCount,_index];
        
        dataMethod=@"getRestProdList";
        
    }
    
    if ([self.navName isEqualToString:@"圣彼得堡娱乐"])
    {
        canshu=[NSString stringWithFormat:@"cityid=%d&tname=%@&ticketype=%@&lprice=%d&hprice=%d&stime=%@&etime=%@&orderby=%d&pagesize=%d&pageindex=%d",2,@"",star,lowprice,higprice,[[startData componentsSeparatedByString:@" "] objectAtIndex:0],  [[endData componentsSeparatedByString:@" "] objectAtIndex:0],orderbystr,LoadCount,_index];

        dataMethod=@"getTicketProdList";
        
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
         canshu=[NSString stringWithFormat:@"cityid=%d&rname=%@&area=%@&restype=%@&orderby=%d&pagesize=%d&pageindex=%d",2,@"",arear,star,orderbystr,LoadCount,_index];
        
        dataMethod=@"getShopProdList";
        
    }
    if ([self.navName isEqualToString:@"景点列表"])
    {
        canshu=[NSString stringWithFormat:@"cityid=%d&rname=%@&area=%@&viewtype=%@&orderby=%d&pagesize=%d&pageindex=%d",2,@"",arear,star,orderbystr,LoadCount,_index];
        
        dataMethod=@"getViewList";
        
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
        canshu=[NSString stringWithFormat:@"cityid=%d&cname=%@&carclass=%@&sex=%d&country=%d&lprice=%d&hprice=%d&jiangjie=%@&seatcount=%@&orderby=%d&pagesize=%d&pageindex=%d",2,@"",star,Sex,Country,lowprice,higprice,SkilledStr,arear,orderbystr,LoadCount,_index];

        dataMethod=@"getCarList";
        
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
        canshu=[NSString stringWithFormat:@"cityid=%d&gname=%@&guideclass=%@&sex=%d&country=%d&lprice=%d&hprice=%d&jiangjie=%@&fanyi=%@&orderby=%d&pagesize=%d&pageindex=%d",2,@"",star,Sex,Country,lowprice,higprice,SkilledStr,TranslateStr,orderbystr,LoadCount,_index];
        
        dataMethod=@"getGuideList";
        
        
    }

    
    if (FileExists(dataMethod))
    {
        headerArray=[NSMutableArray arrayWithContentsOfFile:PathOfFile(adervtProdPics)];
        dataArray=[NSMutableArray arrayWithContentsOfFile:PathOfFile(dataMethod)];
       if(FileExists(adervtProdPics))
       {
            _tabView.tableHeaderView=[self creatHeadView];
        }
    }
    if(body==YES)
    {
        Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];if ([rea2  currentReachabilityStatus]==NotReachable)
        {
            
            noNetButton.hidden=NO;
        }
        else
        {
         noNetButton.hidden=YES;
        }

        
        [urlDomain appendString:dataMethod];
        
        postRequestYiBu(canshu, urlDomain)
        
        if (head==YES&&![self.navName isEqualToString:@"圣彼得堡租车"]&&![self.navName isEqualToString:@"圣彼得堡导游"])
        {
            [self performSelector:@selector(getAdervtProdPics) withObject:nil afterDelay:0.2];
        }
        
        if (animal==YES)
        {
//            [act startAnimating];
//            
//            [remindAlert show];
        }
       
    }

    }
    
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
            if ([self.navName isEqualToString:@"圣彼得堡住宿"])
            {
                 canshu=[NSString stringWithFormat:@"cityid=%d&hname=%@&arear=%@&star=%@&lprice=%d&hprice=%d&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",@"",0,0,0,20,0];
                  urlMethod=@"getHotelList";
            }
            if ([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&cname=%@&carclass=%@&sex=%d&country=%d&lprice=%d&hprice=%d&jiangjie=%@&seatcount=%@&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",0,0,0,0,@"",@"",0,LoadCount,0];
                    urlMethod=@"getCarList";

            }

           
            if ([self.navName isEqualToString:@"圣彼得堡娱乐"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&tname=%@&ticketype=%@&lprice=%d&hprice=%d&stime=%@&etime=%@&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",0,0,@"", @"",0,20,0];
                urlMethod=@"getTicketProdList";

            }
            
            if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&rname=%@&area=%@&restype=%@&lprice=%d&hprice=%d&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",@"",0,0,0,20,0];
                urlMethod=@"getRestProdList";
            }
            if ([self.navName isEqualToString:@"圣彼得堡购物"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&rname=%@&area=%@&restype=%@&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",@"",0,20,0];
                urlMethod=@"getShopProdList";
                
            }

            if ([self.navName isEqualToString:@"景点列表"])
            {
                
                
                canshu=[NSString stringWithFormat:@"cityid=%d&rname=%@&area=%@&viewtype=%@&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",@"",0,20,0];
                    urlMethod=@"getViewList";
            }

            
            if ([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                canshu=[NSString stringWithFormat:@"cityid=%d&gname=%@&guideclass=%@&sex=%d&country=%d&lprice=%d&hprice=%d&jiangjie=%@&fanyi=%@&orderby=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",0,0,0,0,@"",@"",0,LoadCount,0];
                
                urlMethod=@"getGuideList";
                
                
            }
            

            
            NSMutableString*urlDomain=RussiaUrl3;
        
            if ([self.navName isEqualToString:@"圣彼得堡导游"]||[self.navName isEqualToString:@"圣彼得堡租车"])
            {
                urlDomain=RussiaUrl4
            }
            [urlDomain appendString:urlMethod];
            
            postRequestYiBu(canshu, urlDomain)

            
            isDisplay=YES;
            
            
        }
        
       
        return dataForSearchArray.count;
        
            
       
    }

    
    if ([[dataArray lastObject]valueForKey:@"Row"])
    {

        return dataArray.count;

    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {    NSDictionary *dic = dataArray[indexPath.row];
        NSLog(@"dic %@",dic);
        if (dataArray.count>0&&[[dic objectForKey:@"GuideType"] intValue]==2) {
            int h = 0;
            for (NSString *keyStr in priceKey) {
                if ([[dic objectForKey:keyStr] intValue]!=0) {
                    h++;
                    NSLog(@"h %d",h);
                }
            }
            if (h>1) {
                return 100+(h-1)*20;
            }else return 100;
        }
      
        
        return 170;
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
        NSMutableArray*_array;
        if (tableView==_tabView)
        {
            _array=[NSMutableArray arrayWithArray:dataArray];
        }
        else
        {
            _array=[NSMutableArray arrayWithArray:dataForSearchArray];
            
        }
        
        
        
        if (_array.count>0)
        {
            if ([[[_array objectAtIndex:indexPath.row]valueForKey:@"GuideType"]intValue]==2)
            {

                NSDictionary *dic = dataArray[indexPath.row];
                if (dataArray.count>0&&[[dic objectForKey:@"GuideType"] intValue]==2) {
                    int h = 0;
                    for (NSString *keyStr in priceKey) {
                        if ([[dic objectForKey:keyStr] intValue]!=0) {
                            h++;
                            NSLog(@"h %d",h);
                        }
                    }
                    if (h>1) {
                        return 75+(h-1)*20;
                    }else return 100;
                }
                //return 178;
                
            }
            
        }
        
        
        
        return 115;
    }
    
    return 100;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
        
        GuideTableViewCell *guideCell = [tableView dequeueReusableCellWithIdentifier:@"guideCell"];
        if (!guideCell) {
            guideCell = [[GuideTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"guideCell"];
        }
        SupplierTableViewCell *supplierCell = [tableView dequeueReusableCellWithIdentifier:@"supplierCell"];
        if (!supplierCell) {
            supplierCell = [[SupplierTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"supplierCell"];
        }
        if (dataArray.count>0) {
            NSDictionary *dic;
            if (tableView==_tabView)
            {
                dic = dataArray[indexPath.row];
            }
            else
            {
                dic = dataForSearchArray[indexPath.row];
                
            }
            
            
            if ([[dic objectForKey:@"GuideType"] intValue]==1) {
               
                [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:picName picHeadUrlStr:PicUrl picUrlPathStr:picPath PicLoadName:[dic objectForKey:@"UName"] headView:guideCell.iv];
                //人物
                NSString *sexStr_;
                if ([[dic objectForKey:@"Country"] intValue]==1) {
                    sexStr_ = @"男";
                }else sexStr_ = @"女";
                
                guideCell.nameLab.text = [NSString stringWithFormat:@"<font  size=14 color=black><b>%@</b></font> <font  size=12 color=gray>%@ %@</font> <font size=12>%@</font>",[dic objectForKey:@"UName"],[[dic objectForKey:@"Country"] intValue]==2?@"俄籍":@"",sexStr_,[dic objectForKey:@"GuideClass"]];

                //车
                if ([[dic objectForKey:@"SeatCount"] intValue]>0) {
                    guideCell.carLab.text = [NSString stringWithFormat:@"<font size=12 color=black>%@人座 %@ %@</font>",[dic objectForKey:@"SeatCount"],[dic objectForKey:@"CarType"],[dic objectForKey:@"JiCheng"]];
                }
                
                //语言
                guideCell.languageLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>语言 :</font> <font size=12 color=black>%@</font>",[dic objectForKey:@"Language"]];
                //讲解
                guideCell.sayLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>擅长讲解 :</font> <font size=12 color=black>%@</font>",[dic objectForKey:@"JiangJie"]];
                
                
                //服务
                guideCell.serviceLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>服务宗旨 :</font> <font size=12 color=black>%@</font>",[dic objectForKey:@"ZongZhi"]];
                // guideCell.serviceLab.frame = CGRectMake(115, 90, 200, 40);//guideCell.serviceLab.optimumSize.height
                
                //天
                guideCell.dayLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>$</font><font size=16 color=orange>%@</font><font  size=12 color=gray>/天,每天工作%@小时</font>",[dic objectForKey:@"UPrice"],[dic objectForKey:@"Hour"]];
                return guideCell;
            }
            
            [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:picName picHeadUrlStr:PicUrl picUrlPathStr:picPath PicLoadName:[dic objectForKey:@"UName"] headView:supplierCell.iv];
            //公司名
            NSString *countryStr_;
            if ([[dic objectForKey:@"Country"] intValue]==2) {
                countryStr_ = @"俄籍";
            }else countryStr_ = @"中国籍";
            
            supplierCell.nameLab.text = [NSString stringWithFormat:@"<font  size=14 color=black><b>导游/翻译预订</b></font> <font  size=12 color=red>%@</font>",[dic objectForKey:@"UName"]];
           
            //人数
            supplierCell.carLab.text = [NSString stringWithFormat:@"<font size=12 color=gray>导游(</font>%@人 <font size=12 color=gray>)翻译(</font>%@人<font size=12 color=gray>)</font>",[dic objectForKey:@"GuideCount"],[dic objectForKey:@"FanYiCount"]];
            //年龄
            supplierCell.languageLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>年龄 :</font> <font size=12 color=black>%@</font>",[dic objectForKey:@"AgeList"]];
            
            //学导---

            
            if (dataArray.count>0&&[[dic objectForKey:@"GuideType"] intValue]==2) {
                int h = 0;
                
                for (int i= 0; i<8 ; i++) {
                    
                    if ([[dic objectForKey:priceKey[i]] intValue]!=0) {
                        
                        UILabel *mainLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 70+20*h++, 200, 20)];
                        
                        
                        UILabel *tittlePriceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
                        tittlePriceLab.textColor = [UIColor grayColor];
                        tittlePriceLab.font = [UIFont systemFontOfSize:12];
                        tittlePriceLab.text = [NSString stringWithFormat:@"%@",tittles[i]];
                        [mainLab addSubview:tittlePriceLab];
                        
                        
                        RTLabel *priceLab = [[RTLabel alloc]initWithFrame:CGRectMake(90, 0, 60, 20)];
                        priceLab.textColor = [UIColor grayColor];
                        priceLab.font = [UIFont systemFontOfSize:12];
                        [mainLab addSubview:priceLab];
                        priceLab.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"CNUStudent"] intValue]==0?@"无":[NSString stringWithFormat:@" : $<font  size=16 color=orange>%@</font>/天",[dic objectForKey:priceKey[i]]]];
                        [supplierCell.contentView addSubview:mainLab];
                        
                    }
                    
                }
                UIImageView *_link = [[UIImageView alloc]init];
                _link.image = [UIImage imageNamed:@"entainmentLink"];
                
                
                if (h>1) {
                    _link.frame = CGRectMake(0, 100+(h-1)*20-2, 320, 2);
                    
                }else _link.frame = CGRectMake(0, 98, 320, 2);
                [supplierCell.contentView addSubview:_link];
            }
        }

        return supplierCell;

    }
    
    
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
        static NSString*personage=@"personage";
        static NSString*company=@"company";
        
        //NSMutableArray*_picArray;
        NSMutableArray*_dataArray;
        if (tableView==searchDisplayC.searchResultsTableView)
        {
//            _picArray=[NSMutableArray arrayWithArray:searchPicArray];
            _dataArray=[NSMutableArray arrayWithArray:dataForSearchArray];
  
        }
        
        if (tableView==_tabView)
        {
//            _picArray=[NSMutableArray arrayWithArray:picArray];
            _dataArray=[NSMutableArray arrayWithArray:dataArray];
            
        }
       
     
        if ([[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"GuideType"] integerValue]==1)
        {
            TaxiPersonageCell*personageCell=[tableView dequeueReusableCellWithIdentifier:personage];
            if (personageCell==nil)
            {
                personageCell=[[TaxiPersonageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personage];
            }
            else
            {
                //删除cell的所有子视图
                
                while([personageCell.contentView.subviews lastObject] != nil)
                {
                    [(UIView*)[personageCell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            

          
            NSString*name=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"UName"];
            [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:picName picHeadUrlStr:PicUrl picUrlPathStr:picPath PicLoadName:name headView:personageCell._imageView];
            NSString*seat=[NSString stringWithFormat:@"%@人座", [[_dataArray objectAtIndex:indexPath.row]valueForKey:@"SeatCount"]];
            
            NSString*sex=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"Sex"];
            if ([[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"Sex"] integerValue]==1)
            {
                sex=@"男";
            }
            else
            {
                sex=@"女";
            }
            
            NSString*CarClass=[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"CarType"];
            NSString*jicheng=[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"JiCheng"];
            
            
            personageCell.nameCountrySexSeatCountCarClassJicheng.text=[NSString stringWithFormat:@"<font size=15 color=black>%@</font> <font size=12 color=gray>%@ %@ </font><font size=12>%@ %@ %@</font>",name,[[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"Country"] integerValue]==1?@"":@"俄籍",sex,seat,CarClass,jicheng];
            personageCell.carBrand.text=[NSString stringWithFormat:@"<font size=13 color=gray>汽车品牌：<font color=black>%@</font></font>",[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"CarBrand"]];
            personageCell.zongZhi.text=[NSString stringWithFormat:@"<font size=13 color=gray>服务宗旨：<font color=black>%@</font></font>",[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"ZongZhi"]];
            
            NSString*hour=[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"Hour"];
            NSString*price=[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"UPrice"];
            personageCell.priceHour.text=[NSString stringWithFormat:@"<font size=13 color=gray>$<font size=17 color=orange>%@</font>/天,每天工作%@个小时</font>",price,hour];
            
            return personageCell;

        }
       else
       {
        
        TaxiCompanyCell*companyCell=[tableView dequeueReusableCellWithIdentifier:company];
        if (companyCell==nil)
        {
            companyCell=[[TaxiCompanyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:company];
        }
        else
        {
            //删除cell的所有子视图

            while([companyCell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[companyCell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
           

            NSString*name=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"UName"];
           [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:picName picHeadUrlStr:PicUrl picUrlPathStr:picPath PicLoadName:name headView:companyCell._imageView];
           NSString*count=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"GuideCount"];
           NSString*price1=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"CNUStudent"];
           NSString*price2=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"CNUSpasice"];
           NSString*price3=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"RUUPutong"];
           NSString*price4=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"RUUSpasice"];
           NSString*price5=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"SuiUFanyi"];
          // NSString*price6=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"GWUFanyi"];
           NSString*price7=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"ZYUFanYi"];
           NSString*price8=[[_dataArray objectAtIndex:indexPath.row]valueForKey:@"ZJUFanYi"];
           NSArray *RMBPriceKeyArr = @[@"CNRStudent",@"CNRSpasice",@"RURPutong",@"RURSpasice",@"SuiRFanyi",@"ZYRFanYi",@"ZJRFanYi"];
        NSArray*priceType=@[@"FiveType",@"SixType",@"SevenType",@"NineType",@"FifteenType",@"SeventeemType",@"TwenType",@"ForType"];
           NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys:@"小时",@"1",@"天",@"2", nil];
           NSMutableString *allString = [NSMutableString stringWithFormat:@"<font size=15 >租车预订</font> <font size=13 color=red>%@</font><br><font size=13 color=gray>租车(<font color='006db8'>%@辆</font>)",name,count];
           if (price1.integerValue>0) {
              NSString*priceType1=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>5人座： $<font color=orange>%@</font>/%@",price1,priceType1];
           }
           if (price2.integerValue>0) {
               NSString*priceType2=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>6人座： $<font color=orange>%@</font>/%@",price2,priceType2];
           }
           if (price3.integerValue>0) {
               NSString*priceType3=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>7人座：$<font color=orange>%@</font>/%@",price3,priceType3];
           }
           if (price4.integerValue>0) {
               NSString*priceType4=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>9人座：$<font color=orange>%@</font>/%@",price4,priceType4];
           }
           if (price5.integerValue>0) {
               NSString*priceType5=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>15人座：$<font color=orange>%@</font>/%@",price5,priceType5];
           }
//           if (price6.integerValue>0) {
//               NSString*priceType6=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
//               [allString appendFormat:@"<br>17人座：$<font color=orange>%@</font>/%@",price6,priceType6];
//           }
           if (price7.integerValue>0) {
               NSString*priceType7=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>20人座：$<font color=orange>%@</font>/%@",price7,priceType7];
           }
           if (price8.integerValue>0) {
               NSString*priceType8=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
               [allString appendFormat:@"<br>40人座：$<font color=orange>%@</font>/%@",price8,priceType8];
           }
           companyCell.text.text=allString;
           //113, 10, 200, 170
           
           companyCell.text.frame = CGRectMake(113, 10, 200, companyCell.text.optimumSize.height);
           companyCell.link.frame =CGRectMake(10, companyCell.text.frame.origin.y+companyCell.text.frame.size.height+10, 300, 2);


       
           return companyCell;
       
       }
        
    }
    
    
    
    static NSString*str=@"cell";
    CustomSceneryCell*cell2=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell2==nil)
    {
        cell2=[[CustomSceneryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
   
        //删除cell的所有子视图
        
        while([cell2.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell2.contentView.subviews lastObject] removeFromSuperview];
        }
    

    if (tableView==searchDisplayC.searchResultsTableView)
    {
        
         [self cellContent:cell2 andArray:dataForSearchArray andIndexpath:indexPath];

    }
    
    if (tableView==_tabView)
    {
        
        [self cellContent:cell2 andArray:dataArray andIndexpath:indexPath];
        
    }
     return cell2;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableArray*_array;
    if (tableView==_tabView)
    {
        _array=[NSMutableArray arrayWithArray:dataArray];
    }
    else
    {
        _array=[NSMutableArray arrayWithArray:dataForSearchArray];
    }
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
       
        
        
        if ([[_array[indexPath.row]objectForKey:@"GuideType"] intValue]==1) {
            GuideDetailViewController *gdvc = [GuideDetailViewController new];
            gdvc.tag = 2;
            gdvc.gudieID = [_array[indexPath.row]objectForKey:@"GuideID"];
            gdvc.title = [NSString stringWithFormat:@"%@%@",[_array[indexPath.row]objectForKey:@"UName"],[_array[indexPath.row]objectForKey:@"GuideClass"]];
            GuideTableViewCell *cell=(GuideTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            gdvc.picImage = cell.iv.image;
            [self.navigationController pushViewController:gdvc animated:NO];
        }else{
            NSArray *guideAndTransitionTittleArr = @[@"中国留学生导游",@"专业俄籍导游",@"普通俄籍导游",@"专业中国导游",@"随行简单翻译",@"专业翻译",@"公务、商务翻译",@"专家翻译"];
            NSArray *guideAndTransitionKeyArr = @[@"CNUStudent",@"CNUSpasice",@"RUUPutong",@"RUUSpasice",@"SuiUFanyi",@"ZYUFanYi",@"GWUFanyi",@"ZJUFanYi"];
            
            for (int i = 0 ;i < guideAndTransitionKeyArr.count ; i++) {
                if ([[_array[indexPath.row] objectForKey:guideAndTransitionKeyArr[i]] intValue]>0) {
                    
                    [guideAndTransitionArr addObject:[NSString stringWithFormat:@"%@ $<font  size=16 color=orange>%@</font>/天",guideAndTransitionTittleArr[i],[_array[indexPath.row] objectForKey:guideAndTransitionKeyArr[i]]]];
                }
            }
            
            SupplierTableViewController *sdvc = [SupplierTableViewController new];
            sdvc.gudieID = [_array[indexPath.row]objectForKey:@"GuideID"];
            GuideTableViewCell *cell=(GuideTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            sdvc.title = @"导游/翻译预订";
            sdvc.tag = 2;
            sdvc.tableArr=guideAndTransitionArr;
            sdvc.picImage = cell.iv.image;
            [self.navigationController pushViewController:sdvc animated:NO];
        }
        return;
    }
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
     
        if ([[_array[indexPath.row]objectForKey:@"GuideType"] intValue]==1) {
            
            GuideDetailViewController *gdvc = [GuideDetailViewController new];
            gdvc.tag = 3;
            if ([_array isEqualToArray:headerArray])
            {
                gdvc.gudieID=[[_array objectAtIndex:indexPath.row]valueForKey:@"ProdID"];
            }else
            {
                gdvc.gudieID=[[_array objectAtIndex:indexPath.row]valueForKey:@"GuideID"];
                
            }
            if ([[[_array objectAtIndex:indexPath.row] valueForKey:@"GuideType"] integerValue]==1) {
                TaxiPersonageCell *cell = (TaxiPersonageCell*)[_tabView cellForRowAtIndexPath:indexPath];
                gdvc.picImage = cell._imageView.image;
            }else {
                TaxiCompanyCell *cell = (TaxiCompanyCell*)[_tabView cellForRowAtIndexPath:indexPath];
                gdvc.picImage = cell._imageView.image;
            }
            
            gdvc.title=[NSString stringWithFormat:@"%@%@",[[_array objectAtIndex:indexPath.row]valueForKey:@"UName"],@"租车"];
            [self.navigationController pushViewController:gdvc animated:NO];
        }else{
            NSArray *guideAndTransitionTittleArr = @[@"5人座",@"6人座",@"7人座",@"9人座",@"15人座",@"20人座",@"40人座"];
            NSArray *guideAndTransitionKeyArr = @[@"CNUStudent",@"CNUSpasice",@"RUUPutong",@"RUUSpasice",@"SuiUFanyi",@"ZYUFanYi",@"ZJUFanYi"];//,@"ZYUFanYi"  17人座
            NSArray*priceType=@[@"FiveType",@"SixType",@"SevenType",@"NineType",@"FifteenType",@"TwenType",@"ForType"];//,@"SeventeemType"
            NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys:@"小时",@"1",@"天",@"2", nil];
            
            for (int i = 0 ;i < guideAndTransitionKeyArr.count ; i++) {
                if ([[_array[indexPath.row] objectForKey:guideAndTransitionKeyArr[i]] intValue]>0) {
                    NSString*priceType2=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[_array objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:i]]]];
                    [guideAndTransitionArr addObject:[NSString stringWithFormat:@"%@        $<font  size=16 color=orange>%@</font>/%@",guideAndTransitionTittleArr[i],[_array[indexPath.row] objectForKey:guideAndTransitionKeyArr[i]],priceType2]];
                }
            }
            
            SupplierTableViewController *sdvc = [SupplierTableViewController new];
            sdvc.gudieID = [_array[indexPath.row]objectForKey:@"GuideID"];
            TaxiCompanyCell *cell=(TaxiCompanyCell*)[tableView cellForRowAtIndexPath:indexPath];
            sdvc.title = @"租车预订";
            sdvc.tag = 3;
            sdvc.tableArr=guideAndTransitionArr;
            sdvc.picImage = cell._imageView.image;
            [self.navigationController pushViewController:sdvc animated:NO];
        }
        return;
        
    }
    
    if (tableView==_tabView)
    {
        [self pushNext:indexPath.row andArray:dataArray andIndexPath:indexPath];
    }
    
    else
    {
        
        [self pushNext:indexPath.row andArray:dataForSearchArray andIndexPath:indexPath];
        
    }
    
    
    
    
}
#pragma mark--cell内容
-(void)cellContent:(UITableViewCell*)_cell2 andArray:(NSMutableArray*)_array andIndexpath:(NSIndexPath*)indexPath
{
    CustomSceneryCell*cell2=(CustomSceneryCell*)_cell2;
    
    if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
        
       
        cell2.russiaHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"RestRName"];
        cell2.chineseHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"RestCName"];
        cell2.type.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"RestType"];
        cell2.type.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        cell2.type.textColor=[UIColor grayColor];
        cell2.gradeCount.text=[NSString stringWithFormat:@"人均消费:$%@", [[_array objectAtIndex:indexPath.row] valueForKey:@"USPrice"]];
        cell2.gradeImage.image=nil;
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        cell2.price.text=@"";

        
    }
 
    
    if ([self.navName isEqualToString:@"景点列表"])
    {
      
        cell2.russiaHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"ViewRUName"];
        cell2.chineseHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"ViewCNName"];
        cell2.type.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"ViewType"];
        
        
        
        NSLog(@"row  %d DianpCount %d",indexPath.row,[[[_array objectAtIndex:indexPath.row] valueForKey:@"DianpCount"] intValue]);
        
        cell2.gradeCount.text=[NSString stringWithFormat:@"开放时间  %@", [[_array objectAtIndex:indexPath.row] valueForKey:@"ShowTime"] ];
        
        if ([[[_array objectAtIndex:indexPath.row]valueForKey:@"LPrice"]integerValue]!=0)
        {
            cell2.price.text=[NSString stringWithFormat:@"$<font size=21 color=orange>%@</font>起",[[_array objectAtIndex:indexPath.row] valueForKey:@"USPrice"]];

            
        }
        else
        {
            
            cell2.price.text=@"";
        }

        
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
               cell2.russiaHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"ShopRName"];
        cell2.chineseHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"ShopCName"];
        cell2.type.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"ShopType"];
        cell2.gradeCount.text=[NSString stringWithFormat:@"营业时间:%@", [[_array objectAtIndex:indexPath.row] valueForKey:@"ShowTime"]];
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeImage.image=nil;
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        cell2.price.text=@"";
        
    }
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
       
        NSString*_str;
        switch ([[[_array objectAtIndex:indexPath.row]valueForKey:@"Star"]integerValue])
        {
            case 1:
            {
                _str=@"青年旅舍";
            }
                break;
            case 2:
            {
                _str=@"二星级/自主型";
            }
                break;
            case 3:
            {
                _str=@"三星级/经济型";
            }
                break;
            case 4:
            {
                _str=@"四星级/舒适型";
            }
                break;
            case 5:
            {
                _str=@"五星级/豪华型";
            }
                break;
            case 6:
            {
                _str=@"家庭式公寓";
            }
                break;
            case 7:
            {
                _str=@"别墅";
            }
                break;
            case 8:
            {
                _str=@"其他";
            }
                break;
            default:
                break;
        }

        
        cell2.russiaHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"HotelRUName"];
        cell2.chineseHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"HotelCNName"];
        cell2.type.text=[NSString stringWithFormat:@"房间数量:%@间",[[_array objectAtIndex:indexPath.row] valueForKey:@"RoomCount"]];
        cell2.gradeCount.text=_str;
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeImage.image=nil;
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
     
        
        if ([[[_array objectAtIndex:indexPath.row]valueForKey:@"LPrice"]integerValue]!=0)
        {
             cell2.price.text=[NSString stringWithFormat:@"<font  color=orange>$<font size=21>%d</font></font>起", [[[_array objectAtIndex:indexPath.row]valueForKey:@"LPrice"]integerValue]];
            
        }
        else
        {
            
            cell2.price.text=@"";
        }

        
    }

    if ([self.navName isEqualToString:@"圣彼得堡娱乐"])
    {
       
        cell2.russiaHead.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"TicketRName"];
        CGSize size=[cell2.russiaHead sizeThatFits:CGSizeMake(230, 0)];
        cell2.russiaHead.frame=CGRectMake( cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.backGround.frame.origin.y+10,230 , size.height);
        
        cell2.chineseHead.text=@"";
        cell2.type.text=[[_array objectAtIndex:indexPath.row] valueForKey:@"TicketClass"];
        cell2.gradeCount.text=[NSString stringWithFormat:@"时长:%@", [[_array objectAtIndex:indexPath.row] valueForKey:@"TimeLong"]];
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeImage.image=nil;
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    if ([[[_array objectAtIndex:indexPath.row]valueForKey:@"UDPrice"]integerValue]!=0)
        {
            cell2.price.text=[NSString stringWithFormat:@"$<font size=21  color=orange>%d</font>", [[[_array objectAtIndex:indexPath.row]valueForKey:@"UDPrice"]integerValue]];;

        }
        else
        {
        
            cell2.price.text=@"";
        }
    }

    
  //[self loadPic_tableViewIndexPath:indexPath headLabName: cell2.russiaHead.text headView:cell2._imageView];

    [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:picName picHeadUrlStr:PicUrl picUrlPathStr:picPath PicLoadName:cell2.russiaHead.text headView:cell2._imageView];

}

#pragma mark--创建餐厅cell
-(UIButton*)creatCellIndex:(int)index andArray:(NSArray*)_dataArray andIndexPath:(int)indexPath
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.tag=10000+indexPath;
    [button addTarget:self action:@selector(tttt:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(10+index*155, 10, 145, 160);
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 80)];
    imageView.backgroundColor=[UIColor blueColor];
    [button addSubview:imageView];
    
    
    RTLabel*russiaLable=[[RTLabel alloc]initWithFrame:CGRectMake(3, imageView.frame.origin.y+imageView.frame.size.height, 145, 0)];
    russiaLable.font=[UIFont systemFontOfSize:15];
    russiaLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"RestRName"];
    
    CGSize size=[russiaLable optimumSize];
    russiaLable.frame=CGRectMake(3, imageView.frame.origin.y+imageView.frame.size.height, 145, size.height);
    [button addSubview:russiaLable];
    
    
    
    UILabel*chineseLable=[[UILabel alloc]initWithFrame:CGRectMake(3, russiaLable.frame.origin.y+russiaLable.frame.size.height, 145, 20)];
    chineseLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"RestCName"];
  
    
    chineseLable.font=[UIFont systemFontOfSize:14];
    chineseLable.textColor=[UIColor grayColor];
    [button addSubview:chineseLable];
    
    UILabel*typeLable=[[UILabel alloc]initWithFrame:CGRectMake(3, 120, 145, 20)];
    typeLable.font=[UIFont systemFontOfSize:13];
    typeLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"RestType"];
    typeLable.textColor=[UIColor grayColor];
    [button addSubview:typeLable];
    
    
    RTLabel*_price=[[RTLabel alloc]initWithFrame:CGRectMake(3,140, 142, 20)];
    _price.text=[NSString stringWithFormat:@"人均消费：$%@",[[_dataArray objectAtIndex:indexPath]valueForKey:@"Price"]];
    
    
    _price.font=[UIFont systemFontOfSize:12];
    _price.textColor=[UIColor grayColor];
    [button addSubview:_price];
    
    button.backgroundColor=[UIColor whiteColor];
    return button;




}


#pragma mark--创建住宿cell
-(UIButton*)creatCellIndex:(int)index andArray:(NSArray*)_dataArray andIndex:(int)indexPath andTableView:(UITableView*)tableView
{
    
    
   
    NSLog(@"tag====%d",indexPath);
    
   
    NSString*str;
    switch ([[[_dataArray objectAtIndex:indexPath]valueForKey:@"Star"]integerValue])
    {
        case 1:
        {
            str=@"其他";
        }
            break;
        case 2:
        {
           str=@"青年旅舍、公寓";
        }
            break;
        case 3:
        {
            str=@"三星级/经济型";
        }
            break;
        case 4:
        {
            str=@"四星级/舒适型";
        }
            break;
        case 5:
        {
            str=@"五星级/豪华型";
        }
            break;
        default:
            break;
    }
    

    
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.tag=10000+indexPath;
        [button addTarget:self action:@selector(tttt:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(10+index*155, 10, 145, 170);
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 80)];
    imageView.backgroundColor=[UIColor blueColor];
    [button addSubview:imageView];
    
    
    UILabel*russiaLable=[[UILabel alloc]initWithFrame:CGRectMake(3, imageView.frame.origin.y+imageView.frame.size.height, 145, 20)];
    russiaLable.font=[UIFont systemFontOfSize:15];
    russiaLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"HotelRUName"];
    if (self.tag==1)
    {
        russiaLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"TicketRName"];
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        russiaLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"ShopRName"];
    }


    
    [button addSubview:russiaLable];
    
    
    
    UILabel*chineseLable=[[UILabel alloc]initWithFrame:CGRectMake(3, russiaLable.frame.origin.y+russiaLable.frame.size.height-3, 145, 30)];
    chineseLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"HotelCNName"];
    
    if (self.tag==1)
    {
        chineseLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"TicketCName"];
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        chineseLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"ShopCName"];
    }

     chineseLable.font=[UIFont systemFontOfSize:14];
    chineseLable.textColor=[UIColor grayColor];
    [button addSubview:chineseLable];
    
    UILabel*typeLable=[[UILabel alloc]initWithFrame:CGRectMake(3, chineseLable.frame.origin.y+chineseLable.frame.size.height-5, 145, 30)];
    typeLable.font=[UIFont systemFontOfSize:13];
    typeLable.text=str;
    
    if (self.tag==1)
    {
        typeLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"TicketClass"];
    }

    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        typeLable.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"ShopType"];
    }

    
    typeLable.textColor=[UIColor grayColor];
    [button addSubview:typeLable];
   
    
    RTLabel*_price=[[RTLabel alloc]initWithFrame:CGRectMake(145,typeLable.frame.origin.y+5, 0, 30)];
    _price.text=[NSString stringWithFormat:@"<font size=15 color=orange>¥%d</font>起", [[[_dataArray objectAtIndex:indexPath]valueForKey:@"LPrice"]integerValue]] ;
    if (self.tag==1)
    {
       _price.text=[NSString stringWithFormat:@"<font size=15 color=orange>¥%d</font>起", [[[_dataArray objectAtIndex:indexPath]valueForKey:@"UDPrice"]integerValue]] ;
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        _price.text=@"";
    }

    
    _price.textColor=[UIColor orangeColor];
    CGSize size=[_price optimumSize];
    _price.frame=CGRectMake(145-size.width-4,typeLable.frame.origin.y+5, size.width, 30);
    [button addSubview:_price];
    
    button.backgroundColor=[UIColor whiteColor];
    button.frame=CGRectMake(10+index*155, 10, 145, typeLable.frame.origin.y+typeLable.frame.size.height+5);
    

   

    
    return button;



}
-(void)tttt:(UIButton*)sender
{
    
    
    if (sender.tag>=100&&sender.tag<=100+array.count-1)
    {
        sendTag=sender.tag;
         UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+30];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];

        
        for (int i=1; i<array.count; i++)
        {
            UIButton*button=(UIButton*)[self.view viewWithTag:(sender.tag-100+i)%array.count+100];
            [button setBackgroundImage:[UIImage imageNamed:@"leftSelect"] forState:UIControlStateNormal];
            UILabel*lable2=(UILabel*)[self.view viewWithTag:(sender.tag-100+i)%array.count+100+30];
            lable2.textColor=[UIColor blackColor];
            
            
        }
    }
    
    if (sender.tag>=10000)
    {
        [self pushNext:sender.tag-10000 andArray:dataArray andIndexPath:nil];
    }
      switch (sender.tag)
    {
        case 100:
        {
           
          [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"])
            {
                
                [SelectPrice removeFromSuperview];
                [SelectData removeFromSuperview];
                [SelectType removeFromSuperview];
                [filterView addSubview:SelectPlace];
                
            }
            else if([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                [SelectPrice removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectCountry removeFromSuperview];
                 [SelectSex removeFromSuperview];
                [SelectSkilled removeFromSuperview];
                 [SelectData removeFromSuperview];
                
                [filterView addSubview:SelectType];
                
            }
            else if([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                [SelectPrice removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectCountry removeFromSuperview];
                [SelectSex removeFromSuperview];
                [SelectSkilled removeFromSuperview];
                [SelectData removeFromSuperview];
                [SelectTranslateSkilled removeFromSuperview];
                [filterView addSubview:SelectType];
                
            }


            else
            {
                
                
                [filterView addSubview:SelectType];
                [SelectPrice removeFromSuperview];
                 [SelectPlace removeFromSuperview];
               
                [SelectData removeFromSuperview];
                
            }

            

        }
            break;
        case 101:
        {
            
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"])
            {
                
                [SelectPrice removeFromSuperview];
                [SelectData removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [filterView addSubview:SelectType];
            }
            
             else if([self.navName isEqualToString:@"圣彼得堡租车"])
             {
                 [SelectPrice removeFromSuperview];
                 [SelectSkilled removeFromSuperview];
                 [SelectType removeFromSuperview];
                 [SelectSex removeFromSuperview];
                  [SelectData removeFromSuperview];
                 [SelectCountry removeFromSuperview];
                 [filterView addSubview:SelectPlace];
             
             }
             else if([self.navName isEqualToString:@"圣彼得堡导游"])
             {
                 [SelectPrice removeFromSuperview];
                 [SelectPlace removeFromSuperview];
                 [SelectType removeFromSuperview];
                 [SelectSex removeFromSuperview];
                 [SelectSkilled removeFromSuperview];
                 [SelectData removeFromSuperview];
                 [SelectTranslateSkilled removeFromSuperview];
                 [filterView addSubview:SelectCountry];
                 
             }

            else
            {
                
                
                [SelectType removeFromSuperview];
                [SelectPrice removeFromSuperview];
                
                [filterView addSubview:SelectData];
                
            }

            
            
        }
            break;
        case 102:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
             [SelectType removeFromSuperview];
            if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡餐厅"])
            {
               

                 [SelectPlace removeFromSuperview];
                [filterView addSubview:SelectPrice];
            }
            else if([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                [SelectPrice removeFromSuperview];
                [SelectSkilled removeFromSuperview];
                [SelectType removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectSex removeFromSuperview];
                 [SelectData removeFromSuperview];
                [filterView addSubview:SelectCountry];
                
            }
             else  if([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                [SelectPrice removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectType removeFromSuperview];
                [SelectCountry removeFromSuperview];
                [SelectSkilled removeFromSuperview];
                [SelectData removeFromSuperview];
                [SelectTranslateSkilled removeFromSuperview];
                [filterView addSubview:SelectSex];
                
            }

            
            else
            {
            
                
                [SelectData removeFromSuperview];
                [filterView addSubview:SelectPrice];
            
            }
           
            
        
        }
            break;
        case 103:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
             if([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                [SelectPrice removeFromSuperview];
                [SelectSkilled removeFromSuperview];
                [SelectType removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectCountry removeFromSuperview];
                 [SelectData removeFromSuperview];
                
                [filterView addSubview:SelectSex];
                
            }
             else  if([self.navName isEqualToString:@"圣彼得堡导游"])
             {
                 [SelectSex removeFromSuperview];
                 [SelectPlace removeFromSuperview];
                 [SelectType removeFromSuperview];
                 [SelectCountry removeFromSuperview];
                 [SelectSkilled removeFromSuperview];
                 [SelectData removeFromSuperview];
                 [SelectTranslateSkilled removeFromSuperview];
                 [filterView addSubview:SelectPrice];
                 
             }

            else
            {
            
                [SelectType removeFromSuperview];
                [SelectData removeFromSuperview];
                [filterView addSubview:SelectPrice];
                [SelectPlace removeFromSuperview];
            
            }

            
        }
            break;

            
        case 104:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
           [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            if([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                [SelectSex removeFromSuperview];
               [SelectSkilled removeFromSuperview];                [SelectType removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectCountry removeFromSuperview];
                 [SelectData removeFromSuperview];
                
                [filterView addSubview:SelectPrice];
                
            }
            else
                
            {
                [SelectSex removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectType removeFromSuperview];
                [SelectCountry removeFromSuperview];
                [SelectPrice removeFromSuperview];
                [SelectData removeFromSuperview];
                [SelectTranslateSkilled removeFromSuperview];
                [filterView addSubview:SelectSkilled];
                
            }

            
            
        }
            break;
        case 105:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            if([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                [SelectSex removeFromSuperview];
                [SelectPrice removeFromSuperview];
                [SelectType removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectCountry removeFromSuperview];
                 [SelectData removeFromSuperview];
                [filterView addSubview:SelectSkilled];
                
            }
            else
                
            {
                [SelectSex removeFromSuperview];
                [SelectPlace removeFromSuperview];
                [SelectType removeFromSuperview];
                [SelectCountry removeFromSuperview];
                [SelectPrice removeFromSuperview];
                [SelectData removeFromSuperview];
                [SelectSkilled removeFromSuperview];
                [filterView addSubview:SelectTranslateSkilled];
                
            }

            
            
        }
            break;
        case 150:
        {
//            CalenderViewController*calendarController=[CalenderViewController new];
//           
//            calendarController.TapCount=2;
//            calendarController.tag=1;
//            [calendarController setDelegate:self];
//            //        [calendarController.navigationItem setHidesBackButton:YES];
//            calendarController.fromDate=self.FromDate;
//            calendarController.toDate=self.ToDate;
//            [calendarController setBeginDate:[NSDate date]];
//            [calendarController setEndDate:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24*30]];
//            //    [calendarController setFromDate:fromDate];
//            //    [calendarController setToDate:toDate];
//            [self.navigationController pushViewController:calendarController animated:NO];
            
            
        }
            break;
        case 151:
        {
            
            RTLabel*lable=(RTLabel*)[self.view viewWithTag:63];
            NSLog(@"length=====%d",lable.text.length);
            if (lable.text.length!=30)
            {
//                CalenderViewController*calendarController=[CalenderViewController new];
//                
//                calendarController.TapCount=2;
//                calendarController.tag=1;
//                [calendarController setDelegate:self];
//                //        [calendarController.navigationItem setHidesBackButton:YES];
//                calendarController.fromDate=self.FromDate;
//                calendarController.toDate=self.ToDate;
//                [calendarController setBeginDate:[NSDate date]];
//                [calendarController setEndDate:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24*30]];
//                //    [calendarController setFromDate:fromDate];
//                //    [calendarController setToDate:toDate];
//                [self.navigationController pushViewController:calendarController animated:NO];
            }
            
          
            
            
        }
            break;

            
        default:
            break;
    }
       NSLog(@"~~~~~~~~~~~~");
      BOOL is=[_tabView touchesShouldCancelInContentView:sender];
    NSLog(@"is===%d",is);
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
  
    if([view isKindOfClass:[UIButton class]])
    {
        NSLog(@"view==%@",view);
        return YES;
      
    }
    else
    {
         NSLog(@"view==%@",view);
     return NO;
    }
}
#pragma mark -
- (void)CalenderViewControllerDidFinishedFromDate:(NSDate*)_fromDate toDate:(NSDate*)_toDate
{
  
    self.FromDate=_fromDate;
    self.ToDate=_toDate;
    NSDateFormatter *dayFormatter = [NSDateFormatter new];
    dayFormatter.dateFormat = @"yyyy-LL-d ccc";
    NSString *title1 = [dayFormatter stringFromDate:_fromDate];
//    [dayFormatter release];
    RTLabel*lable=(RTLabel*)[self.view viewWithTag:160];
    lable.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",title1];
    
    
    
    NSString *title2 =@"";
    if (_toDate)
    {
        dayFormatter = [NSDateFormatter new];
        dayFormatter.dateFormat = @"yyyy-LL-d ccc";
        title2 = [dayFormatter stringFromDate:_toDate];
//        [dayFormatter release];
    }
    
   
    if (title2 && title2.length > 0)
    {
        RTLabel*lable=(RTLabel*)[self.view viewWithTag:161];
        lable.text=[NSString stringWithFormat:@"<font color=gray>到</font> %@",title2];
    }
//       dayFormatter.dateFormat = @"yyyy-LL-d";
      oldEndData = [dayFormatter stringFromDate:_toDate];
      oldStartData = [dayFormatter stringFromDate:_fromDate];
   
   }

-(void)creatFilter
{
   
    filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 520)];
    UIImageView*imageAngel=[[UIImageView alloc]initWithFrame:CGRectMake(288, -7, 10, 7)];
    imageAngel.image=[UIImage imageNamed:@"entainmentAngel.png"];
    [filterView addSubview:imageAngel];
filterView.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
    filterView.hidden=YES;
    filterView.tag=3;
    [self.view addSubview:filterView];
    
    UIView *iv = [[UIView alloc]initWithFrame:CGRectMake(0, 326, 320, 200)];
    
    [filterView addSubview:iv];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenFilterView)];
    [iv addGestureRecognizer:tap];
    
    UIImageView*leftView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 276)];
    leftView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lineGray3.png"]];
    leftView.userInteractionEnabled = YES;

    [filterView addSubview:leftView];
    
    UIImageView*bottom=[[UIImageView alloc]initWithFrame:CGRectMake(0, 276, 320, 50)];
    bottom.userInteractionEnabled=YES;
     bottom.backgroundColor=[UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    UIView*bottomBlue=[[UIView alloc]initWithFrame:CGRectMake(0, 46, 320, 4)];
  bottomBlue.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    [bottom addSubview:bottomBlue];
    for (int i=0; i<2; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
         [button addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius=4;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag=110+i;
        button.frame=CGRectMake(100+i*150, 10, 59, 25);
        if (i==0)
        {
            button.backgroundColor=[UIColor grayColor];
            [button setTitle:@"清空" forState:UIControlStateNormal];
        }
        if (i==1)
        {
            button.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
            [button setTitle:@"确定" forState:UIControlStateNormal];
        }

        [bottom addSubview:button];
    }
    
    [filterView addSubview:bottom];
    
   
    if ([self.navName isEqualToString:@"圣彼得堡娱乐"])
    {
        array=[NSArray arrayWithObjects:@"选择类型",@"日期范围",@"价格范围", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
        array=[NSArray arrayWithObjects:@"选择区域",@"选择类型",@"价格范围", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
         array=[NSArray arrayWithObjects:@"选择区域",@"选择菜系",@"人均消费", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"])
    {
        array=[NSArray arrayWithObjects:@"选择区域",@"选择类型",nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
        array=[NSArray arrayWithObjects:@"选择车型",@"选择座位",@"选择国籍",@"选择性别",@"价格范围",@"擅长讲解",nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
        array=[NSArray arrayWithObjects:@"选择类型",@"选择国籍",@"选择性别",@"价格范围",@"擅长讲解",@"擅长翻译",nil];
    }


    for (int i=0; i<array.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=100+i;
        button.frame=CGRectMake(0, 0+46*i, 100, 46);
        [button addTarget:self action:@selector(tttt:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:button];
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 46)];
        lable.tag=130+i;
        lable.text=[array objectAtIndex:i];
        lable.font=[UIFont boldSystemFontOfSize:17];
        lable.textAlignment=NSTextAlignmentCenter;
        [button addSubview:lable];
        
        if (i!=0)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"leftSelect"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            button.backgroundColor=[UIColor whiteColor];
        }
        
        
    }
    UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(99.5, 92, .5, 184)];
    rightLine.image = [UIImage imageNamed:@"lineGray2"];
    [leftView addSubview:rightLine];



}
- (void)hiddenFilterView{
    filterView.hidden = YES;
}
-(void)filter:(UIButton*)sender
{
    NSLog(@"sender.tag==%d",sender.tag);
    if (sender.tag==111)
    {
        NSLog(@"linetypeArray========%d",oldArearArray.count);
        arear=[NSMutableString stringWithString:@""];
        arearArray=[NSMutableArray new];
        arearArray=[NSMutableArray arrayWithArray:oldArearArray];
        
        star=[NSMutableString stringWithString:@""];
        starArray=[NSMutableArray new];
        starArray=[NSMutableArray arrayWithArray:oldStarArray];
        
        SkilledStr=[NSMutableString stringWithString:@""];
        SkilledArray=[NSMutableArray new];
        SkilledArray=[NSMutableArray arrayWithArray:oldSkilledArray];
        
        
        TranslateStr=[NSMutableString stringWithString:@""];
        TranslateArray=[NSMutableArray new];
        TranslateArray=[NSMutableArray arrayWithArray:oldTranslateArray];
        
        for (int i=0; i<arearArray.count; i++)
            {
                NSLog(@"--------");
                if (i!=arearArray.count-1)
                {
                    [arear appendFormat:@"%@,",[[arearArray objectAtIndex:i] stringValue]];
                }
                else
                {
                    [arear appendFormat:@"%@",[[arearArray objectAtIndex:i] stringValue]];
                    
                }
            }
      
        for (int i=0; i<starArray.count; i++)
        {
            NSLog(@"--------");
            if (i!=starArray.count-1)
            {
                    [star appendFormat:@"%@,",[starArray objectAtIndex:i] ];
                
            }
            else
            {
               
                
                [star appendFormat:@"%@",[starArray objectAtIndex:i] ];
              

              
                
            }
        }

        
        for (int i=0; i<SkilledArray.count; i++)
        {
            NSLog(@"--------");
            if (i!=SkilledArray.count-1)
            {
                [SkilledStr appendFormat:@"%@,",[SkilledArray objectAtIndex:i]];
            }
            else
            {
                [SkilledStr appendFormat:@"%@",[SkilledArray objectAtIndex:i]];
                
            }
        }

        for (int i=0; i<TranslateArray.count; i++)
        {
            NSLog(@"--------");
            if (i!=TranslateArray.count-1)
            {
                [TranslateStr appendFormat:@"%@,",[TranslateArray objectAtIndex:i]];
            }
            else
            {
                [TranslateStr appendFormat:@"%@",[TranslateArray objectAtIndex:i]];
                
            }
        }

        
       
        lowprice=oldLowprice;
        higprice=oldHigprice;
        Country=oldCountry;
        Sex=oldSex;
        
        startData=oldStartData;
        endData=oldEndData;
        NSString*startStr=@"";
        NSString*endStr=@"";
        if (![oldStartData isEqualToString:@""])
        {
            startStr=[[startData componentsSeparatedByString:@" "] objectAtIndex:0];
            endStr=[[endData componentsSeparatedByString:@" "] objectAtIndex:0];
        }
        index1=0;
        NSLog(@"Sex===%d",Sex);
        NSLog(@"Country===%d",Country);
        NSLog(@"TranslateStr===%@",TranslateStr);

        
        [self refreshDataIndex:index1 andIsRefreshBody:YES andIsRefreshHead:NO andAnimal:YES];
        isFilter=YES;

        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
        imageView.image=[UIImage imageNamed:@"001.png"];
        
        filterView.hidden=YES;
    }
    if (sender.tag==110)
    {
        if (sendTag==101)
        {
            if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"]||[self.navName isEqualToString:@"圣彼得堡租车"])
            {
                star=[NSMutableString stringWithString:@""];
                oldStarArray=[NSMutableArray new];
                [self clearAll:260 andCount:10];
            }
            if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
            {
                star=[NSMutableString stringWithString:@""];
                oldStarArray=[NSMutableArray new];
                [self clearAll:260 andCount:10];
            }
            
            if (self.tag==1)
            {
                oldStartData=@"";
                oldEndData=@"";
                self.FromDate=nil;
                self.ToDate=nil;
                RTLabel*lable=(RTLabel*)[self.view viewWithTag:160];
                RTLabel*lable11=(RTLabel*)[self.view viewWithTag:161];
                lable.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",@"选择日期"];
               lable11.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",@"选择日期"];
                    
                    
                
                

            }
            if ([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                arear=[NSMutableString stringWithString:@""];
                oldArearArray=[NSMutableArray new];
                [self clearAll:60 andCount:6];
            }
            if ([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                oldCountry=0;
                [self clearAll:3360 andCount:3];
            }

            
        }
        
        if (sendTag==102)
        {
            if ([self.navName isEqualToString:@"圣彼得堡租车"])
            {
                oldCountry=0;
                  [self clearAll:3360 andCount:3];
            }
            else  if ([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                oldSex=0;
                [self clearAll:2260 andCount:3];
            }

            else
            {
            oldLowprice=0;
            oldHigprice=0;
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
            UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
            lable1.text=[NSString stringWithFormat:@"¥0"];
            lable2.text=[NSString stringWithFormat:@"不限"];
            
            NMRangeSlider*_slider=(NMRangeSlider*)[self.view viewWithTag:700];
            [_slider setLowerValue:0 upperValue:20000 animated:YES];
            }
            
        }
        if (sendTag==103)
        {
           
            if ([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                oldLowprice=0;
                oldHigprice=0;
                
                UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
                UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
                lable1.text=[NSString stringWithFormat:@"¥0"];
                lable2.text=[NSString stringWithFormat:@"不限"];
                
                NMRangeSlider*_slider=(NMRangeSlider*)[self.view viewWithTag:700];
                [_slider setLowerValue:0 upperValue:20000 animated:YES];

            }
            else
            {
                oldSex=0;
                [self clearAll:2260 andCount:3];
            
            }

        }
        if (sendTag==104)
        {
            if ([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                SkilledStr=[NSMutableString stringWithString:@""];
                oldSkilledArray=[NSMutableArray new];
                [self clearAll:1360 andCount:10];

            }
            else
            {
            oldLowprice=0;
            oldHigprice=0;
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
            UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
            lable1.text=[NSString stringWithFormat:@"¥0"];
            lable2.text=[NSString stringWithFormat:@"不限"];
            
            NMRangeSlider*_slider=(NMRangeSlider*)[self.view viewWithTag:700];
            [_slider setLowerValue:0 upperValue:20000 animated:YES];
            }

        }
        if (sendTag==105)
        {
            if ([self.navName isEqualToString:@"圣彼得堡导游"])
            {
                TranslateStr=[NSMutableString stringWithString:@""];
                oldTranslateArray=[NSMutableArray new];
                [self clearAll:1460 andCount:10];
                
            }
            else
            {
            SkilledStr=[NSMutableString stringWithString:@""];
            oldSkilledArray=[NSMutableArray new];
            [self clearAll:1360 andCount:10];
            }
        }

        
        if (sendTag==100)
        {
            if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"])
            {
                UIImageView*imageView=(UIImageView*)[self.view viewWithTag:80];
                imageView.image=[UIImage imageNamed:@"pitchUp.png"];
                UILabel*lable=(UILabel*)[self.view viewWithTag:60];
                 lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
                UILabel*lablee=(UILabel*)[self.view viewWithTag:70];
                lablee.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
                
                
                for (int i=1; i<arrayType.count; i++)
                {
                    UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:i%(arrayType.count)+80];
                    imageView1.image=[UIImage imageNamed:@""];
                    
                    UILabel*lable1=(UILabel*)[self.view viewWithTag:i%(arrayType.count)+60];
                    lable1.textColor=[UIColor blackColor];
                    UILabel*lable11=(UILabel*)[self.view viewWithTag:i%(arrayType.count)+70];
                    lable11.textColor=[UIColor blackColor];
                    
                }
                
                arear=[NSMutableString stringWithString:@""];
                oldArearArray=[NSMutableArray new];

            }
            if (self.tag==1||[self.navName isEqualToString:@"圣彼得堡租车"]||[self.navName isEqualToString:@"圣彼得堡导游"])
            {
                [self clearAll:260 andCount:10];
                star=[NSMutableString stringWithString:@""];
                oldStarArray=[NSMutableArray new];

            }
            
        

        }
    }
    
}
#pragma mark--清除
-(void)clearAll:(int)tag andCount:(int)count
{

    UILabel*lable=(UILabel*)[self.view viewWithTag:tag];
     lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    UIImageView*imageView;
//    =(UIImageView*)[self.view viewWithTag:tag+10];
    if ([self.navName isEqualToString:@"圣彼得堡租车"]&&sendTag==101)
    {
        imageView=(UIImageView*)[self.view viewWithTag:tag+20];
    }
    else
    {
    
        imageView=(UIImageView*)[self.view viewWithTag:tag+10];
    }
    imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    
    for (int i=1; i<count; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:i+tag];
        lable1.textColor=[UIColor blackColor];
        
        UIImageView*imageView2;
    
        if ([self.navName isEqualToString:@"圣彼得堡租车"]&&sendTag==101)
        {
            imageView2=(UIImageView*)[self.view viewWithTag:i+tag+20];
        }

        else
        {
            imageView2=(UIImageView*)[self.view viewWithTag:i+tag+10];
        
        }
        imageView2.image=[UIImage imageNamed:@""];
        
    }
    


}
-(void)creatSelectPrice
{
    SelectPrice=[[UIView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    SelectPrice.backgroundColor = [UIColor whiteColor];
    slider=[[NMRangeSlider alloc]initWithFrame:CGRectMake(10, 60, 200, 20)];
    //     _slider =  [[RangeSlider alloc] initWithFrame:CGRectMake(73, 18, 228, 40)];
    [slider addTarget:self action:@selector(progress:)  forControlEvents:UIControlEventValueChanged ];
    [SelectPrice addSubview:slider];
    
    //    UISlider
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"line_trackGray.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"line_trackBlue.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"line_circle.png"];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"line_circle.png"];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
    
    slider.minimumRange=2000;
    slider.minimumValue=0;
    slider.maximumValue=20000;
    slider.upperValue=20000;
    slider.lowerValue=0;
    slider.stepValue=2000;
    slider.continuous=NO;
    slider.tag = 700 ;
    
    UILabel*lowPrice=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20) ];
    [SelectPrice addSubview:lowPrice];
    lowPrice.tag=201;
    lowPrice.text=@"¥0";
    lowPrice.textColor=[UIColor blueColor];
    lowPrice.font=[UIFont systemFontOfSize:15];
    
    UILabel*upperPrice=[[UILabel alloc]initWithFrame:CGRectMake(160, 20, 80, 20) ];
    [SelectPrice addSubview:upperPrice];
    upperPrice.text=@"不限";
    upperPrice.tag=202;
    upperPrice.textColor=[UIColor blueColor];
    upperPrice.font=[UIFont systemFontOfSize:15];
}
-(void)progress:(NMRangeSlider*)sender
{
    UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
    UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
    lable1.text=[NSString stringWithFormat:@"¥%d",(int)sender.lowerValue];
    lable2.text=[NSString stringWithFormat:@"¥%d",(int)sender.upperValue];
    
    
    oldLowprice=(int)sender.lowerValue;
    oldHigprice=(int)sender.upperValue;
    if (sender.upperValue==20000.0)
    {
        lable2.text=@"不限";
        oldHigprice=0;
    }
    
}
-(void)creatSelectCountry
{
    NSArray*arrayday=[NSArray arrayWithObjects:@"全部",@"俄罗斯籍",@"中国籍", nil];
    //    }
    
    SelectCountry=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    SelectCountry.backgroundColor = [UIColor whiteColor];
    float f=0;
    
    for (int i=0; i<arrayday.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=3350+i;
        [button addTarget:self action:@selector(chooseCountry:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 46)];
        lable.tag=3360+i;
        if (i==0)
        {
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        }
        lable.text=[arrayday objectAtIndex:i];
        [button addSubview:lable];
        
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=3370+i;
        if (i==0)
        {
            select.image=[UIImage imageNamed:@"pitchUp.png"];
        }
        
        [button addSubview:select];
        
        
        [SelectCountry addSubview:button];
        
        
        
       
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
        
        f+=button.frame.size.height;
        
    }
    SelectCountry.contentSize=CGSizeMake(220, f+20);
    
    
}
-(void)chooseCountry:(UIButton*)sender
{
    
    oldCountry=sender.tag-3350;
    UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
     lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
    imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    
    for (int i=1; i<6; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-3350+i)%6+3360];
        lable1.textColor=[UIColor blackColor];
        
        UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:(sender.tag-3350+i)%6+3370];
        imageView2.image=[UIImage imageNamed:@""];
        
    }
    
    
    
    
}



-(void)creatSelectSeX
{
    NSArray*arrayday=[NSArray arrayWithObjects:@"全部",@"男",@"女", nil];
    //    }
  
    SelectSex=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    SelectSex.backgroundColor = [UIColor whiteColor];
    float f=0;
    for (int i=0; i<arrayday.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=2250+i;
        [button addTarget:self action:@selector(chooseSeX:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 46)];
        lable.tag=2260+i;
        if (i==0)
        {
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        }
        lable.text=[arrayday objectAtIndex:i];
        [button addSubview:lable];
        
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=2270+i;
        if (i==0)
        {
            
            select.image=[UIImage imageNamed:@"pitchUp.png"];
        }
        
        [button addSubview:select];
        
        
        [SelectSex addSubview:button];
        
        
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
        f+=button.frame.size.height;
        
    }
    SelectSex.contentSize=CGSizeMake(220, f+20);
    
    
}
-(void)chooseSeX:(UIButton*)sender
{
    
    oldSex=sender.tag-2250;
    UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
     lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
    imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    
    for (int i=1; i<6; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-2250+i)%6+2260];
        lable1.textColor=[UIColor blackColor];
        
        UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:(sender.tag-2250+i)%6+2270];
        imageView2.image=[UIImage imageNamed:@""];
        
    }
    
    
    
    
}



-(void)creatSelectType
{
  
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部类型",@"青年旅舍",@"二星/自主",@"三星/经济",@"四星/舒适",@"五星/豪华",@"家庭式公寓",@"别墅",@"其他", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡娱乐"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部",@"芭蕾舞剧",@"话剧",@"歌剧",@"音乐会",@"游船",@"大马戏",@"其他", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部",@"中餐",@"俄餐",@"西餐",@"日餐 ",@"高加索餐",@"快餐",@"咖啡厅",@"其他", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部类型",@"综合百货商店",@"商业街/商业中心",@"超市",@"特产/纪念品店",@"食品酒水/特色小吃",@"其他", nil];
    }
    if ([self.navName isEqualToString:@"景点列表"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部类型",@"教堂",@"博物馆",@"宫殿",@"剧院",@"学校",@"广场花园",@"自然保护区",@"其他", nil];
    }
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部",@"小型轿车",@"SUV车",@"MVP车",@"其他", nil];
    }

    if ([self.navName isEqualToString:@"圣彼得堡导游"])
    {
        _arrayType=[NSArray arrayWithObjects:@"全部",@"导游",@"车兼导(租车)",@"导游兼翻译",@"导游兼翻译(带车)", nil];
    }


    SelectType=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    float f=0;
    for (int i=0; i<_arrayType.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=250+i;
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        button.backgroundColor = [UIColor whiteColor];
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 20, 20)];
        select.tag=270+i;
        
        [button addSubview:select];

        [button addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 46)];
        lable.tag=260+i;
        lable.text=[_arrayType objectAtIndex:i];
        [button addSubview:lable];
        if (i==0)
        {
            select.image=[UIImage imageNamed:@"pitchUp.png"];
           lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
          
            
        }

        
        [SelectType addSubview:button];
      
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
       
        f+=button.frame.size.height;
        
    }
    SelectType.contentSize=CGSizeMake(220, f+20);
    SelectType.backgroundColor = [UIColor whiteColor];
    if ([self.navName isEqualToString:@"圣彼得堡娱乐"]||[self.navName isEqualToString:@"圣彼得堡租车"]||[self.navName isEqualToString:@"圣彼得堡导游"])
    {
         [filterView addSubview:SelectType];
    }
    


}


-(void)chooseType:(UIButton*)sender
{
    
    if (sender.tag==250)
    {
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        UILabel*lable=(UILabel*)[self.view viewWithTag:260];
       lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        
        for (int i=1; i<6; i++)
        {
            UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:(sender.tag-250+i)%6+270];
            imageView1.image=[UIImage imageNamed:@""];
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-250+i)%6+260];
            lable1.textColor=[UIColor blackColor];
            
        }
        
        star=[NSMutableString stringWithString:@""];
        oldStarArray=[NSMutableArray new];
    }
    else
    {
        UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:270];
        imageView1.image=[UIImage imageNamed:@""];
        
        UILabel*lable1=(UILabel*)[self.view viewWithTag:260];
        lable1.textColor=[UIColor blackColor];
        
        
        
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
        
        
        
        if (  imageView.image==[UIImage imageNamed:@"pitchUp.png"])
        {
            if (oldStarArray.count>1)
            {
                imageView.image=[UIImage imageNamed:@""];
                if ([self.navName isEqualToString:@"圣彼得堡住宿"])
                {
                     [oldStarArray removeObject:[NSNumber numberWithInt:(sender.tag-250)]];
                }
                if (self.tag==1||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"]||[self.navName isEqualToString:@"圣彼得堡租车"]||[self.navName isEqualToString:@"圣彼得堡导游"])
                {
                     [oldStarArray removeObject:[_arrayType objectAtIndex:sender.tag-250]];
                }
               
                lable.textColor=[UIColor blackColor];
                
            }
        }
        else
        {
            if (oldStarArray.count<6)
            {
                imageView.image=[UIImage imageNamed:@"pitchUp.png"];
                if ([self.navName isEqualToString:@"圣彼得堡住宿"])
                {
                [oldStarArray addObject:[NSNumber numberWithInt:(sender.tag-250)]];
                }
                if (self.tag==1||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"]||[self.navName isEqualToString:@"圣彼得堡租车"]||[self.navName isEqualToString:@"圣彼得堡导游"])
                {
                    [oldStarArray addObject:[_arrayType objectAtIndex:sender.tag-250]];
                }

                
                 lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
        }
        
        
    }
  
    
}
-(void)creatSelectSkilled
{

    _arrayType2=[NSArray arrayWithObjects:@"全部",@"民俗/艺术",@"历史/文化",@"宗教/人文", nil];
    SelectSkilled=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    SelectSkilled.backgroundColor = [UIColor whiteColor];
    float f=0;
    for (int i=0; i<_arrayType2.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=1350+i;
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=1370+i;
        
        [button addSubview:select];
        
        [button addTarget:self action:@selector(chooseSkilled:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 46)];
        lable.tag=1360+i;
        lable.text=[_arrayType2 objectAtIndex:i];
        [button addSubview:lable];
        if (i==0)
        {
            select.image=[UIImage imageNamed:@"pitchUp.png"];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            
            
        }
        
        
        [SelectSkilled addSubview:button];
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
        f+=button.frame.size.height;
        
    }
    SelectSkilled.contentSize=CGSizeMake(220, f+20);
    
    
}

-(void)chooseSkilled:(UIButton*)sender
{
    
    if (sender.tag==1350)
    {
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1370];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        UILabel*lable=(UILabel*)[self.view viewWithTag:1360];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        
        for (int i=1; i<6; i++)
        {
            UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:(sender.tag-1350+i)%6+1370];
            imageView1.image=[UIImage imageNamed:@""];
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-1350+i)%6+1360];
            lable1.textColor=[UIColor blackColor];
            
        }
        
        SkilledStr=[NSMutableString stringWithString:@""];
        oldSkilledArray=[NSMutableArray new];
    }
    else
    {
        UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:1370];
        imageView1.image=[UIImage imageNamed:@""];
        
        UILabel*lable1=(UILabel*)[self.view viewWithTag:1360];
        lable1.textColor=[UIColor blackColor];
        
        
        
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
        
        
        
        if (  imageView.image==[UIImage imageNamed:@"pitchUp.png"])
        {
            if (oldSkilledArray.count>1)
            {
                imageView.image=[UIImage imageNamed:@""];
                 [oldSkilledArray removeObject:[_arrayType2 objectAtIndex:sender.tag-1350]];
                
                lable.textColor=[UIColor blackColor];
                
            }
        }
        else
        {
            if (oldSkilledArray.count<6)
            {
                imageView.image=[UIImage imageNamed:@"pitchUp.png"];
                [oldSkilledArray addObject:[_arrayType2 objectAtIndex:sender.tag-1350]];
                
                
                
                lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
        }
        
        
    }
    
    
}
-(void)creatTranslateSkilled
{
    
    _arrayType3=[NSArray arrayWithObjects:@"全部",@"商务/贸易类",@"电子/电气类",@"能源/石油类",@"机械/工程类",@"医学/保健类",@"建筑/装潢类",@"法律/合同类",  nil];
    SelectTranslateSkilled=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    SelectTranslateSkilled.backgroundColor = [UIColor whiteColor];
    float f=0;
    for (int i=0; i<_arrayType3.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=1450+i;
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=1470+i;
        
        [button addSubview:select];
        
        [button addTarget:self action:@selector(chooseTranslate:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 46)];
        lable.tag=1460+i;
        lable.text=[_arrayType3 objectAtIndex:i];
        [button addSubview:lable];
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
        
        [SelectTranslateSkilled addSubview:button];
        UIImageView*imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView2.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView2];
        
        f+=button.frame.size.height;
        
    }
    SelectTranslateSkilled.contentSize=CGSizeMake(220, f+20);
    
    
}

-(void)chooseTranslate:(UIButton*)sender
{
    
    if (sender.tag==1450)
    {
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1470];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        UILabel*lable=(UILabel*)[self.view viewWithTag:1460];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        
        for (int i=1; i<8; i++)
        {
            UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:(sender.tag-1450+i)%8+1470];
            imageView1.image=[UIImage imageNamed:@""];
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-1450+i)%8+1460];
            lable1.textColor=[UIColor blackColor];
            
        }
        
        TranslateStr=[NSMutableString stringWithString:@""];
        oldTranslateArray=[NSMutableArray new];
    }
    else
    {
        UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:1470];
        imageView1.image=[UIImage imageNamed:@""];
        
        UILabel*lable1=(UILabel*)[self.view viewWithTag:1460];
        lable1.textColor=[UIColor blackColor];
        
        
        
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
        
        
        
        if (  imageView.image==[UIImage imageNamed:@"pitchUp.png"])
        {
            if (oldTranslateArray.count>1)
            {
                imageView.image=[UIImage imageNamed:@""];
                [oldTranslateArray removeObject:[_arrayType3 objectAtIndex:sender.tag-1450]];
                
                lable.textColor=[UIColor blackColor];
                
            }
        }
        else
        {
            if (oldTranslateArray.count<5)
            {
                imageView.image=[UIImage imageNamed:@"pitchUp.png"];
                [oldTranslateArray addObject:[_arrayType3 objectAtIndex:sender.tag-1450]];
                
                
                
                lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
        }
        
        
    }
    
    
}

-(void)creatSelectPlace
{
   
    if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"])
    {
        arrayType=[NSMutableArray arrayWithObjects: @"全部区域",@"中心区",@"瓦西里岛",@"海军部区",@"彼得宫城区",@"基洛夫区",@"普希金区",@"维堡区",  nil];
    }
    
  
    
    NSArray*russiaArray=[NSArray arrayWithObjects:@"",@"Центральный район",@"Васильевский остров",@"Петродворцовый район ",@"Адмиралтейский район",@"Кировский район",@"Пушкинский район ",@"Выборгский район", nil];
    
    if ([self.navName isEqualToString:@"圣彼得堡租车"])
    {
         arrayType=[NSMutableArray arrayWithObjects:@"全部",@"5人座",@"6人座",@"7人座",@"9人座",nil];
        russiaArray=[NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
    }
    
    SelectPlace=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 276)];
    SelectPlace.backgroundColor = [UIColor whiteColor];
    float f=0;
    for (int i=0; i<arrayType.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=50+i;
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
       // button.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [button addTarget:self action:@selector(choosePlace:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=80+i;
        
        [button addSubview:select];
        
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 8, 200, 15)];
        lable.tag=60+i;
        lable.font=[UIFont systemFontOfSize:17];
        lable.text=[arrayType objectAtIndex:i];
        [button addSubview:lable];
        UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(20, 23, 200, 15)];
        lable2.tag=70+i;
         lable2.font=[UIFont systemFontOfSize:16];
        lable2.text=[russiaArray objectAtIndex:i];
        [button addSubview:lable2];
        if (i==0)
        {
            select.image=[UIImage imageNamed:@"pitchUp.png"];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            lable.frame=CGRectMake(20, 0, 200, 46);
            
        }

        [SelectPlace addSubview:button];
       
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
        
        f+=button.frame.size.height;
        
    }
    SelectPlace.contentSize=CGSizeMake(220, f+20);
    if ([self.navName isEqualToString:@"圣彼得堡住宿"]||[self.navName isEqualToString:@"圣彼得堡餐厅"]||[self.navName isEqualToString:@"圣彼得堡购物"]||[self.navName isEqualToString:@"景点列表"])
    {
        [filterView addSubview:SelectPlace];
    }

    
    
}
-(void)choosePlace:(UIButton*)sender
{
    
    
    
    if (sender.tag==50)
    {
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:80];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        UILabel*lable=(UILabel*)[self.view viewWithTag:60];
       lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        UILabel*lable2=(UILabel*)[self.view viewWithTag:70];
        lable2.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];

        
        for (int i=1; i<arrayType.count; i++)
        {
            UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:(sender.tag-50+i)%(arrayType.count+1)+80];
            imageView1.image=[UIImage imageNamed:@""];
            
            UILabel*lable3=(UILabel*)[self.view viewWithTag:(sender.tag-50+i)%(arrayType.count)+60];
            lable3.textColor=[UIColor blackColor];
            
            UILabel*lable4=(UILabel*)[self.view viewWithTag:(sender.tag-50+i)%(arrayType.count)+70];
            lable4.textColor=[UIColor blackColor];
            
        }
        
        arear=[NSMutableString stringWithString:@""];
        oldArearArray=[NSMutableArray new];
    }
    else
    {
        int number=0;
        switch (sender.tag-50)
        {
            case 1:
                number=8;
                break;
            case 2:
                number=2;
                break;
            case 3:
                number=1;
                break;
            case 4:
                number=14;
                break;
            case 5:
                number=5;
                break;
            case 6:
                number=7;
                break;
            case 7:
                number=3;
                break;
                
            default:
                break;
        }

        
        UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:80];
        imageView1.image=[UIImage imageNamed:@""];
        
        UILabel*lable1=(UILabel*)[self.view viewWithTag:60];
        lable1.textColor=[UIColor blackColor];
        UILabel*lable11=(UILabel*)[self.view viewWithTag:70];
       lable11.textColor=[UIColor blackColor];

        
      
        
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+30];
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
        
        UILabel*lablee=(UILabel*)[self.view viewWithTag:sender.tag+20];
        
        if (  imageView.image==[UIImage imageNamed:@"pitchUp.png"])
        {
            if (oldArearArray.count>1)
            {
                if ([self.navName isEqualToString:@"圣彼得堡租车"])
                {
                    
                    [oldArearArray removeObject:[NSNumber numberWithInt:[[arrayType objectAtIndex:sender.tag-50] integerValue]]];
                }
                else
                {
                
                [oldArearArray removeObject:[NSNumber numberWithInt:number]];
                }
                imageView.image=[UIImage imageNamed:@""];
                lable.textColor=[UIColor blackColor];
                lablee.textColor=[UIColor blackColor];

            }
        }
        else
        {
            if (oldArearArray.count<6)
            {
                imageView.image=[UIImage imageNamed:@"pitchUp.png"];
                if ([self.navName isEqualToString:@"圣彼得堡租车"])
                {
                   
                     [oldArearArray addObject: [NSNumber numberWithInt:[[arrayType objectAtIndex:sender.tag-50] integerValue]]];
                }
                else
                {
                [oldArearArray addObject:[NSNumber numberWithInt:number]];
                }
               lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
               lablee.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
        }
        
        
    }

    
}

-(void)creatSelectData
{

    SelectData=[[UIView alloc]initWithFrame:CGRectMake(100, 0, 220, 280)];
    SelectData.backgroundColor = [UIColor whiteColor];
     NSArray*Array=[NSArray arrayWithObjects:@"<font color=gray>从</font> 选择日期",@"<font color=gray>到</font> 选择日期", nil];
    for (int i=0; i<2; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=150+i;
        [button addTarget:self action:@selector(tttt:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        UIImageView*data=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        data.image=[UIImage imageNamed:@"entainmentData.png"];
        [button addSubview:data];
        
        RTLabel*lable=[[RTLabel alloc]initWithFrame:CGRectMake(20, 0, 220, 0)];
        lable.tag=160+i;
        lable.userInteractionEnabled=NO;
        lable.text=[Array objectAtIndex:i];
        CGSize size=[lable optimumSize];
        lable.frame=CGRectMake(20, (46.0-size.height)/2, 220, size.height);
        [button addSubview:lable];
        [SelectData addSubview:button];
        
        
        
    }


  


}
-(void)creatSection
{

   
    NSArray*_array;
    
    if ([self.navName isEqualToString:@"圣彼得堡购物"])
    {
        _array=[NSArray arrayWithObjects:@"默认",@"喜欢",@"点评",@"筛选",nil];
    }
    else
    {
    
    
     _array=[NSArray arrayWithObjects:@"默认",@"喜欢",@"点评",@"价格",@"筛选",nil];
    
    }
    int a=0;
    for (int i=0; i<_array.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        //        button.backgroundColor=[UIColor blackColor];
        [button setImage:[UIImage imageNamed:@"sectionWhite.png"] forState:UIControlStateNormal];
   
        
        [button setImage:[UIImage imageNamed:@"sectionGray.png"] forState:UIControlStateHighlighted];
        
        if (i==0)
        {
            [button setImage:[UIImage imageNamed:@"sectionGray.png"] forState:UIControlStateNormal];
        }

        //        [button setBackgroundColor:[UIColor blackColor]];
        button.frame=CGRectMake(i*DeviceWidth/_array.count, 0, DeviceWidth/_array.count, 40);
      
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(27, 0, 30, 40)];
        lable.textColor=[UIColor grayColor];
        
         a=i;
        if ([self.navName isEqualToString:@"圣彼得堡购物"]&&i==3)
        {
            a=4;
        }
        //        lable.backgroundColor=[UIColor redColor];
        button.tag=10+a;
        //        lable.textColor=[UIColor whiteColor];
        lable.font=[UIFont systemFontOfSize:14];
        lable.tag=20+a;
        lable.text=[_array objectAtIndex:i];
        [button addSubview:lable];
        
        [button addTarget:self action:@selector(xiala:) forControlEvents:UIControlEventTouchUpInside];
        //        [button setImage:[UIImage imageNamed:@"more_ recomm.png"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        if (i==0||i==1||i==2)
        {
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(7, 11, 19,19)];
            imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"hotel_0%d",i+1]];
            [button addSubview:imageview];
            imageview.tag=30+i;
            
            if (i==0)
            {
                lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
//            if (i==2&&[self.navName isEqualToString:@"景点列表"])
//            {
//               imageview.image=[UIImage imageNamed:@"secenery_coment.png"];
//                lable.text=@"讲解";
//               
//            }

            
        }
        
        if (a==3)
        {
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(42, 10, 19, 19)];
            imageview.image=[UIImage imageNamed:@"price_03.png"];
            [button addSubview:imageview];
            imageview.tag=30+a;
            lable.frame=CGRectMake(15, 0, 30, 39);
            
        }
        
        if (a==4)
        {
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(44, 13, 11, 11)];
            imageview.image=[UIImage imageNamed:@"001.png"];
            [button addSubview:imageview];
            imageview.tag=30+a;
            lable.frame=CGRectMake(15, 0, 30, 39);
        }
        
        
    }
    
   


}
-(void)xiala:(UIButton*)sender
{
    UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
    lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    
    
    [sender setImage:[UIImage imageNamed:@"sectionGray.png"] forState:UIControlStateNormal];
    
    for (int i=1; i<5; i++)
    {
        UIButton*button=(UIButton*)[self.view viewWithTag:(sender.tag-10+i)%5+10];
        [button setImage:[UIImage imageNamed:@"sectionWhite.png"] forState:UIControlStateNormal];
    }

    
    
    isSave=sender.tag;
    for (int i=1; i<5; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-10+i)%5+20];
        lable1.textColor=[UIColor grayColor];
    }
    
     UIImageView*imageView=(UIImageView*)[self.view viewWithTag:33];
    if (sender.tag!=14)
    {
        if (sender.tag==10)
        {
            orderbystr=0;
        }
        if (sender.tag==11)
        {
            orderbystr=1;
        }
        if (sender.tag==12)
        {
            orderbystr=2;
        }
       
        if (sender.tag==13)
        {
            
            if (imageView.image==[UIImage imageNamed:@"price_04.png"])
            {
                imageView.image=[UIImage imageNamed:@"price_02.png"];
                orderbystr=4;
                
                
            }
            else
            {
                orderbystr=3;
                
                imageView.image=[UIImage imageNamed:@"price_04.png"];
                
            }
            
            
            
            
        }         index1=0;
     //   [picArray removeAllObjects];
        [self refreshDataIndex:index1 andIsRefreshBody:YES andIsRefreshHead:NO andAnimal:YES];
       
        if (filterView.hidden==NO)
        {
            filterView.hidden=YES;
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
            imageView.image=[UIImage imageNamed:@"001.png"];
           
            [self viewHidden];
            
        }
        
        
    }else{
        if (imageView.image==[UIImage imageNamed:@"price_02.png"])
        {
            imageView.image=[UIImage imageNamed:@"price_01.png"];
            
            
        }
        else if (imageView.image==[UIImage imageNamed:@"price_04.png"])
        {
            
            imageView.image=[UIImage imageNamed:@"price_03.png"];
            
        }
    }

    
    
    
    
    
    
    if (sender.tag==14)
    {
        if (filterView.hidden==YES)
        {
            filterView.hidden=NO;
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
            imageView.image=[UIImage imageNamed:@"002.png"];
            
        }
        
        else
        {
            
            filterView.hidden=YES;
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
            imageView.image=[UIImage imageNamed:@"001.png"];
            [self viewHidden];
            
        }
        
        
        
    }
    


}
-(void)viewHidden
{
    
    oldArearArray=[NSMutableArray new];
    oldArearArray=[NSMutableArray arrayWithArray:arearArray];
    
    for (int i=0; i<arrayType.count; i++)
    {
        UILabel*lable=(UILabel*)[self.view viewWithTag:60+i];
        UILabel*lable1=(UILabel*)[self.view viewWithTag:70+i];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:80+i];
        lable.textColor=[UIColor blackColor];
        lable1.textColor=[UIColor blackColor];
        imageView.image=[UIImage imageNamed:@""];
        
    }
    
    if (oldArearArray.count==0)
    {
        UILabel*lable=(UILabel*)[self.view viewWithTag:60];
        UILabel*lable1=(UILabel*)[self.view viewWithTag:70];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:80];
         lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
         lable1.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];

        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    }
    
    
    NSMutableArray*_array1=[NSMutableArray new];
    for (int i=1; i<6; i++)
    {
        [_array1 addObject:[NSNumber numberWithInt:i]];
    }
    for (int i=0; i<oldArearArray.count; i++)
    {
        int a=[_array1 indexOfObject:[oldArearArray objectAtIndex:i]];
        NSLog(@"a======%d",a);
        UILabel*lable=(UILabel*)[self.view viewWithTag:61+a];
         UILabel*lable2=(UILabel*)[self.view viewWithTag:71+a];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:81+a];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        lable2.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];

        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        
        
        
        
    }

    {
    oldSex=Sex;
    UILabel*lable=(UILabel*)[self.view viewWithTag:oldSex+2260];
    lable.textColor=[UIColor blueColor];
    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:oldSex+2270];
    imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    
    for (int i=1; i<6; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(oldSex+i)%6+2260];
        lable1.textColor=[UIColor blackColor];
        
        UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:(oldSex+i)%6+2270];
        imageView2.image=[UIImage imageNamed:@""];
        
    }

    }
    
    
   
    {
    
    
        oldCountry=Country;
        UILabel*lable=(UILabel*)[self.view viewWithTag:oldCountry+3360];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
       
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:oldCountry+3370];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        
        for (int i=1; i<6; i++)
        {
            UILabel*lable1=(UILabel*)[self.view viewWithTag:(oldCountry+i)%6+3360];
            lable1.textColor=[UIColor blackColor];
            
            UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:(oldCountry+i)%6+3370];
            imageView2.image=[UIImage imageNamed:@""];
            
        }

    
    }
    
    
    oldLowprice=lowprice;
    oldHigprice=higprice;

    
    UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
    UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
    lable1.text=[NSString stringWithFormat:@"¥%d",oldLowprice];
    lable2.text=[NSString stringWithFormat:@"¥%d",oldHigprice];
    
    NMRangeSlider*_slider=(NMRangeSlider*)[self.view viewWithTag:700];
    [_slider setLowerValue:oldLowprice upperValue:oldHigprice animated:YES];
    
    if (oldHigprice==0)
    {
        lable2.text=[NSString stringWithFormat:@"不限"];
        [_slider setLowerValue:oldLowprice upperValue:20000 animated:YES];
    }
    
    
    oldStarArray=[NSMutableArray new];
    oldStarArray=[NSMutableArray arrayWithArray:starArray];
    
    NSLog(@"oldStarArray===%d",oldStarArray.count);
    
    for (int i=0; i<6; i++)
    {
        UILabel*lable=(UILabel*)[self.view viewWithTag:260+i];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270+i];
        lable.textColor=[UIColor blackColor];
        imageView.image=[UIImage imageNamed:@""];
        
    }
    
    if (oldStarArray.count==0)
    {
        UILabel*lable=(UILabel*)[self.view viewWithTag:260];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    }
    
    
    NSMutableArray*_array=[NSMutableArray new];
    if ([self.navName isEqualToString:@"圣彼得堡住宿"])
    {
        for (int i=arrayType.count-1; i>0; i--)
        {
            [_array addObject:[NSNumber numberWithInt:i]];
        }

    }
    if (self.tag==1||[self.navName isEqualToString:@"圣彼得堡餐厅"])
    {
        for (int i=1; i<_arrayType.count; i++)
        {
            [_array addObject:[_arrayType objectAtIndex:i]];
        }

    }
    
    for (int i=0; i<oldStarArray.count; i++)
    {
        int a=[_array indexOfObject:[oldStarArray objectAtIndex:i]];
        NSLog(@"a======%d",a);
        UILabel*lable=(UILabel*)[self.view viewWithTag:261+a];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:271+a];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        
        
        
        
    }
    {
    
        oldSkilledArray=[NSMutableArray new];
        oldSkilledArray=[NSMutableArray arrayWithArray:SkilledArray];
        
        NSLog(@"oldStarArray===%d",oldStarArray.count);
        
        for (int i=0; i<6; i++)
        {
            UILabel*lable=(UILabel*)[self.view viewWithTag:1360+i];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1370+i];
            lable.textColor=[UIColor blackColor];
            imageView.image=[UIImage imageNamed:@""];
            
        }
        
        if (oldSkilledArray.count==0)
        {
            UILabel*lable=(UILabel*)[self.view viewWithTag:1360];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1370];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        }
        
        
        NSMutableArray*_array=[NSMutableArray new];
        for (int i=1; i<_arrayType2.count; i++)
        {
                [_array addObject:[_arrayType2 objectAtIndex:i]];
        }
            
        
        
        for (int i=0; i<oldSkilledArray.count; i++)
        {
            int a=[_array indexOfObject:[oldSkilledArray objectAtIndex:i]];
            NSLog(@"a======%d",a);
            UILabel*lable=(UILabel*)[self.view viewWithTag:1361+a];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1371+a];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            imageView.image=[UIImage imageNamed:@"pitchUp.png"];
            
            
            
            
        }

    
    }
    
    
    
    {
        
        oldTranslateArray=[NSMutableArray new];
        oldTranslateArray=[NSMutableArray arrayWithArray:TranslateArray];
        
        NSLog(@"oldStarArray===%d",oldStarArray.count);
        
        for (int i=0; i<8; i++)
        {
            UILabel*lable=(UILabel*)[self.view viewWithTag:1460+i];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1470+i];
            lable.textColor=[UIColor blackColor];
            imageView.image=[UIImage imageNamed:@""];
            
        }
        
        if (oldTranslateArray.count==0)
        {
            UILabel*lable=(UILabel*)[self.view viewWithTag:1460];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1470];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        }
        
        
        NSMutableArray*_array=[NSMutableArray new];
        for (int i=1; i<_arrayType3.count; i++)
        {
            [_array addObject:[_arrayType3 objectAtIndex:i]];
        }
        
        
        
        for (int i=0; i<oldTranslateArray.count; i++)
        {
            int a=[_array indexOfObject:[oldTranslateArray objectAtIndex:i]];
            NSLog(@"a======%d",a);
            UILabel*lable=(UILabel*)[self.view viewWithTag:1461+a];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:1471+a];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            imageView.image=[UIImage imageNamed:@"pitchUp.png"];
            
            
            
            
        }
        
        
    }

    
    
    oldStartData=startData;
    oldEndData=endData;
    
    
    RTLabel*lable=(RTLabel*)[self.view viewWithTag:160];
    lable.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",oldStartData];
    
    RTLabel*lable11=(RTLabel*)[self.view viewWithTag:161];
    lable11.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",oldEndData];
   
    if ([startData isEqualToString:@""]||[endData isEqualToString:@""])
    {
        lable.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",@"选择日期"];
        
        lable11.text=[NSString stringWithFormat:@"<font color=gray>从</font> %@",@"选择日期"];


    }

    
}

-(UIView*)crectIntroduce
{

    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 120)];
    view.tag=5;
    view.backgroundColor=[UIColor whiteColor];
    CALayer*layer=[view layer];
    layer.cornerRadius=3.14;
//    [self.view addSubview:view];
    
    UILabel*head=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 310, 30)];
    head.text=self.navName;
    
    
    head.font=[UIFont boldSystemFontOfSize:18];
    [view addSubview:head];
    
    UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(5, 25, 310, 60)];
    title.text=self.introduce;
    title.numberOfLines=0;
    title.font=[UIFont systemFontOfSize:15];
    title.textColor=[UIColor grayColor];
    lableHeight=[title sizeThatFits:CGSizeMake(310, 0)];
    [view addSubview:title];
    
    
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"entainmentlookmore.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 100, 320, 20);
    [view addSubview:button];
    
    
    




    return view;

}
-(void)lookMore:(UIButton*)sender
{
    UIView*view=(UIView*)[self.view viewWithTag:5];
    
    float l=lableHeight.height-60;
    
    if (l>0)
    {
        if (view.frame.size.height==120)
        {
            [UIView animateWithDuration:0.2f animations:^{
                view.frame = CGRectMake(0, 0, 320, 120+l);
                sender.frame=CGRectMake(0, view.frame.size.height-20, 320, 20);
                _tabView.tableHeaderView=view;
                [sender setImage:[UIImage imageNamed:@"entainmentlooksmall.png"] forState:UIControlStateNormal];
            }];
            
            
        }
        else
        {
            
            [UIView animateWithDuration:0.2f animations:^{
                view.frame = CGRectMake(0, 0, 320, 120);
                sender.frame=CGRectMake(0, view.frame.size.height-20, 320, 20);
                _tabView.tableHeaderView=view;
                [sender setImage:[UIImage imageNamed:@"entainmentlookmore.png"] forState:UIControlStateNormal];
            }];
            
            
            
        }
        
        

    }
   

}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    NSLog(@"%d------",decelerate);
    // 下拉到最底部时显示更多数据
    NSLog(@"%s",__func__);
    if(!_loadingMore && (scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height+10))))
        
    {
        
        [self loadDataBegin];
        
    }
    
}

- (void) loadDataBegin

{
    
    if (_loadingMore == NO)
        
    {
        
        _loadingMore = YES;
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:2];
        lable.text=@"";
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
    index1++;
    //    dataNumber = [tableData count];
    
    [self refreshDataIndex:index1 andIsRefreshBody:YES andIsRefreshHead:NO andAnimal:NO];
    
    
    
}


// 加载数据完毕

- (void) loadDataEnd:(NSString*)text

{
    
    _loadingMore = NO;
    
    [self createTableFooter:text];
    
}


// 创建表格底部

- (UIView*) createTableFooter:(NSString*)text

{
    NSLog(@"%s",__func__);
    //    _tabView.tableFooterView = nil;
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tabView.bounds.size.width, 40.0f)];
    
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 40.0f)];
    loadMoreText.tag=2;
    [loadMoreText setCenter:tableFooterView.center];
    
    [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    loadMoreText.textAlignment=NSTextAlignmentCenter;
//    [loadMoreText setText:text];
    
    [tableFooterView addSubview:loadMoreText];
    
    _tabView.tableFooterView=tableFooterView;
    
    return tableFooterView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
