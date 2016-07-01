//
//  ViewController.m
//  snow
//
//  Created by beginner on 16/7/1.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "ViewController.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define IMAGE_X                arc4random()%(int)Main_Screen_Width  //snow 的下落点
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10//0.0~0.9 snow 透明度
#define IMAGE_WIDTH            arc4random()%20 + 10         //10~29   snow 宽度


@interface ViewController () {
    NSMutableArray *imageArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    imageArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 30; ++ i ) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snow"]];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, - 30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [imageArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(makeShow) userInfo:Nil repeats:YES];

    // Do any additional setup after loading the view, typically from a nib.
}

static int snowTag = 0;
- (void)makeShow {
    snowTag = snowTag + 1;
    if ([imageArray count] > 0) {
        UIImageView *imageView = [imageArray objectAtIndex:0];
        imageView.tag = snowTag;
        [imageArray removeObjectAtIndex:0];
        [self showFall:imageView];
    }
}

//下雪的动画
- (void)showFall:(UIImageView *)ImageVeiw {
    [UIView beginAnimations:[NSString stringWithFormat:@"%d",ImageVeiw.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    ImageVeiw.frame = CGRectMake(ImageVeiw.frame.origin.x, Main_Screen_Height, ImageVeiw.frame.size.width, ImageVeiw.frame.size.height);
    [UIView commitAnimations];
}

//动画完成后的方法
- (void)animationDidStop:(NSString *)animationID {
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, - 30, x, x);
    [imageArray addObject:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
