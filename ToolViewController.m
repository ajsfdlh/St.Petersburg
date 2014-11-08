//
//  ToolViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "ToolViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "NumberView.h"
#import "LingShiGuanViewController.h"
#import "AppDelegate.h"
#import "TextImageViewController.h"
#import "SubwayNewViewController.h"
@interface ToolViewController ()

@end

@implementation ToolViewController

-(void)viewWillAppear:(BOOL)animated
{
    appearTabbar

    [self.navigationItem setNewTitle:@"工具箱"];
    
  
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    [self goNumber];
}
- (void)goNumber{
    AppDelegate *mydelegate=[[UIApplication sharedApplication] delegate];
    [mydelegate numberGo ];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=GroupColor;
    {
     float buttonY=6;
     float buttonX=6;
    float distance=4;
    int count=4;
    float buttomFram=(320-2*buttonX-(count-1)*distance)/4;
        
        NSArray*buttonImage=[NSArray arrayWithObjects:@"buttonSign.png",@"buttonEmbassy.png",@"buttonTele.png",@"buttonWeather.png",@"buttonMoney.png",@"buttonTime.png",@"buttonAdvice.png",@"buttonQuestion.png",@"buttonAir.png",@"buttonTrain.png",@"buttonPublic.png",@"buttonSubway.png",@"buttonTaxi.png",@"buttonLine.png",@"buttonSOS.png", nil];
    for (int i=0; i<buttonImage.count; i++)
    {
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(buttonX+(buttomFram+distance)*(i%count), buttonY+(i/count)*(buttomFram+distance), buttomFram, buttomFram);
        [button setBackgroundImage:[UIImage imageNamed:[buttonImage objectAtIndex:i]] forState:UIControlStateNormal];
        button.tag=1100+i;
        [self.view addSubview:button];
        if (i == 13) {
            NumberView *NV = [[NumberView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
            NV.center = CGPointMake(button.frame.size.width-10, 10);
            if ([NV.numberLabel.text isEqualToString:@"0"]) {
                NV.hidden = YES;
            }else NV.hidden = NO;
            [button addSubview:NV];
        }

        [button addTarget:self action:@selector(tool:) forControlEvents:UIControlEventTouchUpInside];

        }
    }

   
}
-(void)tool:(UIButton*)sender
{

    switch (sender.tag)
    {
        case 1100:
        {
            TextViewController*telep=[TextViewController new];
            telep.navBarName=@"签证";
//            telep.imageArray=[NSArray arrayWithObjects:@"tool_air.png",@"tool_buss.png", @"tool_ subway.png", @"tool_ train.png", @"tool_taxi.png",  nil];
//            telep.tittleArray=[NSArray arrayWithObjects:@"圣彼得堡航空",@"圣彼得堡市内公交", @"圣彼得堡地铁", @"圣彼得堡火车", @"出租车",  nil];
//            telep.navibarName=@"交通";
            [self.navigationController pushViewController:telep animated:NO];
            
        }
            break;

        case 1101:
        {
            
            
            LingShiGuanViewController*lsgvc=[LingShiGuanViewController new];
            lsgvc.title=@"领事馆";
            [self.navigationController pushViewController:lsgvc animated:NO];
            
//            SceneryViewController*telep=[SceneryViewController new];
//            telep.imageArray=[NSArray arrayWithObjects:@"tool_air.png",@"tool_buss.png", @"tool_ subway.png", @"tool_ train.png", @"tool_taxi.png",  nil];
//            telep.tittleArray=[NSArray arrayWithObjects:@"圣彼得堡航空",@"圣彼得堡市内公交", @"圣彼得堡地铁", @"圣彼得堡火车", @"出租车",  nil];
//            telep.navibarName=@"交通";
//            [self.navigationController pushViewController:telep animated:NO];
            
        }
            break;
        case 1102:
        {
            TelephoneViewController*telep=[TelephoneViewController new];
//            telep.imageArray=[NSArray arrayWithObjects:@"tool_air.png",@"tool_buss.png", @"tool_ subway.png", @"tool_ train.png", @"tool_taxi.png",  nil];
//            telep.tittleArray=[NSArray arrayWithObjects:@"圣彼得堡航空",@"圣彼得堡市内公交", @"圣彼得堡地铁", @"圣彼得堡火车", @"出租车",  nil];
//            telep.navBarName=@"使馆";
            [self.navigationController pushViewController:telep animated:NO];
            
        }
            break;


        case 1103:
        {
            WeatherViewController*telep=[WeatherViewController new];
        
            [self.navigationController pushViewController:telep animated:NO];
        
        }
            break;
        case 1104:
        {
            TimeAndMoneyViewController*telep=[TimeAndMoneyViewController new];
            telep.pageName=@"货币";
            [self.navigationController pushViewController:telep animated:NO];
            
        }
            break;
        case 1105:
        {
            TimeAndMoneyViewController*telep=[TimeAndMoneyViewController new];
            telep.pageName=@"时间";
            [self.navigationController pushViewController:telep animated:NO];
            
            
        }
            break;
        case 1106:
        {
            AdviceViewController*telep=[AdviceViewController new];
//            telep.pageName=@"时间";
            [self.navigationController pushViewController:telep animated:NO];
            
        }
            break;

        case 1107:
        {
            SceneryViewController*telep=[SceneryViewController new];
            telep.tittleArray=[NSArray arrayWithObjects:@"商务签证或旅游签证在俄罗斯是否有地区限制?",@"什么时候去俄罗斯旅游最好?", @"去俄罗斯旅行，买什么纪念品好?", @"办团队免签入境，然后自由行，可以吗?",   nil];
            telep.navibarName=@"常见问题";
            [self.navigationController pushViewController:telep animated:NO];

            
        }
            break;
        case 1108:
        {
            TextImageViewController*textImage=[TextImageViewController new];
            textImage.titleArray=[NSArray arrayWithObjects:@"<br>", @"<p indent=33>圣彼得堡国际机场（机场三字代码：LED）位于圣彼得堡南部，是圣彼得堡重要的国际航空港，分为国内航班候机楼和国际航班候机楼，分别叫作普尔科沃1号和2号。</p>\n<p indent=33>普尔科沃机场-1距离市中心19KM，普尔科沃机场-2距离市中心23KM。两个机场相距只有几公里，大概需要10-15分钟的车程，在机场运营有免费的公共巴士可乘坐。</p>",@"<b><br>普尔科沃-1至市中心交通：</b>\n<p indent=33>1 乘坐39路公交，到达马雅可夫斯基地铁站。公交从早上6：00一直到凌晨0:30，每隔15分钟一趟。只需25卢布。</p>\n<p indent=33>2 乘坐快速商务公交K800，可到达地铁莫斯科站、技术学院站、弗拉基米尔站，到莫斯科站30卢布，到技术学院60卢布，到弗拉基米尔站90卢布，此趟商务公交一天24小时运行，但是具体间隔时间不定。</p>\n<p indent=33>3 机场有两家正规出租车公司驻点。如需乘坐出租车离开，可咨询机场工作人员或者拨打电话007(812)600 00 00直接预订，价格大约700卢布以上。</p>",@"<b><br>普尔科沃-2至市中心交通：</b>\n<p indent=33>1 乘坐13路公交，可到莫斯科地铁站。从早上6:07到凌晨0:47，每隔20分钟一趟，25卢布即可乘坐。</p>\n<p indent=33>2 乘坐商务快速公交K900，可到地铁莫斯科站、技术学院站、弗拉基米尔站，分别需30卢布、60卢布、90卢布。一天24小时运营，间隔时间不定。</p>\n<p indent=33>3 乘坐出租车K39，可到莫斯科地铁站，从早上07:00到晚上23:00，约20分钟一趟，30卢布。</p>\n<p indent=33>4 乘坐出租车K39A，到莫斯科地铁站；K113，到莫斯科地铁站，或库普奇诺地铁站；K3，到莫斯科地铁站、胜利公园地铁站、电力工厂地铁站、莫斯科之门地铁站、伏龙芝地铁站、技术学院地铁咱、干草广场地铁站。从早上7:00到晚上23:00，约20分钟一趟，35卢布。</p>\n<p indent=33>5 当然也可以从机场打电话叫的士，到市中心的平均价格为1000卢布。为安全起见，不建议乘坐私家出租车(在机场出口处招揽客人的车)。</p>",nil];
            textImage.imageArray=@[@"air1.jpg",@"air2.jpg",@"air3.jpg",@""];
            textImage.navName=@"圣彼得堡飞机";
            [self.navigationController pushViewController:textImage animated:NO];
            
            
        }
            break;
        case 1109:
        {
            TextImageViewController*textImage=[TextImageViewController new];
            textImage.titleArray=[NSArray arrayWithObjects:@"<br>", @"<p indent=33>圣彼得堡市内有5个客运火车站，分别通向赫尔辛基、华沙、莫斯科及俄罗斯其他大城市。其中通往莫斯科的火车站就叫“莫斯科火车站”。</p>\n<p indent=33>莫斯科火车站是圣彼得堡最主要的火车站，和莫斯科的列宁格勒火车站是“双胞胎”，位于圣彼得堡市中心，于1851年投入使用。该火车站主要是来往莫斯科与圣彼得堡两座城市之间的火车通行，并通过四个州：莫斯科、特维尔、诺夫哥罗德和列宁格勒。圣彼得堡--莫斯科的快速列车也由此站发出，这也是俄罗斯仅有的一条高铁线。快速列车都是白天往返于圣彼得堡和莫斯科之间，票价较普通列车高，行程大约4个小时。普通列车分为硬卧、软卧、豪华包间，有些列车会有少量座位。</p>",@"<b><br>交通信息：</b>\n<p indent=33>1 搭乘地铁红线至Площадь Восстания站，火车站的出口在红线Площадь Восстания站有楼梯的那个出口；</p>\n<p indent=33>2 搭乘地铁绿线在Маяковская站可下电梯后从右手出口出；</p>\n<p indent=33>3 搭乘任意经过涅瓦大街的公交车都可以到达，在Ст.метро Пл. Восстания站下车，往纪念碑方向走100米马路对面就是。</p>",nil];
            textImage.imageArray=@[@"train1.jpg",@"train2.jpg",@""];
            textImage.navName=@"圣彼得堡火车";
            [self.navigationController pushViewController:textImage animated:NO];
            
            
        }
            break;

  
        case 1110:
        {
            TextImageViewController*textImage=[TextImageViewController new];
            textImage.titleArray=[NSArray arrayWithObjects:@"<p indent=33>圣彼得堡的公共交通设施齐全，有公共汽车、地铁、有轨电车、无轨电车和旅游大巴。</p>", @"<b><br>公交车</b>\n<p indent=33>圣彼得堡的公交线路多，在涅瓦大街上乘车非常方便。如果你的起点和终点都在涅瓦大街上，那么基本上见到辆公交就可以坐上去。圣彼得堡主要区域的公交站很明显，但有些地方公交站没有像样的站台，公交的站牌会在旁边的建筑物墙上而不是一个站牌杆，所以刚来的旅行者可能有些不习惯。圣彼得堡公交站牌上的字比较小，站牌也比较高，不太方便查看。公交上也没有所经站点图表，有问题要向售票员询问。公交线路指示明确，凡在同一条道路上行驶的车辆，它们的站牌是组合在一起的。如果在前面是要转向前一条道路行驶的，则站牌是分开置放的。因此，只要看一个站牌，就能知道这组线路车辆都能到达下一个站点。</p>",@"<b><br>地铁</b>\n<p indent=33>有3条地铁线，总长64.5公里，四通八达。地铁站一般都设在商店的低层或十字街头的地下人行道里，有的就直接与火车站的地下通道相连，而且每个地铁出口都设有各种公交车站，十分便捷。</p>\n<p indent=33>在地铁站内，候车站台的对面墙上(铁轨内侧墙上)有一个浮雕箭头。箭头指向为列车前进的方向，箭身被分成好多段，每段都按序代表一个车站，上面写有车站名，箭尾的一段则是本车站。离终点站越近，段数也就越少。令人一目了然就清楚的看到，所要乘坐的地铁是开往那个方向，到目的地还有几个站点。</p>\n<p indent=33>地铁在白天一般2至3分钟一班，晚上5分钟一班。而在上下班高峰时20秒就有一列车进站。当然，有时也会发生列车因班次间隔时间太短而进不了站、此时只好在站外的地道内停驶等待进站的情况。地铁车站还设有电子钟，显示地铁两列车进站、离站间隔的时间，以便让乘客来监督地铁运行是否准时。</p>",@"<b><br>有轨电车</b>\n<p indent=33>圣彼得堡有轨电车的历史比较悠久，但现在还在运行的有轨电车大多比较老旧。当然，也有为数不多的新车正在投入使用。涅瓦大街上的有轨电车已不复存在，只有横穿涅瓦大街南北走向的线路还保留，而其他区域的有轨电车更像是对非中心区域的交通补充。有轨电车并不适合游客搭乘，但在横穿涅瓦大街的有些车是带彩灯的，晚上行驶非常漂亮。在上下班高峰时，有轨电车发挥了它的优势，由三辆车组成一列，就像火车一样，扩大了载客量，方便了上下班的人们。</p>",@"<b><br>无轨电车</b>\n<p indent=33>主要承担了城市中心区和瓦西里岛之间的交通。不过要注意，因为有些无轨电车使用时间较长，拐弯的时候在转接处可能会有火花，电杆也可能掉落，在周围要小心。经过涅瓦大街的车已经全部换新，在主要道路上的线路还是比较多的。</p>",@"<b><br>旅游大巴</b>\n<p indent=33>票价500卢布，在旅游信息中心拿取免费的“City Tour Pass”，可享受优惠。旅游大巴会前往圣彼得堡的很多知名景点，还包括阿芙乐尔号巡洋舰，全程游览大约2小时，非常适合时间安排紧凑的旅行者。</p>\n<p indent=33>由于圣彼得堡公共交通方便，并且票价便宜、服务良好，因此人们上下班大都选乘地铁和公交车。特别值得一提的是，乘客一般在月票亭购买月票或者购买一种被称之为“达龙”的票(一般为10张联票)，乘客上车后，自己在车上提供的打孔器上打票。偶尔会有检票员上车检查逃票的，将受到10倍的罚款。</p>",nil];
            textImage.imageArray=@[@"bus1.jpg",@"bus2.jpg",@"bus3",@"bus4",@"bus5",@""];
            textImage.navName=@"圣彼得堡市内公交";
            [self.navigationController pushViewController:textImage animated:NO];
        }
            break;
        case 1111:
        {
         
            
            SubwayNewViewController*telep=[SubwayNewViewController new];
            
            //            telep.tittleArray=[NSArray arrayWithObjects:@"Q：如何注册",@"Q：如何预订酒店", @"Q：如何**", @"Q：如何支付", @"Q：如何？？",  nil];
            //            telep.navibarName=@"常见问题";
            [self.navigationController pushViewController:telep animated:NO];
            
        }
            break;

        case 1112:
        {
            TextImageViewController*textImage=[TextImageViewController new];
            textImage.titleArray=[NSArray arrayWithObjects:@"<p indent=33>在圣彼得堡市区有很多私家车，扬手即停，甚至很多豪华车也愿意充当一次taxi，费用低廉，几十卢布即可。遇见开朗的车主，还会和你聊天。所以说圣彼得堡的出租车可以是任何车辆，只要司机愿意送你一程。上车前必须先谈好价钱，对不懂俄语的游客略为不便。</p>", @"<p indent=33>同时，圣彼得堡有多家正规出租车公司，支持电话预定。2013年开始，俄罗斯第一大搜索引擎“Yandex”与圣彼得堡的多家出租车公司、出租车停车场进行了合作，实现在线预订出租车服务，客户可以通过浏览器或iOS和Android系统进行网上预订。预订之后“Yandex.Taxi”会通过卫星定位将预订信息发往离客户最近的出租车。同时，客户也能在地图上跟踪到出租车的具体位置。</p>",nil];
            textImage.imageArray=@[@"taxi.jpg",@""];
            textImage.navName=@"圣彼得堡出租车";
            [self.navigationController pushViewController:textImage animated:NO];
            
        }
            break;
        case 1113:
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults valueForKey:TYPE_ID] intValue] ==2) {
                MessageViewController*consult=[MessageViewController new];
                consult.title=@"在线咨询";
                consult.userName = [defaults objectForKey:USER_NAME];
                [self.navigationController pushViewController:consult animated:NO];
                
            }else if ([[defaults valueForKey:TYPE_ID] intValue]==1){
                FirstViewController *fvc = [FirstViewController new];
                fvc.title = @"在线咨询";
                fvc.type_id = [defaults objectForKey:TYPE_ID];
                fvc.userid = [defaults objectForKey:QUSE_ID];
                fvc.userName = [defaults objectForKey:USER_NAME];
                NSLog(@"TYPE_ID %@ QUSE_ID %@",fvc.type_id,fvc.userid);
                [self.navigationController pushViewController:fvc animated:YES];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请登陆" message:@"您还没登陆，您确定要登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
            }
            

            

          
            
            
            
        }
            break;

            
        case 1114:
        {
            EmergencyViewController*telep=[EmergencyViewController new];
            //            telep.tittleArray=[NSArray arrayWithObjects:@"Q：如何注册",@"Q：如何预订酒店", @"Q：如何**", @"Q：如何支付", @"Q：如何？？",  nil];
            telep.navibarName=@"紧急救援";
            [self.navigationController pushViewController:telep animated:NO];
            
            
            
        }
            break;
            


        default:
            break;
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex==1) {
        MineViewController *mvc = [MineViewController new];
        mvc.tabBarController.tabBar.hidden=YES;
        mvc.tag=1;
        [self.navigationController pushViewController:mvc animated:YES];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
