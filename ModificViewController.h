//
//  ModificViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blockFun)(NSString*text);
@interface ModificViewController : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate,UITextViewDelegate>
{
        UIView*phone;
        NSMutableData*datas;
        blockFun myBlock;
    UITextField *textFieldName;
    UITextView*textViw;
}
@property(assign,nonatomic)int useID;
@property(nonatomic,strong)NSString*pageTitle;
@property(nonatomic,copy)NSString*phoneNum;
@property(copy,nonatomic)NSString*mailNum;
-(void)setBlock:(blockFun)aBlock;
@property(assign,nonatomic)int tag;

@end
