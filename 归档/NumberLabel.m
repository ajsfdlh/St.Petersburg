//
//  NumberLabel.m
//  St.Petersburg
//
//  Created by li on 14-4-23.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "NumberLabel.h"

@implementation NumberLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = @"";
        self.hidden=YES;
        self.font = [UIFont systemFontOfSize:12];
        self.textColor = [UIColor redColor];
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationBtnLab:) name:@"numberMessage" object:nil];
       // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationBtnLab:) name:@"number" object:nil];
    }
    return self;
}
//- (void)received:(NSNotification*)notfi{
//    NSLog(@"received %@",notfi.object);
//    if (![notfi.object isEqualToString:@"0"]) {
//        self.hidden = NO;
//        if ([notfi.object intValue]>99) {
//            _numberLabel.text = @"99";
//        }else {_numberLabel.text = notfi.object;
//            CGFloat widht = [_numberLabel optimumSize].width;
//            _numberLabel.frame = CGRectMake(0, 0, widht, 20);
//            _numberLabel.center = _IV.center;
//        }
//    }else self.hidden = YES;
//    
//}
- (void)notificationBtnLab:(NSNotification*)nf{
 //   NSLog(@"%@",nf.object);
    [self performSelectorOnMainThread:@selector(refresh:) withObject:nf waitUntilDone:YES];
}
- (void)refresh:(NSNotification*)nf{
    NSLog(@"%@",nf.object);
    if ([nf.object intValue]>0) {
        [self setText:[NSString stringWithFormat:@"(%@)",nf.object]];
        self.hidden=NO;
    }else self.hidden=YES;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
