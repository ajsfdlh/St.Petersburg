//
//  NewsViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-19.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

backButton
-(void)viewWillAppear:(BOOL)animated
{
    hideTabbar
    [self.navigationItem setNewTitle:@"消息中心"];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -35, 320, DeviceHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=[UIColor clearColor];
    
    UIButton *backbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    float height=34;
    backbutton.frame=CGRectMake(0, (44-height)/2, 60, height) ;
    //    backbutton.backgroundColor=[UIColor redColor];
    
    [backbutton addTarget:self action:@selector(setEditing:animated:) forControlEvents:UIControlEventTouchUpInside];
  backbuttonlable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backbutton.frame.size.width, backbutton.frame.size.height)] ;
    backbuttonlable.text=@"编辑";
    backbutton.tag=50;
    backbuttonlable.textAlignment=NSTextAlignmentCenter;
    backbuttonlable.textColor=[UIColor whiteColor];
    [backbutton addSubview:backbuttonlable];
    UIImage *imgSelected = [UIImage imageNamed:@"submit.png"];[backbutton setBackgroundImage:[imgSelected stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton] ;
    self.navigationItem.rightBarButtonItem =backItem;

    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    dataArray=[NSMutableArray arrayWithArray:[defaults valueForKey:@"currentArray"]];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([[[dataArray lastObject]valueForKey:@"Summary"]length]>0)
    {
        return dataArray.count;

    }
    
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"cell";
    NewsCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell==nil)
    {
        cell=[[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    NSString*ID=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"ID"]stringValue];
    
    cell.title.text=[[dataArray objectAtIndex:indexPath.row]valueForKey:@"Title"];
    
    
    
    cell.content.text=[[dataArray objectAtIndex:indexPath.row]valueForKey:@"Summary"];
    NSString*strtime=[[dataArray objectAtIndex:indexPath.row]valueForKey:@"PTime"];

   cell. time.text=[strtime stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

    
    
    
    
    if ([defaults valueForKey:ID])
    {
        cell.weidu.text=@"";
    }
    else
    {
    cell.weidu.text=@"未读";
    }



    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell*cell=(NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.weidu.text=@"";
    
    
    
      NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
//      NSMutableArray*dataArray=[defaults valueForKey:@"dataArray"];
    NSString*ID=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"ID"]stringValue];
    [defaults setBool:YES forKey:ID];
    [defaults synchronize];
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    InfomDetailViewController*form=[InfomDetailViewController new];
    form.ID=indexPath.row;
    form.pageName=@"消息中心";
    [self.navigationController pushViewController:form animated:NO];


}
//设置是否可编辑性
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
//    UILabel*lable=(UILabel*)[self.view viewWithTag:50];
    
    if (self.editing==YES)
    {
        backbuttonlable.text=@"编辑";

         [super setEditing:NO animated:animated];
         [_tableView setEditing:NO animated:animated];
        
        
        
        
    }
    else
    {
        backbuttonlable.text=@"完成";
    [super setEditing:YES animated:animated];
    [_tableView setEditing:YES animated:animated];
    }
}
//返回编辑样式的方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NewsCell*cell=(NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
//    cell._imgeView.frame=CGRectMake(50, 0, 320, 80);
//    if (indexPath.row==array.count)
//    {
//        return UITableViewCellEditingStyleInsert;
//    }
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

   
//    if (editingStyle==UITableViewCellEditingStyleInsert)
//    {
//        [array insertObject:@"new" atIndex:indexPath.row];
//        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        
//    }
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        //对数组的删除
        //对cell的删除
        if (dataArray)
        {
            [dataArray removeObjectAtIndex:indexPath.row];
            

        }
        

        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
//      NSMutableArray*dataArray=[defaults valueForKey:@"dataArray"];
//        NSString*ID=[[[dataArray objectAtIndex:indexPath.row]valueForKey:@"ID"]stringValue];
        [defaults removeObjectForKey:@"currentArray"];
        [defaults setObject:dataArray forKey:@"currentArray"];
        [defaults synchronize];

        
    }
    
    
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";

}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row==array.count)
//    {
//        return NO;
//    }
    return YES;
}
//-(NSIndexPath*)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//    if (proposedDestinationIndexPath.row>=array.count)
//    {
//        return sourceIndexPath;
//    }
//    
//    
//    return proposedDestinationIndexPath;
//}
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    NSString*str=[array objectAtIndex:sourceIndexPath.row];
//    //    [array exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
//    [array removeObjectAtIndex:sourceIndexPath.row];
//    [array insertObject:str atIndex:destinationIndexPath.row];
//    
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
