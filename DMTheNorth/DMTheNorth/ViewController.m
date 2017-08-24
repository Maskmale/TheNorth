//
//  ViewController.m
//  DMTheNorth
//
//  Created by Maskmale on 2017/8/22.
//  Copyright © 2017年 Maskmale. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *compassView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *compassViewW;

// 位置管理者
@property(nonatomic, strong) CLLocationManager *lm;
@end

@implementation ViewController

-(CLLocationManager *)lm
{
    if (!_lm)
    {
        _lm = [[CLLocationManager alloc] init];
        _lm.delegate = self;
        
        // 精度
        _lm.headingFilter = 1;
    }
    return _lm;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 屏幕适配
    [self ScreenAdaptation];
    // 监听设备朝向
    [self.lm startUpdatingHeading];

}

//设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - ScreenAdaptation
-(void)ScreenAdaptation
{
    // 获取屏幕高度
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"%f",height);
    
    // 根据设备屏幕高度设置 compassViewW
    if (height <= 480)
    {
        NSLog(@"i4");
    }
    else if (height <= 568)
    {
        NSLog(@"i5");
        CGFloat WH = 20;
        _compassViewW.constant -= WH;
    }
    else if (height <= 667)
    {
        NSLog(@"i6");
        CGFloat WH = 10;
        _compassViewW.constant += WH;
    }
    else if (height <= 960)
    {
        NSLog(@"i6P");
        CGFloat WH = 36;
        _compassViewW.constant += WH;
    }
}

#pragma mark - CLLocationManagerDelegate
/**
 *  获取到手机朝向时调用
 *
 *  @param manager    位置管理者
 *  @param newHeading 朝向对象
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /**
     *  CLHeading
     *  magneticHeading : 磁北角度
     *  trueHeading : 真北角度
     */
    
    NSLog(@"%f", newHeading.magneticHeading);
    CGFloat radian = newHeading.magneticHeading;
    
    CGFloat radianAngle = radian / 180.0 * M_PI;
    
    // 根据 radianAngle 旋转 compass 指针
    [UIView animateWithDuration:0.25 animations:^
    {
        self.compassView.transform = CGAffineTransformMakeRotation(-radianAngle);
    }];
}

@end
