//
//  ViewController.m
//  4.1时钟4.1
//
//  Created by 邓金明 on 16/4/1.
//  Copyright © 2016年 邓金明. All rights reserved.
//

#import "ViewController.h"
//每一秒转6度
#define perSecondA 6

//每一分钟转多少度
#define perMinuteA 6

//一小时转多少度
#define perHourA 30

//一分钟时针转多少度
#define perMinuteHourA 0.5

//角度转弧度
#define angle2randian(a) ((a) / 180.0 * M_PI)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property (nonatomic,weak) CALayer *second;

@property (nonatomic,weak) CALayer *minute;

@property (nonatomic,weak) CALayer *hour;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSecond];
    
    [self addMinute];
    
    [self addHour];
    //这种方法会跟屏幕刷新的时间不同，会慢一点
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    //下面这种解决快慢问题，与屏幕刷新一致
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self updateTime];
}

//每一秒更新时间
-(void)updateTime{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cpm = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    CGFloat second = cpm.second;
    
    CGFloat minute = cpm.minute;
    
    CGFloat hour = cpm.hour;
    
    CGFloat secondA = angle2randian(second * perSecondA);
    
    CGFloat minuteA = angle2randian(minute * perMinuteA);
    
    
    CGFloat hourA = angle2randian(hour * perHourA);
    
    hourA += angle2randian(minute * perMinuteHourA);
    
    self.second.transform = CATransform3DMakeRotation(secondA, 0, 0, 1);
    
    self.minute.transform = CATransform3DMakeRotation(minuteA, 0, 0, 1);
    
    self.hour.transform = CATransform3DMakeRotation(hourA, 0, 0, 1);
    
}

//添加秒针
-(void)addSecond{
    
    CGFloat w = self.clockView.bounds.size.width;
    CGFloat h = self.clockView.bounds.size.height;
    
    
    CALayer *second = [CALayer layer];
    self.second = second;
    second.frame = CGRectMake(0, 0, 1, 85);
    
    second.anchorPoint = CGPointMake(0.5, 1);
    second.position =CGPointMake(w * 0.5, h *0.5);
    
    second.backgroundColor = [UIColor redColor].CGColor;
    
    [self.clockView.layer addSublayer:second];
    
}
//添加分针
-(void)addMinute{
    
    CGFloat w = self.clockView.bounds.size.width;
    CGFloat h = self.clockView.bounds.size.height;
    
    
    CALayer *minute = [CALayer layer];
    self.minute = minute;
    minute.frame = CGRectMake(0, 0, 2, 80);
    
    minute.anchorPoint = CGPointMake(0.5, 1);
    minute.position =CGPointMake(w * 0.5, h *0.5);
    
    minute.backgroundColor = [UIColor blackColor].CGColor;
    
    [self.clockView.layer addSublayer:minute];
    
}
//添加秒针
-(void)addHour{
    
    CGFloat w = self.clockView.bounds.size.width;
    CGFloat h = self.clockView.bounds.size.height;
    
    
    CALayer *hour = [CALayer layer];
    self.hour = hour;
    hour.frame = CGRectMake(0, 0, 4, 44);
    
    hour.anchorPoint = CGPointMake(0.5, 1);
    hour.position =CGPointMake(w * 0.5, h *0.5);
    
    hour.backgroundColor = [UIColor blackColor].CGColor;
    
    [self.clockView.layer addSublayer:hour];
    
}
@end
