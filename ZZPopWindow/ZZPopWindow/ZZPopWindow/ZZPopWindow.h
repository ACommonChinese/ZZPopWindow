//
//  ZZPopWindow.h
//  ZZPopWindow
//
//  Created by liuweizhen on 2017/5/17.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZPositionList.h"

@interface ZZPopWindow : UIWindow

/**
 *  The popover animation show in duration, default is 0.25;
 *  pop显示的动画时间，默认0.25秒
 */
@property (nonatomic) CGFloat animationIn;

/**
 *  The popover animation dismiss duration, default is 0.0;
 *  pop消失的动画时间，默认0.0秒
 */
@property (nonatomic) CGFloat animationOut;

/**
 *  If the drop in animation using spring animation, default is YES;
 *  是否采用spring animation动画(iOS7.0之后出来的一种弹簧动画效果)，默认是YES
 */
@property (nonatomic) BOOL animationSpring;

/**
 *  The content view of user
 *  内容视图
 */
@property (nonatomic, weak) UIView *contentView;

/**
 *  The content view's position relative to arrow
 *  内容视图在箭头的哪边(方向)
 */
@property (nonatomic) ZZPopPosition popPosition;

/**
 *  The callback when popover did show in the containerView
 *  popover在containerView上显示出来后的回调
 */
@property (nonatomic, copy) dispatch_block_t didShowHandler;

/**
 *  The callback when popover did dismiss in the containerView
 *  popover在containerView上消失后的回调
 */
@property (nonatomic, copy) dispatch_block_t didDismissHandler;

/**
 * The position list object
 * 方向列表对象
 */
@property (nonatomic, readonly) ZZPositionList *positionList;

/**
 Enable force reset content view's frame or not(ie, if the content view beyond superview's bounds, change it), default is YES
 是否允许强制更改尺寸（contentView's frame越界，截断）default is YES
 */
@property (nonatomic) BOOL enableForceReset;

- (void)showAtView:(UIView *)atView;
- (void)dismiss;

@end
