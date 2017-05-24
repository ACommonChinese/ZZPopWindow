//
//  SecondController.m
//  ZZPopWindow
//
//  Created by liuweizhen on 2017/5/20.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "SecondController.h"
#import "ZZPopWindow.h"

@interface SecondController ()

@property (nonatomic) ZZPopWindow *popWindow;
@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 向右
- (IBAction)click_1:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(sender.frame));
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 340)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-CGRectGetMaxX(sender.frame) - 20, 400)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - CGRectGetMaxY(sender.frame) - 10)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 735)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionRight;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

// 向右-偏上
- (IBAction)click_2:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(sender.frame));
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, -100, 100, 340)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-CGRectGetMaxX(sender.frame) - 20, 400)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - CGRectGetMaxX(sender.frame) - 10, self.view.frame.size.height - CGRectGetMaxX(sender.frame) - 10)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 735)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionRight;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

// 向右-偏下
- (IBAction)click_3:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(sender.frame));
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]; // 正常情况
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 500)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-CGRectGetMaxX(sender.frame) - 20, 400)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - CGRectGetMaxX(sender.frame) - 10, self.view.frame.size.height - CGRectGetMaxX(sender.frame) - 10)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 735)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionRight;
    [self.popWindow showAtView:sender];
    
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

// 向左
- (IBAction)click_4:(UIButton *)sender {
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 500)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2000, 400)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - CGRectGetMaxX(sender.frame) - 10)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.bounds.size.height)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionLeft;
    [self.popWindow showAtView:sender];
}

// 向左-偏上
- (IBAction)click_5:(UIButton *)sender {
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 500)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2000, 400)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.frame.size.height - CGRectGetMaxX(sender.frame) - 10)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.bounds.size.height)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionLeft;
    [self.popWindow showAtView:sender];
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

// 向左-偏下
- (IBAction)click_6:(UIButton *)sender {
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]; // 正常情况
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 500)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2000, 400)];
    // UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.frame.size.height - CGRectGetMaxX(sender.frame) - 10)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 169, self.view.bounds.size.height)];
    contentView.backgroundColor = [UIColor redColor];
    self.popWindow = [[ZZPopWindow alloc] init];
    self.popWindow.contentView = contentView;
    self.popWindow.popPosition = ZZPopPositionLeft;
    [self.popWindow showAtView:sender];
    NSLog(@"%@", NSStringFromCGRect(self.popWindow.contentView.frame));
}

@end
