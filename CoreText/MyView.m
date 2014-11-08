//
//  MyView.m
//  CoreText
//
//  Created by 刘 吕琴 on 14-2-20.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyView.h"
#define lableWidth 300.0
@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.font = 15;
        self.text = @"请给myview.text赋值";
        self.line = 10;
        self.paragraph = 20;
        self.character = 4;
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //创建AttributeStringfdsa
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                         initWithString:self.text];
    //创建字体以及字体大小
    CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica"), self.font, NULL);
    CTFontRef helveticaBold = CTFontCreateWithName(CFSTR("Helvetica"), self.font, NULL);
    //字体，把helvetica 样式加到整个，string上
    [string addAttribute:(id)kCTFontAttributeName
                   value:(__bridge id)helvetica
                   range:NSMakeRange(0, [string length])];
    
    //字体样式 ,把helveticaBold 样式加到整个，string上
    [string addAttribute:(id)kCTFontAttributeName
                   value:(__bridge id)helveticaBold
                   range:NSMakeRange(0, [string length])];
    
    //颜色,此处为黑色，你可以自己改颜色，[UIColor redColor]
    [string addAttribute:(id)kCTForegroundColorAttributeName
                   value:(id)[UIColor blackColor].CGColor
                   range:NSMakeRange(0, [string length])];
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTJustifiedTextAlignment;//对齐方
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    
    //设置字体间距
    long number = self.character;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [string length])];
    CFRelease(num);
    
    //创建文本,    行间距
    CGFloat lineSpace=self.line;//间距数据
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;
    lineSpaceStyle.valueSize=sizeof(lineSpace);
    lineSpaceStyle.value=&lineSpace;
    
    
    //设置  段落间距
    CGFloat paragraph = self.paragraph;
    CTParagraphStyleSetting paragraphStyle;
    paragraphStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphStyle.valueSize = sizeof(CGFloat);
    paragraphStyle.value = &paragraph;
    
    
    
    
    //创建样式数组
    CTParagraphStyleSetting settings[]={
        alignmentStyle,lineSpaceStyle,paragraphStyle
    };
    
    //设置样式
    CTParagraphStyleRef paragraphStyle1 = CTParagraphStyleCreate(settings, sizeof(settings));
    
    //给字符串添加样式attribute
    [string addAttribute:(id)kCTParagraphStyleAttributeName
                   value:(__bridge id)paragraphStyle1
                   range:NSMakeRange(0, [string length])];
    
    // layout master
    CTFramesetterRef  framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    //计算文本绘制size ，这里300是文字宽度，你可以自己更改为247，但是要记得，在height 方法里的这个位置，也改为247
    CGSize tmpSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), NULL, CGSizeMake(lableWidth, MAXFLOAT), NULL);
    //创建textBoxSize以设置view的frame
    CGSize textBoxSize = CGSizeMake((int)tmpSize.width + 1, (int)tmpSize.height + 1);
    //    NSLog(@"textBoxSize0  == %f,%f,%f",textBoxSize.width,textBoxSize.height,textBoxSize.width / textBoxSize.height);
    self.frame = CGRectMake(0, 0, textBoxSize.width , textBoxSize.height);
//    [string release];
    
    //- (void)drawRect:(CGRect)rect;代码
    
    
    
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL,
                  CGRectMake(0, 0,
                             self.bounds.size.width,
                             self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,
                                                    CFRangeMake(0, 0),
                                                    leftColumnPath, NULL);
    
    //    NSLog(@"textBoxSize1  == %f,%f",self.frame.size.width,self.frame.size.height);
    // flip the coordinate system
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextClearRect(context, self.frame);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor]CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 320, self.frame.size.height));
    
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // draw
    CTFrameDraw(leftFrame, context);
    
    // cleanup
    
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    //CFRelease(helvetica);
    // CFRelease(helveticaBold);
    
    UIGraphicsPushContext(context);
    
    
}
#pragma mark  - 计算高度的方法
//这个方法，剪切到你要用的那个类里面，就ok了
// 或者，就放这里，但改成实例方法，+(CGSize)height:^^^^^^^^^
+(CGSize)height:(NSString *)text Font:(CGFloat)font Character:(CGFloat)character Line:(CGFloat)line Pragraph:(CGFloat)pragraph
{
    
    //创建AttributeStringfdsa
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    //创建字体以及字体大小
    CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica"), font, NULL);
    CTFontRef helveticaBold = CTFontCreateWithName(CFSTR("Helvetica"), font, NULL);
    //添加字体目标字符串从下标0开始到字符串结尾
    [string addAttribute:(id)kCTFontAttributeName
                   value:(__bridge id)helvetica
                   range:NSMakeRange(0, [string length])];
    
    //添加字体目标字符串从下标0开始，截止到4个单位的长度
    [string addAttribute:(id)kCTFontAttributeName
                   value:(__bridge id)helveticaBold
                   range:NSMakeRange(0, [string length])];
    
    
    [string addAttribute:(id)kCTForegroundColorAttributeName
                   value:(id)[UIColor whiteColor].CGColor
                   range:NSMakeRange(0, [string length])];
    
    CTTextAlignment alignment = kCTJustifiedTextAlignment;//这种对齐方式会自动调整，使左右始终对齐
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    
    //设置字体间距
    long number = character;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [string length])];
    CFRelease(num);
    
    
    
    //创建文本行间距
    CGFloat lineSpace=line;//间距数据
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
    lineSpaceStyle.valueSize=sizeof(lineSpace);
    lineSpaceStyle.value=&lineSpace;
    
    //设置段落间距
    CGFloat paragraph = pragraph;
    CTParagraphStyleSetting paragraphStyle;
    paragraphStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphStyle.valueSize = sizeof(CGFloat);
    paragraphStyle.value = &paragraph;
    
    
    //创建样式数组
    CTParagraphStyleSetting settings[]={
        alignmentStyle,lineSpaceStyle,paragraphStyle
    };
    
    //设置样式
    CTParagraphStyleRef paragraphStyle1 = CTParagraphStyleCreate(settings, sizeof(settings));
    
    //给字符串添加样式attribute
    [string addAttribute:(id)kCTParagraphStyleAttributeName
                   value:(__bridge id)paragraphStyle1
                   range:NSMakeRange(0, [string length])];
    
    // layout master
    CTFramesetterRef  framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    //计算文本绘制size
    CGSize tmpSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), NULL, CGSizeMake(lableWidth, MAXFLOAT), NULL);
    //创建textBoxSize以设置view的frame
    CGSize textBoxSize = CGSizeMake((int)tmpSize.width + 1, (int)tmpSize.height + 1);
    
//    [string release];
    
    return textBoxSize;
    
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
