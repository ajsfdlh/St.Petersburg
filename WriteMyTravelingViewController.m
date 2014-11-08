//
//  WriteMyTravelingViewController.m
//  St.Petersburg
//
//  Created by kirem-peter on 14-10-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "WriteMyTravelingViewController.h"
#import "GCPlaceholderTextView.h"

@interface WriteMyTravelingViewController ()

@property (nonatomic, retain)UIView* addPictureView;
@property (nonatomic, assign)float statusHeight;
@property (nonatomic, assign)float navigationBarHeight;
@property (nonatomic, retain)GCPlaceholderTextView* textView;
@property (nonatomic, retain)UIImageView* imageView;

@end

@implementation WriteMyTravelingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

backButton  //自定义返回按钮

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发布游记";
    
    //添加监听键盘弹起和隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    UIButton *backbutton = [[UIButton alloc]init];
    backbutton.frame=CGRectMake(0, 5, 46, 26);
    backbutton.layer.masksToBounds = YES;
    [backbutton.layer setCornerRadius:4];
    [backbutton setBackgroundColor:[UIColor colorWithRed:0.37 green:0.69 blue:0.95 alpha:1]];
    [backbutton addTarget:self action:@selector(saveTraveling) forControlEvents:UIControlEventTouchUpInside];
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(8, -5, 40, 35)];
    lable.font=[UIFont systemFontOfSize:15];
    lable.textColor=[UIColor whiteColor];
    lable.text=@"保存";
    [backbutton addSubview:lable];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    self.navigationItem.rightBarButtonItem =backItem;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGRect frame = CGRectMake(0, 10, self.view.bounds.size.width, 40);
    UIView* titleView = [[UIView alloc]initWithFrame:frame];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    UITextField* textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 40)];
    textField.placeholder = @"填写标题";
    [titleView addSubview:textField];
    self.titleTF = textField.text;
    
    
    self.statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    float contentViewHeight = self.view.bounds.size.height - self.statusHeight - self.navigationBarHeight - 10 - 40 - 10 - 40;
    UIView* contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+40+10, self.view.bounds.size.width, contentViewHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    self.textView = [[GCPlaceholderTextView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, contentViewHeight)];
    self.textView.placeholder = @"游记内容";
    self.textView.font = [UIFont systemFontOfSize:17];
    
    [contentView addSubview:self.textView];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.addPictureView = [[UIView alloc]init];
    [self changeAddPictureViewHeight:0];
    [self.view addSubview:self.addPictureView];
    //拍照按钮
    UIButton* shootPictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.addPictureView.frame.size.width - 25 - 41 - 25 - 41, 3, 41, 34)];
    [shootPictureBtn setImage:[UIImage imageNamed:@"take_photos.png"] forState:UIControlStateNormal];
    [shootPictureBtn addTarget:self action:@selector(shootPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.addPictureView addSubview:shootPictureBtn];
    //选择相册按钮
    UIButton* pickPictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.addPictureView.frame.size.width - 25 - 41, 3, 41, 34)];
    [pickPictureBtn setImage:[UIImage imageNamed:@"picture.png"] forState:UIControlStateNormal];
    [pickPictureBtn addTarget:self action:@selector(pickPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.addPictureView addSubview:pickPictureBtn];
    
}

//根据键盘改变addPictureView的高度
-(void)changeAddPictureViewHeight:(float) keyboardHeight
{
    if (keyboardHeight) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.addPictureView.frame = CGRectMake(0, self.view.bounds.size.height - 40 - keyboardHeight, self.view.bounds.size.width, 40);
        } completion:nil];
        
    }else {
        self.addPictureView.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
//         - self.statusHeight - self.navigationBarHeight
    }
    
}

#pragma saveTraveling
-(void)saveTraveling
{

    NSLog(@"保存");
    
}

-(void)shootPicture
{
    UIImagePickerController* ipc = [[UIImagePickerController alloc]init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:ipc animated:YES completion:nil];
    
}

-(void)pickPicture
{
    UIImagePickerController* ipc = [[UIImagePickerController alloc]init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:ipc animated:YES completion:nil];
    
}
#pragma pickPicture
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.imageView.image = image;
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.imageView.frame];
    self.textView.textContainer.exclusionPaths = @[path];
    [self.textView addSubview:self.imageView];
    
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self addPictures];
    [self.textView becomeFirstResponder];
    NSLog(@"%@",self.textView.text);
}

//选择完照片后添加到textView中
-(void)addPictures {
    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyboardDidShow:(NSNotification*) notification
{
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    [self changeAddPictureViewHeight:keyboardRect.size.height];
    
}

-(void)keyboardDidHidden:(NSNotification*) notification
{
    [self changeAddPictureViewHeight:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
