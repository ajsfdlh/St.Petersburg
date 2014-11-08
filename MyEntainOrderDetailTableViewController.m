//
//  MyEntainOrderDetailTableViewController.m
//  St.Petersburg
//
//  Created by kirem-peter on 14-11-5.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyEntainOrderDetailTableViewController.h"
#import "MyLineOrderDetailTableViewCell.h"
#import "GData/GDataXMLNode.h"
#import "OrderViewController.h"
#import "RTLabel.h"
#import "MyHotelOredeDetailCell.h"

@interface MyEntainOrderDetailTableViewController ()
@property (strong, nonatomic)UIView* topView;//“订单号”->“订单状态”这一部分视图   高度固定为127
@property (strong, nonatomic)UIView* infoView;//“XX信息”这一部分视图   高度不确定
@property (strong, nonatomic)UIView* orderInfoView;//“订单信息”视图   高度不确定
@property (strong, nonatomic)UIView* footBarView;//“去支付”所在视图  高固定为45
@property (strong, nonatomic)UIView* headerView;//tableHeaderView
@property (strong, nonatomic)UIView* footerView;//tableFooterView

@property (strong, nonatomic)UILabel* orderStatusLab;
@property (strong, nonatomic)UIButton* statusBtn;
@property (strong, nonatomic)UIButton* goSecondBtn;

@property (assign, nonatomic)CGFloat infoViewHeight;
@property (assign, nonatomic)CGFloat orderInfoViewHeight;
@property (assign, nonatomic)CGFloat footerViewHeight;
@end

@implementation MyEntainOrderDetailTableViewController

backButton
static NSString* cellIdentifier = @"Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单详情";
    self.tableArr = [NSMutableArray array];
    UIColor* color = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    if (self.prodClass.intValue == 1) {
        NSString *peopleinfo = self.currentDic[@"Peopleinfo"];
        for (NSString *firstStr in [peopleinfo componentsSeparatedByString:@"|"]) {
            [self.tableArr addObject:[firstStr componentsSeparatedByString:@","]];
        }
        UINib* nib = [UINib nibWithNibName:@"MyLineOrderDetailTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 127+177+122)];
        self.headerView.backgroundColor = color;
        [self.view addSubview:self.headerView];
    }else if (self.prodClass.intValue == 2) {
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 127+177+122)];
        self.headerView.backgroundColor = color;
        [self.view addSubview:self.headerView];
    }else if (self.prodClass.intValue == 3) {
        NSString *peopleinfo = self.currentDic[@"Peopleinfo"];
        for (NSString *firstStr in [peopleinfo componentsSeparatedByString:@"|"]) {
            [self.tableArr addObject:[firstStr componentsSeparatedByString:@","]];
        }
        UINib* nib = [UINib nibWithNibName:@"MyHotelOredeDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 127+208+163)];
        self.headerView.backgroundColor = color;
        [self.view addSubview:self.headerView];
    }else if (self.prodClass.intValue == 4) {
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 127+105+122)];
        self.headerView.backgroundColor = color;
        [self.view addSubview:self.headerView];
    }else if (self.prodClass.intValue == 5) {
        
    }else if (self.prodClass.intValue == 6) {
        
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addTopView];//添加“订单号”-“订单状态”视图
    
    [self addInfoView];//添加“图片”、标题等信息视图
    
    [self addOrderInfoView];//添加“订单信息”视图
    
    [self addFooterView];//添加“联系人”和“去支付”视图
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
}

-(void)addTopView {
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 127)];
    self.topView.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    [self.headerView addSubview:self.topView];
    
    UIColor *grayColor = [UIColor grayColor];
    UIFont* font = [UIFont systemFontOfSize:14];
    UILabel* orderNumTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 21)];
    orderNumTitle.text = @"订单号：";
    orderNumTitle.textColor = grayColor;
    orderNumTitle.font = font;
    [self.topView addSubview:orderNumTitle];
    UILabel* orderNumLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 10, 200, 21)];
    orderNumLab.text = self.currentDic[@"OrderID"];
    orderNumLab.font = font;
    [self.topView addSubview:orderNumLab];
    UILabel* orderPriceTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 34, 78, 21)];
    orderPriceTitle.text = @"订单金额：";
    orderPriceTitle.textColor = grayColor;
    orderPriceTitle.font = font;
    [self.topView addSubview:orderPriceTitle];
    UILabel* orderPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 34, 175, 21)];
    orderPriceLab.attributedText = self.orderPrice;
    orderPriceLab.font = font;
    [self.topView addSubview:orderPriceLab];
    UILabel* orderTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 58, 78, 21)];
    orderTimeTitle.text = @"下单时间：";
    orderTimeTitle.textColor = grayColor;
    orderTimeTitle.font = font;
    [self.topView addSubview:orderTimeTitle];
    UILabel* orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 58, 175, 21)];
    orderTimeLab.text = self.currentDic[@"PTime"];
    orderTimeLab.font = font;
    [self.topView addSubview:orderTimeLab];
    UILabel* payWayTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 82, 78, 21)];
    payWayTitle.text = @"支付方式：";
    payWayTitle.textColor = grayColor;
    payWayTitle.font = font;
    [self.topView addSubview:payWayTitle];
    UILabel* payWayLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 82, 175, 21)];
    payWayLab.text = self.payStr;
    payWayLab.font = font;
    [self.topView addSubview:payWayLab];
    UILabel* orderStatusTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 106, 78, 21)];
    orderStatusTitle.text = @"订单状态：";
    orderStatusTitle.textColor = grayColor;
    orderStatusTitle.font = font;
    [self.topView addSubview:orderStatusTitle];
    self.orderStatusLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 106, 130, 21)];
    self.orderStatusLab.text = self.currentDic[@"Status"];
    self.orderStatusLab.textColor = [UIColor colorWithRed:0.192 green:0.482 blue:0.76 alpha:1];
    self.orderStatusLab.font = font;
    [self.topView addSubview:self.orderStatusLab];
    self.statusBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 106, 70, 21)];
    self.statusBtn.hidden = YES;
    [self.statusBtn addTarget:self action:@selector(clickGoSecondButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addInfoView {
    UIColor* color = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    UIColor *grayColor = [UIColor grayColor];
    UIFont* font = [UIFont systemFontOfSize:14];
    if (self.prodClass.intValue == 1) {
        self.infoViewHeight = 177;
        self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, self.view.frame.size.width, self.infoViewHeight)];
        self.infoView.backgroundColor = color;
        [self.headerView addSubview:self.infoView];
        UILabel* infoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        infoLab.text = @"线路信息";
        infoLab.font = [UIFont systemFontOfSize:12];
        [self.infoView addSubview:infoLab];
        UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 137)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:titleView];
        UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        line1.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line1];
        UIImageView* headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 45)];
        headIV.image = self.headImage;
        [titleView addSubview:headIV];
        UILabel* titleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 17, 193, 35)];
        titleLab.numberOfLines = 2;
        titleLab.text = self.currentDic[@"Title"];
        titleLab.font = font;
        [titleView addSubview:titleLab];
        UIImageView* jianTouIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 17, 24, 17, 17)];
        jianTouIV.image = [UIImage imageNamed:@"cellJianTou.png"];
        [titleView addSubview:jianTouIV];
        UIImageView* line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 1)];
        line2.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line2];
        UILabel* dayCountTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, 44, 21)];
        dayCountTitle.text = @"天数:";
        dayCountTitle.textColor = grayColor;
        dayCountTitle.font = font;
        [titleView addSubview:dayCountTitle];
        UILabel* dayCountLab = [[UILabel alloc]initWithFrame:CGRectMake(64, 75, 220, 21)];
        dayCountLab.text = [NSString stringWithFormat:@"%@天", self.currentDic[@"LineDays"]];
        dayCountLab.font = font;
        [titleView addSubview:dayCountLab];
        UILabel* typeTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 106, 44, 21)];
        typeTitle.text = @"类型:";
        typeTitle.textColor = grayColor;
        typeTitle.font = font;
        [titleView addSubview:typeTitle];
        UILabel* typeLab = [[UILabel alloc]initWithFrame:CGRectMake(64, 106, 220, 21)];
        typeLab.text = self.currentDic[@"LineType"];
        typeLab.font = font;
        [titleView addSubview:typeLab];
    }else if (self.prodClass.intValue == 2) {
        self.infoViewHeight = 177;
        self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, self.view.frame.size.width, self.infoViewHeight)];
        self.infoView.backgroundColor = color;
        [self.headerView addSubview:self.infoView];
        UILabel* infoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        infoLab.text = @"景点信息";
        infoLab.font = [UIFont systemFontOfSize:12];
        [self.infoView addSubview:infoLab];
        UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 137)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:titleView];
        UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        line1.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line1];
        UIImageView* headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 45)];
        headIV.image = self.headImage;
        [titleView addSubview:headIV];
        UILabel* russiaTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 12, 193, 21)];
        russiaTitleLab.text = self.currentDic[@"ViewRUName"];
        russiaTitleLab.font = font;
        [titleView addSubview:russiaTitleLab];
        UILabel* chineseTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, 193, 20)];
        chineseTitleLab.text = self.currentDic[@"ViewCNName"];
        chineseTitleLab.textColor = grayColor;
        chineseTitleLab.font = [UIFont systemFontOfSize:12];
        [titleView addSubview:chineseTitleLab];
        UIImageView* jianTouIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 17, 24, 17, 17)];
        jianTouIV.image = [UIImage imageNamed:@"cellJianTou.png"];
        [titleView addSubview:jianTouIV];
        UIImageView* line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 1)];
        line2.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line2];
        UILabel* viewNameTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 10, 21)];
        viewNameTitle.text = self.currentDic[@"ViewName"];
        viewNameTitle.font = font;
        [titleView addSubview:viewNameTitle];
        UILabel* showTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 104, 70, 21)];
        showTimeTitle.text = @"开放时间:";
        showTimeTitle.textColor = grayColor;
        showTimeTitle.font = font;
        [titleView addSubview:showTimeTitle];
        //自适应高度
        RTLabel* showTimeLab = [[RTLabel alloc]initWithFrame:CGRectMake(80, 106, self.view.frame.size.width - 90 - 10, self.view.frame.size.height)];
        showTimeLab.text = self.currentDic[@"ShowTime"];
        showTimeLab.font = font;
        float height = showTimeLab.optimumSize.height;
        NSLog(@"height:%f",height);
        showTimeLab.frame = CGRectMake(80, 106, self.view.frame.size.width - 90 - 10, height);
        [titleView addSubview:showTimeLab];
        titleView.frame = CGRectMake(titleView.frame.origin.x, titleView.frame.origin.y, titleView.frame.size.width, titleView.frame.size.height + height - 21);
        self.infoViewHeight += height - 21;
        self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.headerView.frame.size.height + height - 21);
    }else if (self.prodClass.intValue == 3) {
        self.infoViewHeight = 208;
        self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, self.view.frame.size.width, self.infoViewHeight)];
        self.infoView.backgroundColor = color;
        [self.headerView addSubview:self.infoView];
        UILabel* infoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        infoLab.text = @"酒店信息";
        infoLab.font = [UIFont systemFontOfSize:12];
        [self.infoView addSubview:infoLab];
        UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 168)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:titleView];
        UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        line1.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line1];
        UIImageView* headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 45)];
        headIV.image = self.headImage;
        [titleView addSubview:headIV];
        UILabel* russiaTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 12, 193, 21)];
        russiaTitleLab.text = self.currentDic[@"HotelRUName"];
        russiaTitleLab.font = font;
        [titleView addSubview:russiaTitleLab];
        UILabel* chineseTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, 193, 20)];
        chineseTitleLab.text = self.currentDic[@"HotelCNName"];
        chineseTitleLab.textColor = grayColor;
        chineseTitleLab.font = [UIFont systemFontOfSize:12];
        [titleView addSubview:chineseTitleLab];
        UIImageView* jianTouIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 17, 24, 17, 17)];
        jianTouIV.image = [UIImage imageNamed:@"cellJianTou.png"];
        [titleView addSubview:jianTouIV];
        UIImageView* line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 1)];
        line2.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line2];
        UILabel* subheadLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 10, 21)];
        NSString *fittleStr=@"";
        if ([[self.currentDic valueForKey:@"Ftitle"] length]>0) {
            fittleStr = [NSString stringWithFormat:@"-%@",[self.currentDic valueForKey:@"Ftitle"]];
        }
        subheadLab.text = [NSString stringWithFormat:@"%@%@",[self.currentDic valueForKey:@"RoomName"],fittleStr];
        subheadLab.font = font;
        [titleView addSubview:subheadLab];
        UILabel* peopleCountTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 106, 85, 21)];
        peopleCountTitle.text = @"最多可入住:";
        peopleCountTitle.textColor = grayColor;
        peopleCountTitle.font = font;
        [titleView addSubview:peopleCountTitle];
        UILabel* peopleCountLab = [[UILabel alloc]initWithFrame:CGRectMake(86, 106, self.view.frame.size.width - 86 - 10, 21)];
        peopleCountLab.text = [NSString stringWithFormat:@"%@人", self.currentDic[@"MoneyType"]];
        peopleCountLab.font = font;
        [titleView addSubview:peopleCountLab];
        UILabel* roomFacilityTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 137, 70, 21)];
        roomFacilityTitle.text = @"房间设施:";
        roomFacilityTitle.textColor = grayColor;
        roomFacilityTitle.font = font;
        [titleView addSubview:roomFacilityTitle];
        UILabel* roomFacilityLab = [[UILabel alloc]initWithFrame:CGRectMake(71, 137, self.view.frame.size.width - 71 - 10, 21)];
        roomFacilityLab.text = self.currentDic[@"Other"];
        roomFacilityLab.font = font;
        [titleView addSubview:roomFacilityLab];
        
    }else if (self.prodClass.intValue == 4) {
        self.infoViewHeight = 105;
        self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, self.view.frame.size.width, self.infoViewHeight)];
        self.infoView.backgroundColor = color;
        [self.headerView addSubview:self.infoView];
        UILabel* infoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        infoLab.text = @"娱乐信息";
        infoLab.font = [UIFont systemFontOfSize:12];
        [self.infoView addSubview:infoLab];
        UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 65)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:titleView];
        UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        line1.image = [UIImage imageNamed:@"links.png"];
        [titleView addSubview:line1];
        UIImageView* headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 45)];
        headIV.image = self.headImage;
        [titleView addSubview:headIV];
        UILabel* titleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 17, 193, 35)];
        titleLab.numberOfLines = 2;
        titleLab.text = self.currentDic[@"TicketRName"];
        titleLab.font = font;
        [titleView addSubview:titleLab];
        UIImageView* jianTouIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 17, 24, 17, 17)];
        jianTouIV.image = [UIImage imageNamed:@"cellJianTou.png"];
        [titleView addSubview:jianTouIV];
    }else if (self.prodClass.intValue == 5) {//导游（个人）订单详情
//        infoLab.text = @"导游信息";
        
        
    }else if (self.prodClass.intValue == 6) {//租车（个人）订单详情
//        infoLab.text = @"租车信息";
        
        
    }
    
}

-(void)addOrderInfoView {
    UIColor* color = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    UIColor *grayColor = [UIColor grayColor];
    UIFont* font = [UIFont systemFontOfSize:14];
    if (self.prodClass.intValue == 1) {
        self.orderInfoViewHeight = 122;
        self.orderInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height+self.infoViewHeight, self.view.frame.size.width, self.orderInfoViewHeight)];
        self.orderInfoView.backgroundColor = color;
        [self.headerView addSubview:self.orderInfoView];
        UILabel* orderInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        orderInfoLab.text = @"订单信息";
        orderInfoLab.font = [UIFont systemFontOfSize:12];
        [self.orderInfoView addSubview:orderInfoLab];
        UIView* orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 82)];
        orderView.backgroundColor = [UIColor whiteColor];
        [self.orderInfoView addSubview:orderView];
        UIImageView* startdayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 18, 18)];
        startdayIV.image = [UIImage imageNamed:@"住宿预订第1步_03.png"];
        [orderView addSubview:startdayIV];
        UILabel* startdayTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 10, 70, 21)];
        startdayTitle.text = @"出发日期";
        startdayTitle.textColor = grayColor;
        startdayTitle.font = font;
        [orderView addSubview:startdayTitle];
        UILabel* startdayLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, self.view.frame.size.width - 120 - 10, 21)];
        startdayLab.text = self.currentDic[@"Startdate"];
        startdayLab.font = font;
        [orderView addSubview:startdayLab];
        UIImageView* link = [[UIImageView alloc]initWithFrame:CGRectMake(10, 41, self.view.frame.size.width - 10, 1)];
        link.image = [UIImage imageNamed:@"links.png"];
        [orderView addSubview:link];
        UIImageView* peopleCountIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 53, 18, 18)];
        peopleCountIV.image = [UIImage imageNamed:@"住宿预订第1步_03-09.png"];
        [orderView addSubview:peopleCountIV];
        UILabel* peopleCountTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 51, 70, 21)];
        peopleCountTitle.text = @"预订人数";
        peopleCountTitle.textColor = grayColor;
        peopleCountTitle.font = font;
        [orderView addSubview:peopleCountTitle];
        UILabel* peopleCountLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 51, self.view.frame.size.width - 120 - 10, 21)];
        peopleCountLab.text = [NSString stringWithFormat:@"%@成人%@儿童", self.currentDic[@"PCount"], self.currentDic[@"HCount"]];
        peopleCountLab.font = font;
        [orderView addSubview:peopleCountLab];
    }else if (self.prodClass.intValue == 2) {
        self.orderInfoViewHeight = 122;
        self.orderInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height+self.infoViewHeight, self.view.frame.size.width, self.orderInfoViewHeight)];
        self.orderInfoView.backgroundColor = color;
        [self.headerView addSubview:self.orderInfoView];
        UILabel* orderInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        orderInfoLab.text = @"订单信息";
        orderInfoLab.font = [UIFont systemFontOfSize:12];
        [self.orderInfoView addSubview:orderInfoLab];
        UIView* orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 82)];
        orderView.backgroundColor = [UIColor whiteColor];
        [self.orderInfoView addSubview:orderView];
        UIImageView* startdayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 18, 18)];
        startdayIV.image = [UIImage imageNamed:@"住宿预订第1步_03.png"];
        [orderView addSubview:startdayIV];
        UILabel* startdayTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 10, 70, 21)];
        startdayTitle.text = @"选择日期";
        startdayTitle.textColor = grayColor;
        startdayTitle.font = font;
        [orderView addSubview:startdayTitle];
        UILabel* startdayLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, self.view.frame.size.width - 120 - 10, 21)];
        startdayLab.text = self.currentDic[@"Viewdate"];
        startdayLab.font = font;
        [orderView addSubview:startdayLab];
        UIImageView* link = [[UIImageView alloc]initWithFrame:CGRectMake(10, 41, self.view.frame.size.width - 10, 1)];
        link.image = [UIImage imageNamed:@"links.png"];
        [orderView addSubview:link];
        UIImageView* peopleCountIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 53, 18, 18)];
        peopleCountIV.image = [UIImage imageNamed:@"住宿预订第1步_03-09.png"];
        [orderView addSubview:peopleCountIV];
        UILabel* peopleCountTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 51, 70, 21)];
        peopleCountTitle.text = @"预订数量";
        peopleCountTitle.textColor = grayColor;
        peopleCountTitle.font = font;
        [orderView addSubview:peopleCountTitle];
        UILabel* peopleCountLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 51, self.view.frame.size.width - 120 - 10, 21)];
        peopleCountLab.text = [NSString stringWithFormat:@"%@", [self.currentDic valueForKey:@"VCount"]];
        peopleCountLab.font = font;
        [orderView addSubview:peopleCountLab];
    }else if (self.prodClass.intValue == 3) {
        self.orderInfoViewHeight = 163;
        self.orderInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height+self.infoViewHeight, self.view.frame.size.width, self.orderInfoViewHeight)];
        self.orderInfoView.backgroundColor = color;
        [self.headerView addSubview:self.orderInfoView];
        UILabel* orderInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        orderInfoLab.text = @"订单信息";
        orderInfoLab.font = [UIFont systemFontOfSize:12];
        [self.orderInfoView addSubview:orderInfoLab];
        UIView* orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 123)];
        orderView.backgroundColor = [UIColor whiteColor];
        [self.orderInfoView addSubview:orderView];
        UIImageView* checkInIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 18, 18)];
        checkInIV.image = [UIImage imageNamed:@"住宿预订第1步_03.png"];
        [orderView addSubview:checkInIV];
        UILabel* checkInTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 10, 70, 21)];
        checkInTitle.text = @"入住日期";
        checkInTitle.textColor = grayColor;
        checkInTitle.font = font;
        [orderView addSubview:checkInTitle];
        UILabel* checkInLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, self.view.frame.size.width - 120 - 10, 21)];
        checkInLab.text = self.currentDic[@"Indate"];
        checkInLab.font = font;
        [orderView addSubview:checkInLab];
        UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 41, self.view.frame.size.width - 10, 1)];
        line1.image = [UIImage imageNamed:@"links.png"];
        [orderView addSubview:line1];
        UIImageView* checkOutIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 53, 18, 18)];
        checkOutIV.image = [UIImage imageNamed:@"住宿预订第1步_03-02.png"];
        [orderView addSubview:checkOutIV];
        UILabel* checkOutTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 51, 70, 21)];
        checkOutTitle.text = @"退房日期";
        checkOutTitle.textColor = grayColor;
        checkOutTitle.font = font;
        [orderView addSubview:checkOutTitle];
        UILabel* checkOutLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 51, self.view.frame.size.width - 120 - 10, 21)];
        checkOutLab.text = self.currentDic[@"Outdate"];
        checkOutLab.font = font;
        [orderView addSubview:checkOutLab];
        UIImageView* line2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 82, self.view.frame.size.width - 10, 1)];
        line2.image = [UIImage imageNamed:@"links.png"];
        [orderView addSubview:line2];
        UIImageView* roomCountIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 94, 18, 18)];
        roomCountIV.image = [UIImage imageNamed:@"住宿预订第1步_03-06.png"];
        [orderView addSubview:roomCountIV];
        UILabel* roomCountTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 92, 70, 21)];
        roomCountTitle.text = @"房间数量";
        roomCountTitle.textColor = grayColor;
        roomCountTitle.font = font;
        [orderView addSubview:roomCountTitle];
        UILabel* roomCountLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 92, self.view.frame.size.width - 120 - 10, 21)];
        roomCountLab.text = [NSString stringWithFormat:@"%@间",self.currentDic[@"RCount"]];
        roomCountLab.font = font;
        [orderView addSubview:roomCountLab];
    }else if (self.prodClass.intValue == 4) {
        self.orderInfoViewHeight = 122;
        self.orderInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height+self.infoViewHeight, self.view.frame.size.width, self.orderInfoViewHeight)];
        self.orderInfoView.backgroundColor = color;
        [self.headerView addSubview:self.orderInfoView];
        UILabel* orderInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 78, 20)];
        orderInfoLab.text = @"订单信息";
        orderInfoLab.font = [UIFont systemFontOfSize:12];
        [self.orderInfoView addSubview:orderInfoLab];
        UIView* orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 82)];
        orderView.backgroundColor = [UIColor whiteColor];
        [self.orderInfoView addSubview:orderView];
        UIImageView* startdayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 18, 18)];
        startdayIV.image = [UIImage imageNamed:@"住宿预订第1步_03.png"];
        [orderView addSubview:startdayIV];
        UILabel* startdayTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 10, 70, 21)];
        startdayTitle.text = @"选择日期";
        startdayTitle.textColor = grayColor;
        startdayTitle.font = font;
        [orderView addSubview:startdayTitle];
        UILabel* startdayLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, self.view.frame.size.width - 120 - 10, 21)];
        startdayLab.text = self.currentDic[@"Viewdate"];
        startdayLab.font = font;
        [orderView addSubview:startdayLab];
        UIImageView* link = [[UIImageView alloc]initWithFrame:CGRectMake(10, 41, self.view.frame.size.width - 10, 1)];
        link.image = [UIImage imageNamed:@"links.png"];
        [orderView addSubview:link];
        UIImageView* peopleCountIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 53, 18, 18)];
        peopleCountIV.image = [UIImage imageNamed:@"住宿预订第1步_03-09.png"];
        [orderView addSubview:peopleCountIV];
        UILabel* peopleCountTitle = [[UILabel alloc]initWithFrame:CGRectMake(38, 51, 70, 21)];
        peopleCountTitle.text = @"预订数量";
        peopleCountTitle.textColor = grayColor;
        peopleCountTitle.font = font;
        [orderView addSubview:peopleCountTitle];
        UILabel* peopleCountLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 51, self.view.frame.size.width - 120 - 10, 21)];
        peopleCountLab.text = [NSString stringWithFormat:@"%@", [self.currentDic valueForKey:@"TCount"]];
        peopleCountLab.font = font;
        [orderView addSubview:peopleCountLab];
    }else if (self.prodClass.intValue == 5) {//导游（个人）订单详情
        
        
        
    }else if (self.prodClass.intValue == 6) {//租车（个人）订单详情
        
        
        
    }
}

-(void)addFooterView {
    UIColor* color = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    UIColor *grayColor = [UIColor grayColor];
    UIFont* font = [UIFont systemFontOfSize:14];
    self.goSecondBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-70)/2, 17.5, 70, 30)];
    self.goSecondBtn.backgroundColor = [UIColor colorWithRed:0.047 green:0.345 blue:0.663 alpha:1];
    self.goSecondBtn.hidden = YES;
    self.goSecondBtn.titleLabel.font = font;
    self.goSecondBtn.layer.cornerRadius = 5;
    self.goSecondBtn.layer.masksToBounds = YES;
    [self.goSecondBtn addTarget:self action:@selector(clickGoSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.orderStatusLab.text isEqualToString:@"待支付"]) {
        self.orderStatusLab.textColor = [UIColor redColor];
        self.statusBtn.hidden = NO;
        [self.statusBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        self.goSecondBtn.hidden = NO;
        [self.goSecondBtn setTitle:@"去支付" forState:UIControlStateNormal];
        self.footerViewHeight = 10 + 246 + 10 + 45;
        self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.footerViewHeight)];
        self.footerView.backgroundColor = color;
        self.footBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + 246, self.view.frame.size.width, 55)];
        self.footBarView.backgroundColor = color;
        UIImageView* backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 45)];
        backView.image = [UIImage imageNamed:@"guding.png"];
        [self.footBarView addSubview:backView];
        [self.footBarView addSubview:self.goSecondBtn];
        [self.footerView addSubview:self.footBarView];
    }else if ([self.orderStatusLab.text isEqualToString:@"已取消"] || [self.orderStatusLab.text isEqualToString:@"已失效"]) {
        self.orderStatusLab.textColor = [UIColor grayColor];
        self.goSecondBtn.hidden = NO;
        [self.goSecondBtn setTitle:@"重新预订" forState:UIControlStateNormal];
        self.footerViewHeight = 10 + 246 + 10 + 45;
        self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.footerViewHeight)];
        self.footerView.backgroundColor = color;
        self.footBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + 246, self.view.frame.size.width, 55)];
        self.footBarView.backgroundColor = color;
        UIImageView* backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 45)];
        backView.image = [UIImage imageNamed:@"guding.png"];
        [self.footBarView addSubview:backView];
        [self.footBarView addSubview:self.goSecondBtn];
        [self.footerView addSubview:self.footBarView];
    }else if ([self.orderStatusLab.text isEqualToString:@"已完成"]) {
        self.goSecondBtn.hidden = NO;
        [self.goSecondBtn setTitle:@"去点评" forState:UIControlStateNormal];
        self.footerViewHeight = 10 + 246 + 10 + 45;
        self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.footerViewHeight)];
        self.footerView.backgroundColor = color;
        self.footBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + 246, self.view.frame.size.width, 55)];
        self.footBarView.backgroundColor = color;
        UIImageView* backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 45)];
        backView.image = [UIImage imageNamed:@"guding.png"];
        [self.footBarView addSubview:backView];
        [self.footBarView addSubview:self.goSecondBtn];
        [self.footerView addSubview:self.footBarView];
    }else {
        self.footerViewHeight = 10 + 246;
        self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.footerViewHeight)];
        self.footerView.backgroundColor = color;
    }
    UIView* linkerView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 246)];
    linkerView.backgroundColor = [UIColor whiteColor];
    [self.footerView addSubview:linkerView];
    UILabel* linkerInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 21)];
    linkerInfoLab.text = @"联系人信息";
    linkerInfoLab.font = [UIFont systemFontOfSize:12];
    [linkerView addSubview:linkerInfoLab];
    UILabel* linkerNameTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 51, 80, 21)];
    linkerNameTitle.text = @"姓名";
    linkerNameTitle.textColor = grayColor;
    linkerNameTitle.font = font;
    [linkerView addSubview:linkerNameTitle];
    UILabel* linkerNameLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 51, 210, 21)];
    linkerNameLab.text = self.currentDic[@"Uname"];
    linkerNameLab.font = font;
    [linkerView addSubview:linkerNameLab];
    UILabel* linkerPhoneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 92, 80, 21)];
    linkerPhoneTitle.text = @"联系电话";
    linkerPhoneTitle.textColor = grayColor;
    linkerPhoneTitle.font = font;
    [linkerView addSubview:linkerPhoneTitle];
    UILabel* linkerPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 92, 210, 21)];
    linkerPhoneLab.text = self.currentDic[@"Phone"];
    linkerPhoneLab.font = font;
    [linkerView addSubview:linkerPhoneLab];
    UILabel* linkerEmailTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 133, 80, 21)];
    linkerEmailTitle.text = @"电子邮箱";
    linkerEmailTitle.textColor = grayColor;
    linkerEmailTitle.font = font;
    [linkerView addSubview:linkerEmailTitle];
    UILabel* linkerEmailLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 133, 210, 21)];
    linkerEmailLab.text = self.currentDic[@"Email"];
    linkerEmailLab.font = font;
    [linkerView addSubview:linkerEmailLab];
    UILabel* linkerQQTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 174, 80, 21)];
    linkerQQTitle.text = @"QQ";
    linkerQQTitle.textColor = grayColor;
    linkerQQTitle.font = font;
    [linkerView addSubview:linkerQQTitle];
    UILabel* linkerQQLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 174, 210, 21)];
    linkerQQLab.text = self.currentDic[@"QQ"];
    linkerQQLab.font = font;
    [linkerView addSubview:linkerQQLab];
    UILabel* linkerWeiXinTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 215, 80, 21)];
    linkerWeiXinTitle.text = @"微信";
    linkerWeiXinTitle.textColor = grayColor;
    linkerWeiXinTitle.font = font;
    [linkerView addSubview:linkerWeiXinTitle];
    UILabel* linkerWeiXinLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 215, 210, 21)];
    linkerWeiXinLab.text = self.currentDic[@"Weixin"];
    linkerWeiXinLab.font = font;
    [linkerView addSubview:linkerWeiXinLab];
    for (int i = 1; i < 6; i++) {
        UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 41*i, self.view.frame.size.width - 10, 1)];
        line.image = [UIImage imageNamed:@"links.png"];
        [linkerView addSubview:line];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.prodClass.intValue == 1 || self.prodClass.intValue == 3) {
        return self.tableArr.count;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.prodClass.intValue == 1) {
        return 301;
    }else if (self.prodClass.intValue == 3) {
        return 80;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.prodClass.intValue == 1) {
        MyLineOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyLineOrderDetailTableViewCell" owner:self options:nil]lastObject];
        }
        cell.headLab.text = [NSString stringWithFormat:@"第%d位游客信息",indexPath.row+1];
        cell.cLastName.text = self.tableArr[indexPath.row][0];
        cell.cFirstName.text = self.tableArr[indexPath.row][1];
        cell.eLastName.text = self.tableArr[indexPath.row][2];
        cell.eFirstName.text = self.tableArr[indexPath.row][3];
        if ([self.tableArr[indexPath.row][0] isEqualToString:@"男士"]) {
            cell.sex.text = @"男";
        }else {
            cell.sex.text = @"女";
        }
        cell.bornDate.text = self.tableArr[indexPath.row][5];
        cell.passportNum.text = self.tableArr[indexPath.row][6];
        cell.passportDate.text = self.tableArr[indexPath.row][7];
        
        return cell;
    }else if (self.prodClass.intValue == 3) {
        MyHotelOredeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHotelOredeDetailCell" owner:self options:nil] lastObject];
        }
        cell.headTitle.text = [NSString stringWithFormat:@"房间%d入住人",indexPath.row+1];
        cell.XingLab.text = self.tableArr[indexPath.row][0];
        cell.MingLab.text = self.tableArr[indexPath.row][1];
        
        return cell;
    }else {
        return nil;
    }
    
}

//  改变分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.prodClass.intValue == 1 || self.prodClass.intValue == 3) {
        return 10;
    }else {
        return 0;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        //10 分区头的高度
        if (scrollView.contentOffset.y<=10&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=10) {
            scrollView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
        }
    }
}

/*
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
 */

-(void)clickGoSecondButton:(UIButton* )sender {
    if ([sender.currentTitle isEqualToString:@"取消订单"]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSMutableString *urlStr =RussiaUrl4;
            [urlStr appendString:@"CanselOrder"];
            //orderid：订单ID，prodclass：1线路、2景点、3酒店、4门票、5导游、6租车
            NSString *argumentStr = [NSMutableString stringWithFormat:@"orderid=%@&prodclass=%@",self.currentDic[@"ID"],self.prodClass];
            postRequestTongBu(argumentStr, urlStr, received)
            dicResultTongbuNoDic(received, result)
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result.length>0) {
                    self.orderStatusLab.text = @"已取消";
                    self.orderStatusLab.textColor = [UIColor grayColor];
                    self.statusBtn.hidden=YES;
                    [self.goSecondBtn setTitle:@"重新预订" forState:UIControlStateNormal];
                }else{
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"取消失败。" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: @"确定",nil];
                    [av show];
                }
            });
        });
    }else if ([sender.currentTitle isEqualToString:@"去支付"]) {
        NSLog(@"去支付，跳转到支付界面");
//        OrderViewController* ovc = [OrderViewController sharedOrderViewController];
//        ovc.presentWay = 2;
//        ovc.prodClass = 3;
//        ovc.orderNumber = _orderNumLab.text;
//        ovc.productDescription = self.roomFacilityLab.text;
//        ovc.mhodTVC = self;
//        ovc.productName = [NSString stringWithFormat:@"%@ %@", self.chineseTitleLab.text, self.subheadLab.text];
//        [self.navigationController pushViewController:ovc animated:NO];
    }else if ([sender.currentTitle isEqualToString:@"重新预订"]) {
        NSLog(@"重新预订，跳转到预订界面");
//        EntainDetailViewController* entainDetailVC = [EntainDetailViewController new];
//        entainDetailVC.hotelID = self.hotelID;
//        entainDetailVC.navName = @"酒店介绍";
//        [self.navigationController pushViewController:entainDetailVC animated:YES];
    }else if ([sender.currentTitle isEqualToString:@"去点评"]) {
        NSLog(@"去点评，跳转到点评界面");
        
    }
}

@end
