//
//  CityViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CityViewController.h"
#import "GDataXMLNode.h"
@interface CityViewController ()

@end

@implementation CityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    float x=5;
    float y=-20;
    float width=320-2*x;

    UITableView*tabView=[[UITableView alloc]initWithFrame:CGRectMake(x, y, width, DeviceHeight) style:UITableViewStyleGrouped];
    tabView.delegate=self;
    tabView.dataSource=self;
    [self.view addSubview:tabView];

    NSArray*file = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    tabView.showsVerticalScrollIndicator=NO;
    
    //    country=[NSArray arrayWithObjects:@"中国",@"俄罗斯", nil];
    
//    provinces=[NSMutableArray new];
    city=[NSArray new];
    //
    city=[[file objectAtIndex:self.indexth]objectForKey:@"cities"];

   
	// Do any additional setup after loading the view.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
           return [city count];
        
    
    
   
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    return 1;
//}

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
           NSLog(@"%@",[city objectAtIndex:indexPath.row]);
        cell.lable.text=[city objectAtIndex:indexPath.row];
        cell._imageView.image=[UIImage imageNamed:@"memeber_headBack.png"];
        cell._imageView.highlightedImage=[UIImage imageNamed:@"LocationRussia.png"];
    
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
          NSString*str=[NSString stringWithFormat:@"%@ %@ %@",@"中国",self.province,[city objectAtIndex:indexPath.row]];
    
        Location*location=[Location shareLocation];
        location.location=str;
        
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        
        NSString*str1=[NSString stringWithFormat:@"%d", [defaults integerForKey:@"QuseID"] ];
        NSString *canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str1,@"",@"",@"",str,@"",@"",@""];//设置参数
        NSMutableString*urlDomain=RussiaUrl
        NSString*urlMethod=@"ModifyUserInfo";
        [urlDomain appendString:urlMethod];
       // postRequestTongBu(canshu, urlDomain, received)

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //   dicResultTongbu(data, result, dic);
        postRequestTongBu(canshu, urlDomain, received)
        dicResultTongbuNoDic(received, result);

        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"result %@",result);
            
        });
    });
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
        
        
    
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
