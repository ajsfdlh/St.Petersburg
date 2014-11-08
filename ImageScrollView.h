//
//  ImageScrollView.h
//  ScrollViewPropertyDemo
//
//  Created by jack.fan on 13-8-26.
//  Copyright (c) 2013年 fan xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView<UIScrollViewDelegate>
{
@private
    UIImageView *_imageView;
}
@property (nonatomic,retain) UIImageView *imageView;
@property(nonatomic, assign) NSTimeInterval touchTimer;
@end
