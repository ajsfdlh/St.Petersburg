//
//  MyCollectDetailViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-13.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyCollectDetailViewController.h"
#import "json.h"
#import "CustomSceneryCell.h"
#import "GDataXMLNode.h"
#import "GuideTableViewCell.h"
#import "SupplierTableViewCell.h"
#import "TaxiPersonageCell.h"
#import "TaxiCompanyCell.h"

#import "GuideDetailViewController.h"
#import "SupplierTableViewController.h"
@interface MyCollectDetailViewController ()

@end

@implementation MyCollectDetailViewController
backButton

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tittles = @[@"中国留学生导游",@"专业俄籍导游",@"普通俄籍导游",@"专业中国导游",@"随行简单翻译",@"专业翻译",@"公务、商务翻译",@"专家翻译"];
    priceKey = @[@"CNUStudent",@"CNUSpasice",@"RUUPutong",@"RUUSpasice",@"SuiUFanyi",@"ZYUFanYi",@"GWUFanyi",@"ZJUFanYi"];
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-[self.title length])*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    
    dataArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1];
    myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.separatorStyle=NO;
    //addNoView
    [self addNoView];
    
    if ([self.title isEqualToString:@"景点"])
    {
        picPath=@"view";
        //picName=@"ViewPic";
        picID=@"ViewPic";
        
    }
    if ([self.title isEqualToString:@"住宿"])
    {
        picPath=@"hotel";
       // picName=@"HotelPic";
        picID=@"HotelPic";
        
        
    }
    if ([self.title isEqualToString:@"美食"])
    {
        picPath=@"rest";
       // picName=@"Pic";
        picID=@"Pic";
        
        
        
    }
    if ([self.title isEqualToString:@"购物"])
    {
        picPath=@"shop";
       // picName=@"Pic";
        picID=@"Pic";
        
        
    }
    if ([self.title isEqualToString:@"娱乐"])
    {
        picPath=@"ticket";
        // picName=@"TicketCName";
        picID=@"TicketCName";
        
        
        
        
    }
    if ([self.title isEqualToString:@"游记"])
    {
        picPath=@"travel";
       // picName=@"TicketCName";
        picID=@"Pic";
        
        
        
        
    }
    if ([self.title isEqualToString:@"导游"])
    {
        picPath=@"guide";
       // picName=@"Pic";
        picID=@"GuideID";
        
        
        
        
    }
    if ([self.title isEqualToString:@"租车"])
    {
        picPath=@"guide";
       // picName=@"Pic2";
        picID=@"GuideID";
    
    }
    if ([self.title isEqualToString:@"线路"])
    {
        picPath=@"line";
        //picName=@"line";
        picID=@"Pic";
        
    }
   
}
- (void)addNoView{
    NSLog(@"count %d",_count);
    if (_count==1000) {
        bv = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 120)];
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
        return;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"typeid %@",_typeID);
    NSMutableString *urlStr = RussiaUrl4;
    [urlStr appendString:@"getUserCollectList"];
    NSString *argStr = [NSString stringWithFormat:@"cityid=2&typeid=%@&userid=%@&pagesize=5&pageindex=%d",_typeID,GET_USER_DEFAUT(QUSE_ID),0];
    
    postRequestYiBu(argStr, urlStr)
}
postRequestAgency(datas)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"导游"])
    {
        if ([[dataArr[indexPath.row]objectForKey:@"GuideType"] intValue]==1) {
            GuideDetailViewController *gdvc = [GuideDetailViewController new];
            gdvc.gudieID = [dataArr[indexPath.row]objectForKey:@"GuideID"];
            gdvc.title = [NSString stringWithFormat:@"%@%@",[dataArr[indexPath.row]objectForKey:@"UName"],[dataArr[indexPath.row]objectForKey:@"GuideClass"]];
            GuideTableViewCell *cell=(GuideTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            gdvc.picImage = cell.iv.image;
            [self.navigationController pushViewController:gdvc animated:YES];
        }else{
            NSArray *guideAndTransitionTittleArr = @[@"中国留学生导游",@"专业俄籍导游",@"普通俄籍导游",@"专业中国导游",@"随行简单翻译",@"专业翻译",@"公务、商务翻译",@"专家翻译"];
            NSArray *guideAndTransitionKeyArr = @[@"CNUStudent",@"CNUSpasice",@"RUUPutong",@"RUUSpasice",@"SuiUFanyi",@"ZYUFanYi",@"GWUFanyi",@"ZJUFanYi"];
            NSMutableArray *guideAndTransitionArr = [NSMutableArray array];
            for (int i = 0 ;i < guideAndTransitionKeyArr.count ; i++) {
                if ([[dataArr[indexPath.row] objectForKey:guideAndTransitionKeyArr[i]] intValue]>0) {
                    
                    [guideAndTransitionArr addObject:[NSString stringWithFormat:@"%@ $<font  size=16 color=orange>%@</font>/天",guideAndTransitionTittleArr[i],[dataArr[indexPath.row] objectForKey:guideAndTransitionKeyArr[i]]]];
                }
            }
            SupplierTableViewController *sdvc = [SupplierTableViewController new];
            sdvc.gudieID = [dataArr[indexPath.row]objectForKey:@"GuideID"];
            GuideTableViewCell *cell=(GuideTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            
            sdvc.title = @"导游/翻译预订";
            sdvc.tableArr=guideAndTransitionArr;
            sdvc.picImage = cell.iv.image;
            [self.navigationController pushViewController:sdvc animated:YES];
            
        }
        
        
        return;
    }else if ([self.title isEqualToString:@"游记"]){
          CustomCell3*cell=(CustomCell3*)[tableView cellForRowAtIndexPath:indexPath];
        
        TravelViewController*inform=[TravelViewController new];
        inform.ID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ID"]intValue];
          inform.userImage=cell.headImage.image;
        [self.navigationController pushViewController:inform animated:NO];
        
    }else{
        EntainDetailViewController*detail=[EntainDetailViewController new];
        detail.picPath2=picPath;
        if ([self.title isEqualToString:@"住宿"])
        {
            detail.navName=@"酒店介绍";
            detail.classID=3;
         
            detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"HotelID"]integerValue];
            
        }else if ([self.title isEqualToString:@"线路"]) {

            detail.classID=2;
            detail.navName=@"线路介绍";
            detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ID"] integerValue];

        }else  if ([self.title isEqualToString:@"美食"])
        {
            detail.navName=@"餐厅介绍";
            detail.classID=5;
            //detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ID"] integerValue];
//            if ([_array isEqualToArray:headerArray])
//            {
//                
//                detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
//            }
//            else
//            {
                detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"RestID"]integerValue];
//                
//            }
            
        } else  if ([self.title isEqualToString:@"购物"])
        {
            detail.navName=@"购物介绍";
            detail.classID=6;
            detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ID"] integerValue];
//            if ([_array isEqualToArray:headerArray])
//            {
//                
//                detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
//            }
//            else
//            {
//                
                detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ShopID"]integerValue];
//            }
            
        }else  if ([self.title isEqualToString:@"景点"])
        {
           

            detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ViewID"]integerValue];

            detail.classID=7;
            detail.navName=@"景点介绍";
            
        }else if ([self.title isEqualToString:@"租车"])
        {
//            if ([_array isEqualToArray:headerArray])
//            {
//                detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
//            }
//            else
//            {
                detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"GuideID"]integerValue];
//                
//            }
          //  detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ID"] integerValue];
            detail.tag=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"GuideType"]integerValue]+1;
            detail.classID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"GuideType"]integerValue]+7;
            detail.dataDic2=[dataArr objectAtIndex:indexPath.row];
            detail.navName=[NSString stringWithFormat:@"%@%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"UName"],@"租车"];
            
        }else   if ([self.title isEqualToString:@"娱乐"])
        {
            detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ID"] integerValue];
            detail.navName=@"娱乐介绍";
            detail.classID=4;
            detail.tag=1;
            //        detail
//            if ([_array isEqualToArray:headerArray])
//            {
//                detail.hotelID=[[[_array objectAtIndex:senderTag]valueForKey:@"ProdID"]integerValue];
//                
//            }
//            else
//            {
                detail.hotelID=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"TicketID"]integerValue];
//            }
            
        }
        
        
        [self.navigationController pushViewController:detail animated:NO];
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBu(datas, result, dic)
    if (result.length>11) {
        dataArr = [dic objectForKey:@"ds"];
        [myTableView reloadData];
    }
    NSLog(@"dic  %@",dic);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*str=@"cell";
    CustomSceneryCell*cell2=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell2==nil)
    {
        cell2=[[CustomSceneryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    
    //线路
    if ([_typeID intValue]==2) {
        static NSString*lineCell=@"lineCell";
        LineCustomCell*cell=[tableView dequeueReusableCellWithIdentifier:lineCell];
        if (cell==nil)
        {
            cell=[[LineCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lineCell];
        }
        
        //标题
        cell.head.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Title"];
        [self loadPic_tableViewIndexPath:indexPath headLabName:cell.head.text headView:cell._imageView];
        //天数内容
        int a=[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LineDays"]intValue];
        cell.intrdouce.text=[NSString stringWithFormat:@"%d天 %@",a,[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LineType" ]];
        //价钱
        if (![[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LPrice"]]   isEqualToString:@""])
            cell.price.text=[NSString stringWithFormat:@"$<font size=16 color=orange>%@</font>",[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LPrice"]];
        else  cell.price.text=@"";
        return cell;
    }
    //景点
    else if ([_typeID intValue]==7){
        cell2.russiaHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ViewRUName"];

        cell2.chineseHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ViewCNName"];
        
        [self loadPic_tableViewIndexPath:indexPath headLabName:cell2.chineseHead.text headView:cell2._imageView];
        cell2.type.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ViewType"];
        
        NSLog(@"row  %d DianpCount %d",indexPath.row,[[[dataArr objectAtIndex:indexPath.row] valueForKey:@"DianpCount"] intValue]);
        
        cell2.gradeCount.text=[NSString stringWithFormat:@"开放时间  %@", [[dataArr objectAtIndex:indexPath.row] valueForKey:@"ShowTime"] ];
        
        if ([[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LPrice"]integerValue]!=0)
        {
            cell2.price.text=[NSString stringWithFormat:@"$<font size=21 color=orange>%@</font>起",[[dataArr objectAtIndex:indexPath.row] valueForKey:@"LPrice"]];
            
        }
        else
        {
            
            cell2.price.text=@"";
        }
        return cell2;
    }
    //住宿
    else if ([_typeID intValue]==3){
        
        NSString*_str;
        switch ([[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Star"]integerValue])
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
        
        
        cell2.russiaHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"HotelRUName"];
        cell2.chineseHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"HotelCNName"];
        [self loadPic_tableViewIndexPath:indexPath headLabName:cell2.chineseHead.text headView:cell2._imageView];
        cell2.type.text=[NSString stringWithFormat:@"房间数量:%@间",[[dataArr objectAtIndex:indexPath.row] valueForKey:@"RoomCount"]];
        cell2.gradeCount.text=_str;
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeImage.image=nil;
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        
        if ([[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LPrice"]integerValue]!=0)
        {
            cell2.price.text=[NSString stringWithFormat:@"<font  color=orange>$<font size=21>%d</font></font>起", [[[dataArr objectAtIndex:indexPath.row]valueForKey:@"LPrice"]integerValue]];
            
        }
        else
        {
            
            cell2.price.text=@"";
        }
        
        return cell2;

    }
    //美食
    else if ([_typeID intValue]==5){
        cell2.russiaHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"RestRName"];
        cell2.chineseHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"RestCName"];
        [self loadPic_tableViewIndexPath:indexPath headLabName:cell2.chineseHead.text headView:cell2._imageView];
        cell2.type.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"RestType"];
        cell2.type.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        cell2.type.textColor=[UIColor grayColor];
        cell2.gradeCount.text=[NSString stringWithFormat:@"人均消费:$%@", [[dataArr objectAtIndex:indexPath.row] valueForKey:@"Price"]];
        cell2.gradeImage.image=nil;
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        cell2.price.text=@"";
        return cell2;
    }
    //购物
    else if ([_typeID intValue]==6){
        cell2.russiaHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ShopRName"];
        cell2.chineseHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ShopCName"];
        [self loadPic_tableViewIndexPath:indexPath headLabName:cell2.chineseHead.text headView:cell2._imageView];
        cell2.type.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ShopType"];
        cell2.gradeCount.text=[NSString stringWithFormat:@"营业时间:%@", [[dataArr objectAtIndex:indexPath.row] valueForKey:@"ShowTime"]];
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeImage.image=nil;
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        cell2.price.text=@"";
        return cell2;
    }
    //娱乐
    else if ([_typeID intValue]==4){
        cell2.russiaHead.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"TicketRName"];
        CGSize size=[cell2.russiaHead sizeThatFits:CGSizeMake(230, 0)];
        cell2.russiaHead.frame=CGRectMake( cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.backGround.frame.origin.y+10,230 , size.height);
        [self loadPic_tableViewIndexPath:indexPath headLabName:cell2.russiaHead.text headView:cell2._imageView];
        cell2.chineseHead.text=@"";
        cell2.type.text=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"TicketClass"];
        cell2.gradeCount.text=[NSString stringWithFormat:@"时长:%@", [[dataArr objectAtIndex:indexPath.row] valueForKey:@"TimeLong"]];
        cell2.gradeCount.frame=CGRectMake(cell2._imageView.frame.origin.x+cell2._imageView.frame.size.width+5, cell2.type.frame.origin.y+cell2.type.frame.size.height,200 , 15);
        cell2.gradeImage.image=nil;
        cell2.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        if ([[[dataArr objectAtIndex:indexPath.row]valueForKey:@"UPrice"]integerValue]!=0)
        {
            cell2.price.text=[NSString stringWithFormat:@"$<font size=21  color=orange>%d</font>", [[[dataArr objectAtIndex:indexPath.row]valueForKey:@"UPrice"]integerValue]];;
            
        }
        else
        {
            
            cell2.price.text=@"";
        }
   return cell2;
    }
    //导游
    else if ([_typeID intValue]==8){
        
        
        GuideTableViewCell *guideCell = [tableView dequeueReusableCellWithIdentifier:@"guideCell"];
        if (!guideCell) {
            guideCell = [[GuideTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"guideCell"];
        }
        SupplierTableViewCell *supplierCell = [tableView dequeueReusableCellWithIdentifier:@"supplierCell"];
        if (!supplierCell) {
            supplierCell = [[SupplierTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"supplierCell"];
        }
        NSDictionary *dic;
       
        dic = dataArr[indexPath.row];
    
        
        if ([[dic objectForKey:@"GuideType"] intValue]==1) {
            if ([dic objectForKey:@"Pic"]) {
                NSMutableString *urlStr = PicUrl2;
                [urlStr appendString:[dic objectForKey:@"Pic"]];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                UIImage *image = [[UIImage alloc]initWithData:data];
                guideCell.iv.image =image;
                
            }
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
            guideCell.dayLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>$</font><font size=12 color=orange>%@</font><font  size=12 color=gray>/天,每天工作%@小时</font>",[dic objectForKey:@"UPrice"],[dic objectForKey:@"Hour"]];
            return guideCell;
        }
        
        if ([dic objectForKey:@"Pic"]) {
            NSMutableString *urlStr = PicUrl2;
            [urlStr appendString:[dic objectForKey:@"Pic"]];
            NSURL *url = [NSURL URLWithString:urlStr];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            UIImage *image = [[UIImage alloc]initWithData:data];
            supplierCell.iv.image =image;
            
        }
        //公司名
        

        supplierCell.nameLab.text = [NSString stringWithFormat:@"<font  size=14 color=black><b>导游/翻译预订</b></font> <font  size=12 color=red>%@</font>",[dic objectForKey:@"UName"]];
        //人数
        supplierCell.carLab.text = [NSString stringWithFormat:@"<font size=12 color=gray>导游(</font>%@人 <font size=12 color=gray>)翻译(</font>%@人<font size=12 color=gray>)</font>",[dic objectForKey:@"GuideCount"],[dic objectForKey:@"FanYiCount"]];
        //年龄
        supplierCell.languageLab.text = [NSString stringWithFormat:@"<font  size=12 color=gray>年龄 :</font> <font size=12 color=black>%@</font>",[dic objectForKey:@"AgeList"]];
        
        //学导---
        
        if (dataArr.count>0&&[[dic objectForKey:@"GuideType"] intValue]==2) {
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
        
        return supplierCell;
        
        
    }
    //租车
    else if ([_typeID intValue]==9){
        static NSString*personage=@"personage";
        static NSString*company=@"company";
        if ([[[dataArr objectAtIndex:indexPath.row] valueForKey:@"GuideType"] integerValue]==1)
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
            
          //  NSString*str=[NSString stringWithFormat:@"%@%@%@",picPath,picName,[[dataArr objectAtIndex:indexPath.row] valueForKey:picID]];
      
            NSString*name=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"UName"];
            NSString*seat=[NSString stringWithFormat:@"%@人座", [[dataArr objectAtIndex:indexPath.row]valueForKey:@"SeatCount"]];
            
            NSString*sex=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Sex"];
            if ([[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Sex"] integerValue]==1)
            {
                sex=@"男";
            }
            else
            {
                sex=@"女";
            }
            
            NSString*CarClass=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"CarType"];
            NSString*jicheng=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"JiCheng"];
            
            
            personageCell.nameCountrySexSeatCountCarClassJicheng.text=[NSString stringWithFormat:@"<font size=15 color=black>%@</font> <font size=12 color=gray>%@ %@ </font><font size=12>%@ %@ %@</font>",name,[[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Country"] integerValue]==1?@"":@"俄籍",sex,seat,CarClass,jicheng];
            [self loadPic_tableViewIndexPath:indexPath headLabName:personageCell.nameCountrySexSeatCountCarClassJicheng.text headView:personageCell._imageView];
            personageCell.carBrand.text=[NSString stringWithFormat:@"<font size=13 color=gray>汽车品牌：<font color=black>%@</font></font>",[[dataArr objectAtIndex:indexPath.row] valueForKey:@"CarBrand"]];
            personageCell.zongZhi.text=[NSString stringWithFormat:@"<font size=13 color=gray>服务宗旨：<font color=black>%@</font></font>",[[dataArr objectAtIndex:indexPath.row] valueForKey:@"ZongZhi"]];
            
            NSString*hour=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"Hour"];
            NSString*price=[[dataArr objectAtIndex:indexPath.row] valueForKey:@"UPrice"];
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
            
          //  NSString*str=[NSString stringWithFormat:@"%@%@%@",picPath,picName,[[dataArr objectAtIndex:indexPath.row] valueForKey:picID]];
     
            NSString*name=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"UName"];
            [self loadPic_tableViewIndexPath:indexPath headLabName:name headView:companyCell._imageView];
            NSString*count=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"GuideCount"];
            NSString*price1=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"CNUStudent"];;
            NSString*price2=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"CNUSpasice"];;
            NSString*price3=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"RUUPutong"];;
            NSString*price4=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"RUUSpasice"];;
            NSString*price5=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"SuiUFanyi"];;
            NSString*price6=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"GWUFanyi"];;
            NSString*price7=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ZYUFanYi"];;
            NSString*price8=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"ZJUFanYi"];;
            
            NSArray*priceType=@[@"FiveType",@"SixType",@"SevenType",@"NineType",@"FifteenType",@"SeventeemType",@"TwenType",@"ForType"];
            
            NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys:@"小时",@"1",@"天",@"2", nil];
            NSString*priceType1=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:0]]]];
            NSString*priceType2=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:1]]]];
            NSString*priceType3=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:2]]]];
            NSString*priceType4=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:3]]]];
            NSString*priceType5=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:4]]]];
            NSString*priceType6=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:5]]]];
            NSString*priceType7=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:6]]]];
            NSString*priceType8=[_dic valueForKey:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row]valueForKey:[priceType objectAtIndex:7]]]];
            
            companyCell.text.text=[NSString stringWithFormat:@"<font size=15 >租车预订</font> <font size=13 color=red>%@</font><br><font size=13 color=gray>租车(<font color=blue>%@辆</font>)<br>5人座：$<font color=orange>%@</font>/%@    6人座：$<font color=orange>%@</font>/%@ <br>7人座：$<font color=orange>%@</font>/%@     9人座：$<font color=orange>%@</font>/%@<br>15人座：$<font color=orange>%@</font>/%@    17人座：$<font color=orange>%@</font>/%@<br>20人座：$<font color=orange>%@</font>/%@    40人座以上：$<font color=orange>%@</font>/%@</font>",name,count,price1,priceType1,price2,priceType2,price3,priceType3,price4,priceType4,price5,priceType5,price6,priceType6,price7,priceType7,price8,priceType8];
            
            
            return companyCell;
            
        }
    }
    //游记
   // else if ([_typeID intValue]==1){
        static NSString*travelCell=@"travelCell";
        CustomCell3 *cell=[tableView dequeueReusableCellWithIdentifier:travelCell];
        if (cell==nil)
        {
            cell=[[CustomCell3 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:travelCell];
        }
        
        cell.lableHead.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"Title"];
    [self loadPic_tableViewIndexPath:indexPath headLabName:cell.lableHead.text headView:cell._imageView];
        CGSize size=[cell.lableHead sizeThatFits:CGSizeMake(195, 0)];
        cell.lableHead.frame=CGRectMake(115,15, 195, size.height);
        
        
        
        cell.useName.text=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"UserName"];
        NSString*_str1=[[dataArr objectAtIndex:indexPath.row]valueForKey:@"PTime"];
        _str1=[_str1 stringByReplacingOccurrencesOfString:@"/" withString:@"."];
        cell.data.text=_str1;
        
        return cell;


    
}
- (void)loadPic_tableViewIndexPath:(NSIndexPath*)indexPath headLabName:(NSString*)name headView:(UIImageView *)headView{
    NSLog(@"picid %@",picID);
    if ([[[dataArr objectAtIndex:indexPath.row] objectForKey:picID] length]>4) {
        NSLog(@"[[_dataArr objectAtIndex:indexPath.row] objectForKey:Pic]   %@",[[dataArr objectAtIndex:indexPath.row] objectForKey:picID]);
        NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(name)];
        
        if (pathData.length==0) {
            //[headAiv  startAnimating];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@",PicUrl,picPath,[[dataArr objectAtIndex:indexPath.row] objectForKey:picID]];
                NSLog(@"picurl %@",urlStr);
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *data = [NSData dataWithContentsOfURL:url];
                // [NSThread sleepForTimeInterval:2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data) {
                        [data writeToFile:PathOfFile(name) atomically:YES];
                        headView.image = [UIImage imageWithData:data];
                        [NSThread sleepForTimeInterval:1];
                        
                    }//else headIV.image = [UIImage imageNamed:@"lack.jpg"];
                    
                    //[headAiv stopAnimating];
                    
                });
            });
        }else headView.image = [UIImage imageWithData:pathData];
        
    }//else  return [UIImage imageNamed:@"lack.jpg"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"导游"])
    {    NSDictionary *dic = dataArr[indexPath.row];
        NSLog(@"dic %@",dic);
        if (dataArr.count>0&&[[dic objectForKey:@"GuideType"] intValue]==2) {
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
    else if ([self.title isEqualToString:@"租车"])
    {

        if (dataArr.count>0)
        {
            if ([[[dataArr objectAtIndex:indexPath.row]valueForKey:@"GuideType"]intValue]==2)
            {
                
                return 180;
            }
            
        }
        
        
        
        return 115;
    }
    else if ([self.title isEqualToString:@"线路"])
    {
        return 260;
    }
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return v;
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
