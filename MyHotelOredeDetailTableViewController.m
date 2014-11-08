//
//  MyHotelOredeDetailTableViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyHotelOredeDetailTableViewController.h"
#import "MyHotelOredeDetailCell.h"
#import "json.h"
#import "GDataXMLNode.h"
#import "EntainDetailViewController.h"
#import "OrderViewController.h"

@interface MyHotelOredeDetailTableViewController ()

@end

@implementation MyHotelOredeDetailTableViewController
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor* color = [UIColor colorWithRed:237/255 green:237/255 blue:237/255 alpha:0];
    self.headView.backgroundColor = color;
    self.footerView.backgroundColor = color;
    
    self.title = @"订单详情";
    _tableArr = [NSMutableArray array];
    NSString *peopleinfo = _currentDic[@"Peopleinfo"];
//    NSLog(@"_currentDic:%@",_currentDic);
    for (NSString *firstStr in [peopleinfo componentsSeparatedByString:@"|"]) {
        [_tableArr addObject:[firstStr componentsSeparatedByString:@","]];
    }
    _headView.frame = CGRectMake(0, 0, 320, 450);
    self.tableView.tableHeaderView=_headView;
    [self headViewModelData];
    _footerView.frame = CGRectMake(0, 0, 320, 250);//250 + 40
    self.tableView.tableFooterView=_footerView;
    [self footerViewModelData];
    NSLog(@"_currentDic  %@",_currentDic);
    
}
- (void)headViewModelData{
    _headIV.image = _headImage;
    _priceLab.attributedText = _priceStr;
    _payWayLab.text = _payStr;
    _subheadLab.text = _subheadStr;
    
    _orderNumLab.text = _currentDic[@"OrderID"];
    _orderTimeLab.text = _currentDic[@"PTime"];
    _statusLab.text = _currentDic[@"Status"];
    _russualTitleLab.text = _currentDic[@"HotelRUName"];
    _chineseTitleLab.text = _currentDic[@"HotelCNName"];
    _maxCheckInCountLab.text = [NSString stringWithFormat:@"%@人",_currentDic[@"MoneyType"]];
    _roomFacilityLab.text = _currentDic[@"Other"];
    _checkInDateLab.text = [self changeDateFormatter:_currentDic[@"Indate"]];
    _checkOutDateLab.text = [self changeDateFormatter:_currentDic[@"Outdate"]];
    _roomCountLab.text = [NSString stringWithFormat:@"%@间",_currentDic[@"RCount"]];
    
}
- (NSString*)changeDateFormatter:(NSString*)dateStr{
    NSDateFormatter *formatter2 = [NSDateFormatter new];
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM月dd日"];
    return [formatter stringFromDate:[formatter2 dateFromString:dateStr]];
}
-(void)footerViewModelData{
    
    _nemeLab.text = _currentDic[@"Uname"];
    _telephoneNumLab.text = _currentDic[@"Phone"];
    _mailLab.text = _currentDic[@"Email"];
    _QQLab.text = _currentDic[@"QQ"];
    _weixinLab.text = _currentDic[@"Weixin"];
    _goSecondButton = [[UIButton alloc]initWithFrame:CGRectMake(125,self.footerView.frame.size.height + self.headView.frame.size.height + 80*_tableArr.count + 10, 70, 30)];
    _goSecondButton.layer.cornerRadius=5;
    _goSecondButton.layer.masksToBounds = YES;
    _goSecondButton.backgroundColor = [UIColor colorWithRed:12.0/255 green:87.0/255 blue:170.0/255 alpha:1];
    [self.view addSubview:_goSecondButton];
    [_goSecondButton addTarget:self action:@selector(clickGoSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    [_goBtn addTarget:self action:@selector(clickGoSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([_statusLab.text isEqualToString:@"待支付"]) {
        [_goBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _statusLab.textColor = [UIColor redColor];
        _goBtn.hidden=NO;
        [_goSecondButton setTitle:@"去支付" forState:UIControlStateNormal];
        _footerBarView.hidden=NO;
    }else if ([_statusLab.text isEqualToString:@"已取消"]||[_statusLab.text isEqualToString:@"已失效"]){
        _statusLab.textColor = [UIColor grayColor];
        [_goSecondButton setTitle:@"重新预订" forState:UIControlStateNormal];
        _footerBarView.hidden=NO;
    }else if ([_statusLab.text isEqualToString:@"已完成"]){
        _statusLab.textColor = [UIColor blueColor];
        [_goSecondButton setTitle:@"去点评" forState:UIControlStateNormal];
        _footerBarView.hidden=NO;
    }else {
        _statusLab.textColor = [UIColor blueColor];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _tableArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    MyHotelOredeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHotelOredeDetailCell" owner:self options:nil] lastObject];
    }
    cell.XingLab.text = _tableArr[indexPath.row][0];
    cell.MingLab.text = _tableArr[indexPath.row][1];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/
- (void)clickGoSecondButton:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"取消订单"]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSMutableString *urlStr =RussiaUrl4;
            [urlStr appendString:@"CanselOrder"];
            //orderid：订单ID，prodclass：1线路、2景点、3酒店、4门票、5导游、6租车
            NSString *argumentStr = [NSMutableString stringWithFormat:@"orderid=%@&prodclass=%@",_currentDic[@"ID"],@"3"];
            NSLog(@"%@",argumentStr);
            postRequestTongBu(argumentStr, urlStr, received)
            dicResultTongbuNoDic(received, result)
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result.length>0) {
                    [_statusLab setText:@"已取消"];
                    [_statusLab setTextColor:[UIColor grayColor]];
                    _goBtn.hidden=YES;
                    [_goSecondButton setTitle:@"重新预订" forState:UIControlStateNormal];
                }else{
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"取消失败。" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: @"确定",nil];
                    [av show];
                }
            });
        });
    }else if ([sender.currentTitle isEqualToString:@"去支付"]) {
        OrderViewController* ovc = [OrderViewController sharedOrderViewController];
        ovc.presentWay = 2;
        ovc.prodClass = 3;
        ovc.orderNumber = _orderNumLab.text;
        ovc.productDescription = self.roomFacilityLab.text;
        ovc.mhodTVC = self;
        ovc.productName = [NSString stringWithFormat:@"%@ %@", self.chineseTitleLab.text, self.subheadLab.text];
        [self.navigationController pushViewController:ovc animated:NO];
    }else if ([sender.currentTitle isEqualToString:@"重新预订"]) {
        EntainDetailViewController* entainDetailVC = [EntainDetailViewController new];
        entainDetailVC.hotelID = self.hotelID;
        entainDetailVC.navName = @"酒店介绍";
        [self.navigationController pushViewController:entainDetailVC animated:YES];
    }
}
@end
