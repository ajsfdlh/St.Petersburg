//
//  CountryViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()

@end

@implementation CountryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    hideTabbar

}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    float x=5;
    float y=5;
    float height=40;
    float width=320-2*x;
     Country=[NSArray arrayWithObjects:@"中国",@"俄罗斯" ,nil];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    for (int i=0; i<[Country count]; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(x, y+height*i, width, height);
        if (i==0)
        {
            [button setImage:[UIImage imageNamed:@"member_centerUp.png"] forState:UIControlStateNormal];
             [button setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        }
      else
      {
          [button setImage:[UIImage imageNamed:@"member_centerDown.png"] forState:UIControlStateNormal];
          [button setImage:[UIImage imageNamed:@"member_centerDown_h.png"] forState:UIControlStateHighlighted];
      
      }
        [button addTarget:self action:@selector(country:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=10+i;
        [self.view addSubview:button];
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 80, height)];
        lable.text=[Country objectAtIndex:i];
        [button addSubview:lable];
    }
    
    
    
//    UITableView*tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 80) style:UITableViewStylePlain];
//    tabView.delegate=self;
//    tabView.dataSource=self;
//    [self.view addSubview:tabView];
//
	// Do any additional setup after loading the view.
}
-(void)country:(UIButton*)sender
{
    

    if (sender.tag==10)
    {
        ProvinceViewController*province=[ProvinceViewController new];
        [self.navigationController pushViewController:province animated:NO];
        province.pageName=@"中国";
         province.title=@"中国";
    }
    
    else
    {
        ProvinceViewController*province=[ProvinceViewController new];
        [self.navigationController pushViewController:province animated:NO];
        province.pageName=@"俄罗斯";
        province.title=@"俄罗斯";
        
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [Country count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static  NSString*str=@"cell";
    CustomCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    cell.lable.text=[Country objectAtIndex:indexPath.row];
    return cell;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 40;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
