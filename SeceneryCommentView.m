//
//  SeceneryCommentView.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-15.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SeceneryCommentView.h"

@interface SeceneryCommentView ()

@end

@implementation SeceneryCommentView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"文字讲解"];
    
    self.view.backgroundColor=GroupColor;
    
    
    HPGrowingTextView*textView=[[HPGrowingTextView alloc]initWithFrame:CGRectMake(0, 10, 320, 100)];
    textView.placeholder=@"500字以内";
    textView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:textView];

    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 80)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, 320, 70)];
    [view addSubview:_scrollView];
    
   
    
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(8, 0, 70, 70);
   [button setImage:[UIImage imageNamed:@"blueBackGround.png"] forState:UIControlStateNormal];
    [_scrollView addSubview:button];
    [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
     NSLog(@"_scrollView.subviews==%@",_scrollView.subviews);
    
    
    
    UIButton*location=[UIButton buttonWithType:UIButtonTypeCustom];
    location.frame=CGRectMake(10, 220, 200, 15);
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    imageView.image=[UIImage imageNamed:@"secenery_location.png"];
    [location addSubview:imageView];
    
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(17, 0, 180, 15)];
    lable.text=@"圣彼得堡5号大街";
    lable.font=[UIFont systemFontOfSize:15];
    lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    [location addSubview:lable];
    [self.view addSubview:location];
    
//    UILabel*commentGrade=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
//    commentGrade.text=@"给TA评分：";
//    commentGrade.font=[UIFont boldSystemFontOfSize:15];
//    [self.view addSubview:commentGrade];
//    
//    for (int i=0; i<5; i++)
//    {
//        
//        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag=20+i;
//        button.frame=CGRectMake(commentGrade.frame.origin.x+commentGrade.frame.size.width+5+35*i, 15, 30, 30);
//        [button setImage:[UIImage imageNamed:@"commentStar.png"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(commentStar:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//        
//    }

    
    
    
	// Do any additional setup after loading the view.
}
-(void)commentStar:(UIButton*)sender
{

    for (int i=0; i<=sender.tag-20; i++)
    {
        UIButton*button=(UIButton*)[self.view viewWithTag:20+i];
        [button setImage:[UIImage imageNamed:@"commentStar_h.png"] forState:UIControlStateNormal];
    }
    for (int i=sender.tag-20+1; i<=5; i++)
    {
        UIButton*button=(UIButton*)[self.view viewWithTag:20+i];
        [button setImage:[UIImage imageNamed:@"commentStar.png"] forState:UIControlStateNormal];
    }

}
- (void)openPhotoLlibrary:(UIButton*)sender
{
  
    self._button=sender;
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
//        picker.allowsEditing = YES; //是否可编辑
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
           }
        else
           {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}
//选中图片进入的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self._button setImage:image forState:UIControlStateNormal];
    [self dismissModalViewControllerAnimated:YES];
    
    if (_scrollView.subviews.count<8)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(self._button.frame.origin.x+78, 0, 70, 70);
        [button setImage:[UIImage imageNamed:@"blueBackGround.png"] forState:UIControlStateNormal];
        [_scrollView addSubview:button];
        [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        _scrollView.contentSize=CGSizeMake(self._button.frame.origin.x+78+78, 70);
        if (_scrollView.subviews.count>6)
        {
            [UIView animateWithDuration:0.2f animations:^{
                _scrollView.contentOffset=CGPointMake(78*(_scrollView.subviews.count-6), 0);
                
            }];
            
        }
        
        NSLog(@"_scrollView.subviews==%@",_scrollView.subviews);
        
    }
    NSLog(@"---%d",_scrollView.subviews.count);

    
}

-(void)touch:(UIButton*)sender
{

    if (sender.currentImage==[UIImage imageNamed:@"blueBackGround.png"])
    {
//        [sender setImage:[UIImage imageNamed:@"123.jpg"] forState:UIControlStateNormal];
        [self openPhotoLlibrary:sender];
        
    }
   else
   {
//        int a=[_scrollView.subviews indexOfObject:sender];
//       NSLog(@"a======%d",a);
      
       
       int a=[_scrollView.subviews indexOfObject:sender];
        [sender removeFromSuperview];
       NSLog(@"a===%d",a);

            NSLog(@"---%d",_scrollView.subviews.count);
       
       NSLog(@"_scrollView.subviews==%@",_scrollView.subviews);
       [UIView animateWithDuration:0.2 animations:^{
           for (int i=a; i<_scrollView.subviews.count; i++)
           {
               if ([[_scrollView.subviews objectAtIndex:i] isMemberOfClass:[UIButton class]])
               {
                   UIButton*button=[_scrollView.subviews objectAtIndex:i];

                    button.frame=CGRectMake(button.frame.origin.x-78, button.frame.origin.y, 70, 70);
               }
              
               
           }
           
           
         
           
       }];

       
       int j=_scrollView.subviews.count-1;
       for ( ; j>=0; j--)
       {
           if ([[_scrollView.subviews objectAtIndex:j]isMemberOfClass:[UIButton class]])
           {
               break;
           }
       }
        UIButton*but=[_scrollView.subviews objectAtIndex:j];
       
       if ([but currentImage]!=[UIImage imageNamed:@"blueBackGround.png"])
       {
           UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
           button.frame=CGRectMake(but.frame.origin.x+78, 0, 70, 70);
           [button setImage:[UIImage imageNamed:@"blueBackGround.png"] forState:UIControlStateNormal];
           [_scrollView addSubview:button];
           [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
         

       }
//       else
//       {
//           if (_scrollView.subviews.count>6)
//           {
//               [UIView animateWithDuration:0.2f animations:^{
//                   _scrollView.contentOffset=CGPointMake(78*(_scrollView.subviews.count-8), 0);
//                   
//               }];
//
//           }
//         
//       
//       }
       
       int k=_scrollView.subviews.count-1;
       for ( ; k>=0; k--)
       {
           if ([[_scrollView.subviews objectAtIndex:k]isMemberOfClass:[UIButton class]])
           {
               break;
           }
       }
       UIButton*butt=[_scrollView.subviews objectAtIndex:k];

       
         _scrollView.contentSize=CGSizeMake(butt.frame.origin.x+78+78, 70);
       
    
           
   }
    
//       }
//       else
//       {
//           int a=[_scrollView.subviews indexOfObject:sender];
//           [sender removeFromSuperview];
//           NSLog(@"nnnnnnn");
//       [UIView animateWithDuration:0.2 animations:^{
//           for (int i=a+1; i<_scrollView.subviews.count; i++)
//           {
//               UIButton*button=[_scrollView.subviews objectAtIndex:i];
//               button.frame=CGRectMake(button.frame.origin.x-78, button.frame.origin.y, 70, 70);
//               
//           }
//
//       }];
//           
//       
//       }
//
//   
//   }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
