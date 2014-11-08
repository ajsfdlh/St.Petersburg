//
//  TouchTableView.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-7.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;


@end
@interface TouchTableView : UITableView<TouchTableViewDelegate>
{
   @private
    id  touchDelegate;
}

@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;
@end
