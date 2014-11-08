//
//  EveryDayViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "EveryDayViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
@interface EveryDayViewController ()

@end

@implementation EveryDayViewController

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{


   dicResultYiBu(datas, result, dic)
    [navActivity stopAnimating];
    dataArray=[dic valueForKey:@"ds"];
    NSLog(@"count======%d",dataArray.count);
    for (int i=0; i<dataArray.count; i++)
    {
                int prodID=[[[dataArray objectAtIndex:i]valueForKey:@"ProdID"] integerValue];

        if (prodID>0)
        {

        
        
        }
    }
    
    [_tabView reloadData];

}
//-(void)downPic:(NSString*)url andData:(Data*)_data  andTag:(int)_tag  andPath:(NSString*)path andTableView:(UITableView*)TableView
//{
//    NSLog(@"url======%@",url);
//    dispatch_queue_t queue0=dispatch_queue_create("download0", NULL);
//    dispatch_async(queue0, ^{
//        //下载图片的代码
//        NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//        
//        _data.image=[[UIImage alloc] initWithData:data];
//        dispatch_async(dispatch_get_main_queue(),
//                       ^{
//                           
//                           for (NSIndexPath *indexPath in TableView.indexPathsForVisibleRows)
//                           {
//                               Data*tempData=[picArray objectAtIndex:indexPath.row];
//                               if (tempData==_data)
//                               {
//                                   
//                                   [TableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                               }
//                           }
//                           
//                           NSString*str=[NSString stringWithFormat:@"%@%d",path,_tag];
//                           WriteToFile(data, str);
//                           
//                       });
//    });
//    
//    
//    
//    
//}

postRequestAgency(datas)
backButton
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(40+(8-4)*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [navActivity startAnimating];
    [self.navigationController.navigationBar addSubview:navActivity];
    [self setTitle:[NSString stringWithFormat:@"第%d天 行程清单",self.Lineday]];
    NSLog(@"ID======%d",self.ID);
    
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.ID],@"ID",[NSString stringWithFormat:@"%d",self.Lineday],@"Lineday", nil];
    NSMutableString*str=RussiaUrl2
    
    
    [QYHMeThod YiBuRequestandMethod:@"getTourLineLineDayDetail" andDomain:str andHttpMethod:@"POST" andArgument:dic andDelegate:self];
    
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-44-20) style:UITableViewStylePlain];
    
       
    _tabView.tag=1;
    _tabView.delegate=self;
    _tabView.dataSource=self;
    _tabView.delaysContentTouches=YES;
    
    //    _tabView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    _tabView.separatorColor=[UIColor clearColor];
    _tabView.backgroundColor=GroupColor;
    //    _tabView.separatorInset=UIEdgeInsetsMake(10, 0, 10, 0);
    [self.view addSubview:_tabView];
    
    
    
	// Do any additional setup after loading the view.
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*hotel=@"hotel";
    static NSString*scenery=@"scenery";
    
    HotelAndBusCell*hotelCell=[tableView dequeueReusableCellWithIdentifier:hotel];
    SceneryCell*sceneryCell=[tableView dequeueReusableCellWithIdentifier:scenery];
    
    int str =[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"TypeID"] integerValue];
     int prodID=[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"ProdID"] integerValue];
    
    NSLog(@"str======%d",str);
    
    if (prodID>0)
    {
        if (sceneryCell==nil)
        {
            sceneryCell=[[SceneryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scenery];
        }
        
        if (str==3)
        {
              sceneryCell.headImage.image=[UIImage imageNamed:@"LineDetail_Scenery.png"];
        }
        if (str==1)
        {
            sceneryCell.headImage.image=[UIImage imageNamed:@"LineDetail_food.png"];
                  }
        if (str==4)
        {
              sceneryCell.headImage.image=[UIImage imageNamed:@"LineDetail_hotel.png"];
        }

       
        sceneryCell.head.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"Title"];
        int type=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"TypeID"] integerValue];
        
        if (type==1)
        {
            
            [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:@"Pic" picHeadUrlStr:PicUrl picUrlPathStr:@"rest/big" PicLoadName:sceneryCell.head.text headView:sceneryCell._imageView];
            
            
        }
        
        if (type==3)
        {
            
            [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:@"Pic" picHeadUrlStr:PicUrl picUrlPathStr:@"view/big" PicLoadName:sceneryCell.head.text headView:sceneryCell._imageView];
            
        }
        if (type==4)
        {
            
            [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:@"Pic" picHeadUrlStr:PicUrl picUrlPathStr:@"hotel/big" PicLoadName:sceneryCell.head.text headView:sceneryCell._imageView];
        }
        
        
    
    else
    {
   
        [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:@"Pic" picHeadUrlStr:PicUrl picUrlPathStr:@"restr" PicLoadName:sceneryCell.head.text headView:sceneryCell._imageView];
        
    }
        sceneryCell.title.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"Summary"];
        CGSize size=[sceneryCell.title optimumSize];
        sceneryCell.title.frame=CGRectMake(45, 255, 265, size.height);
        sceneryCell.link.frame=CGRectMake(10, sceneryCell.title.frame.origin.y+sceneryCell.title.frame.size.height+8,300 ,2);
        
        
        
        return sceneryCell;

    }
    
   
        if (hotelCell==nil)
        {
            hotelCell=[[HotelAndBusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotel];
        }
      
    
    if (dataArray.count>0) {
        if (str==1)
        {
            [hotelCell._imageView setBackgroundImage:[UIImage imageNamed:@"LineDetail_food.png"] forState:UIControlStateNormal];
        }
        if (str==2)
        {
            [hotelCell._imageView setBackgroundImage:[UIImage imageNamed:@"LineDetail_bus.png"] forState:UIControlStateNormal];
            //             hotelCell._imageView.image=[UIImage imageNamed:@"LineDetail_bus.png"];
        }
        
        if (str==3)
        {
            [hotelCell._imageView setBackgroundImage:[UIImage imageNamed:@"LineDetail_Scenery.png"] forState:UIControlStateNormal];
            //             hotelCell._imageView.image=[UIImage imageNamed:@"LineDetail_bus.png"];
        }
        if (str==4)
        {
            [hotelCell._imageView setBackgroundImage:[UIImage imageNamed:@"LineDetail_hotel.png"] forState:UIControlStateNormal];
        }
        
        
        hotelCell.head.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"Title"];
        
        hotelCell.title.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"Summary"];
        CGSize size=[hotelCell.title optimumSize];
        hotelCell.title.frame=CGRectMake(45, 50, 265, size.height);
        hotelCell.link.frame=CGRectMake(10, hotelCell.title.frame.origin.y+hotelCell.title.frame.size.height+8, 300,2);
    }
      
        
        
        return hotelCell;
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    EntainDetailViewController*detail=[EntainDetailViewController new];
    
     int prodID=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"ProdID"] integerValue];
    int type=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"TypeID"] integerValue];
   
    
    if (prodID>0)
    {
        if (type==1)
        {
            detail.navName=@"餐厅介绍";
             detail.classID=5;
             detail.picPath2=@"rest";
        }
        if (type==3)
        {
            detail.navName=@"景点介绍";
            detail.classID=7;
            detail.picPath2=@"view";
        }
        
        if (type==4)
        {
            detail.navName=@"酒店介绍";
             detail.classID=3;
            detail.picPath2 = @"hotel";
        }
        detail.hotelID=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"ProdID"]integerValue];
        
        [self.navigationController pushViewController:detail animated:NO];
    }
    
    
//    detail.picPath=picPath;
//    if ([self isEqualToString:@"圣彼得堡住宿"])
//    {
//        detail.navName=@"酒店介绍";
//        detail.classID=3;
//        if ([_array isEqualToArray:headerArray])
//        {
//            detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ID"]integerValue];
//            
//            //            NSLog(@"HotelID====%d",[[[dataArray objectAtIndex:senderTag]valueForKey:@"HotelID"]integerValue]);
//        }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray)
    {
        int str =[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"ProdID"]intValue];
        
        
        if (str==0)
        {
            HotelAndBusCell*cell=(HotelAndBusCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
           
            return   cell.link.frame.size.height+cell.link.frame.origin.y;
            
            
        }
        
       else
        {
            SceneryCell*cell=(SceneryCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
           
              
           
            return    cell.link.frame.size.height+cell.link.frame.origin.y;
        }
        

    }
    
    
    return 200;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
