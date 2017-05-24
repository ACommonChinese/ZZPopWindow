//
//  ZZPositionList.h
//  ZZPopWindow
//
//  Created by liuweizhen on 2017/5/17.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  弹框在控件的哪个位置
 */
typedef NS_ENUM(NSInteger, ZZPopPosition) {
    /**
     *  任意方向，优先次序：下上右左 ZZPopoverWindowPositionDown
     */
    ZZPopPositionAny = 1,
    /**
     *  弹框在控件下方，默认值
     */
    ZZPopPositionDown,
    /**
     *  弹框在控件上方
     */
    ZZPopPositionUp,
    /**
     *  弹框在控件右侧
     */
    ZZPopPositionRight,
    /**
     *  弹框在控件左侧
     */
    ZZPopPositionLeft,
};


@interface ZZPosition : NSObject

@property (nonatomic) ZZPopPosition position;
@property (nonatomic) BOOL fail;

- (instancetype)initWithPopPosition:(ZZPopPosition)p;

@end

////////////////////////////////////////////////////////////////////////

/** 方向列表对象 */
@interface ZZPositionList : NSObject
/** 方向数组 */
@property (nonatomic) NSArray<ZZPosition *> *list;
/** 下方向 */
@property (nonatomic) ZZPosition *down;
/** 上方向 */
@property (nonatomic) ZZPosition *up;
/** 右方向 */
@property (nonatomic) ZZPosition *right;
/** 左方向 */
@property (nonatomic) ZZPosition *left;
/** 测试方向 */
@property (nonatomic) ZZPosition *test;
/** 最终选用的方向 */
@property (nonatomic) ZZPosition *target;

@property (nonatomic) BOOL isValid;

- (void)setTargetPosition:(ZZPopPosition)position;

@end
