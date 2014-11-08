

//
//  Created by YeJian on 13-8-12.
//  Copyright (c) 2013年 YeJian. All rights reserved.
//

#define SysNavbarHeight 44

#define DefaultStateBarColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"stateBarColor.png"]]
#define DefaultStateBarSytle UIBarStyleBlackOpaque

#import <UIKit/UIKit.h>


@interface Navbar : UINavigationBar

 /**< 适用于ios7*/
@property (nonatomic,strong)UIColor *stateBarColor;/**< 默认black*/
@property (nonatomic,assign)UIBarStyle cusBarStyele;/**< 默认UIBarStyleBlackOpaque*/

- (void)setDefault;

@end




/**
 * @brief 自定义barbuttonitem
 *
 * @param
 * @return 
 */

#define TitleFont 18
#define TitleColor [UIColor whiteColor]

#define BackgroundImage @"top.png"
#define BackItemImage @"back_bar_button.png"
#define ItemImage @"bar_button_item.png"
#define BackItemSelectedImage @"back_bar_button_s.png"
#define ItemSelectedImage @"bar_button_item_s.png"

#define BackItemOffset UIEdgeInsetsMake(0, 5, 0, 0)
#define ItemLeftMargin 10
#define ItemWidth 52
#define ItemHeight SysNavbarHeight
#define ItemTextFont 12
#define ItemTextNormalColot [UIColor whiteColor]
#define ItemTextSelectedColot [UIColor colorWithWhite:0.7 alpha:1]


typedef enum {
    
    NavBarButtonItemTypeDefault = 0,
    NavBarButtonItemTypeBack = 1
    
}NavBarButtonItemType;


@interface NavBarButtonItem : NSObject
@property (nonatomic,assign)NavBarButtonItemType itemType;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)UIFont *font;
@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *selectedColor;
@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL selector;
@property (nonatomic,assign)BOOL highlightedWhileSwitch;

- (id)initWithType:(NavBarButtonItemType)itemType;

+ (id)defauleItemWithTarget:(id)target
                     action:(SEL)action
                      title:(NSString *)title;
+ (id)defauleItemWithTarget:(id)target
                     action:(SEL)action
                      image:(NSString *)image;
+ (id)backItemWithTarget:(id)target
                  action:(SEL)action
                   title:(NSString *)title;

- (void)setTarget:(id)target withAction:(SEL)action;


@end


@interface UINavigationItem (CustomBarButtonItem)

- (void)setNewTitle:(NSString *)title;
- (void)setNewTitleImage:(UIImage *)image;



- (void)setLeftItemWithTarget:(id)target
                       action:(SEL)action
                        title:(NSString *)title;
- (void)setLeftItemWithTarget:(id)target
                       action:(SEL)action
                        image:(UIImage *)image;
- (void)setLeftItemWithButtonItem:(NavBarButtonItem *)item;



- (void)setRightItemWithTarget:(id)target
                        action:(SEL)action
                         title:(NSString *)title;
- (void)setRightItemWithTarget:(id)target
                        action:(SEL)action
                         image:(UIImage *)image;
- (void)setRightItemWithButtonItem:(NavBarButtonItem *)item;



- (void)setBackItemWithTarget:(id)target
                       action:(SEL)action;
- (void)setBackItemWithTarget:(id)target
                       action:(SEL)action
                        title:(NSString *)title;

@end
