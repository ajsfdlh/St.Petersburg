//
//  NumberView.m
//  button
//
//  Created by li on 14-4-1.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "NumberView.h"
#import "RTLabel.h"
@implementation NumberView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    self.hidden=YES;
    UIImage *image = [UIImage imageNamed:@"number"];
   _IV = [[UIImageView alloc]initWithFrame:self.bounds];
    //iv.backgroundColor = [UIColor blackColor];
    //iv.center = self.center;
        // _IV.hidden=YES;
    _IV.image = image;
    [self addSubview:_IV];
        
        _numberLabel = [[RTLabel alloc]init];
        _numberLabel.text = @"0";
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = [UIFont boldSystemFontOfSize:13];
        _numberLabel.textAlignment = kCTCenterTextAlignment;
       // _numberLabel.backgroundColor = [UIColor grayColor];
        CGFloat widht = [_numberLabel optimumSize].width;
        _numberLabel.frame = CGRectMake(0, 10, widht, 20);
        
        _numberLabel.center = _IV.center;
        [_IV addSubview:_numberLabel];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(received:) name:@"number" object:nil];
    }
    return self;
}

- (void)received:(NSNotification*)notfi{
    //NSLog(@"received %@",notfi.object);
    if (![notfi.object isEqualToString:@"0"]&&notfi.object!=nil) {
        self.hidden = NO;
        
        if ([notfi.object intValue]>99) {
    
            _numberLabel.text = @"99";
            
        }else {
    
        _numberLabel.text = notfi.object;
            
    
    
        }
        CGFloat widht = [_numberLabel optimumSize].width;
        _numberLabel.frame = CGRectMake(0, 10, widht+10, 20);
        _numberLabel.textAlignment = kCTCenterTextAlignment;
        _numberLabel.center = _IV.center;
    }else

        self.hidden = YES;

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
