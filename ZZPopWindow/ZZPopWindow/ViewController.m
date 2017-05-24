//
//  ViewController.m
//  ZZPopWindow
//
//  Created by liuweizhen on 2017/5/17.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "ViewController.h"
#import "ZZPopWindow.h"
#import "SecondController.h"
// #import <ZZPopWindow/ZZPopWindow.h>

@interface ViewController ()

@property (nonatomic) ZZPopWindow *popWindow;
@end

@implementation ViewController

- (IBAction)show1:(UIButton *)sender {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 200)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - CGRectGetMaxY(sender.frame) - 10)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1200)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionDown;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

- (IBAction)show2:(UIButton *)sender{
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width+100, 200)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 200)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionDown;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

- (IBAction)show3:(UIButton *)sender {
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width+100, 200)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 200)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1200)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionDown;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

- (IBAction)show4:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(sender.frame));
    
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width+100, 200)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 200)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1200)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionUp;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

- (IBAction)show5:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(sender.frame));
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width+100, 200)]; // 正常情况
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 200)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1200)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionUp;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

- (IBAction)show6:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(sender.frame));
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width+100, 200)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 200)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1200)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionUp;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

- (IBAction)present:(UIButton *)sender {
    SecondController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([SecondController class]) bundle:nil] instantiateInitialViewController];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
