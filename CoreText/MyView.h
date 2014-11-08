//
//  MyView.h
//  CoreText
//
//  Created by 刘 吕琴 on 14-2-20.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"

@interface MyView : UIView
@property(nonatomic,retain)NSString *text; //要画的文字

@property(nonatomic,assign)CGFloat font; //字体大小

@property(nonatomic,assign)CGFloat character; //字间距

@property(nonatomic,assign)CGFloat line; //行间距

@property(nonatomic,assign)CGFloat paragraph;//段落间距
+(CGSize)height:(NSString *)text Font:(CGFloat)font Character:(CGFloat)character Line:(CGFloat)line Pragraph:(CGFloat)pragraph;
@end
