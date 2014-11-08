//
//  SeceneryCommentView.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-15.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
@interface SeceneryCommentView : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView*_scrollView;
    int tag;

}
@property(nonatomic,strong)UIButton*_button;
@end
