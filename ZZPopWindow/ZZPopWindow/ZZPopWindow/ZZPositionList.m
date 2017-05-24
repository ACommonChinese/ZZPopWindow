//
//  ZZPositionList.m
//  ZZPopWindow
//
//  Created by liuweizhen on 2017/5/17.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "ZZPositionList.h"

@implementation ZZPosition

- (instancetype)initWithPopPosition:(ZZPopPosition)p {
    if (self = [super init]) {
        self.position = p;
    }
    
    return self;
}

@end

////////////////////////////////////////////////////////////////////////

@implementation ZZPositionList

- (instancetype)init {
    if (self = [super init]) {
        self.down  = [[ZZPosition alloc] initWithPopPosition:ZZPopPositionDown];
        self.up    = [[ZZPosition alloc] initWithPopPosition:ZZPopPositionUp];
        self.right = [[ZZPosition alloc] initWithPopPosition:ZZPopPositionRight];
        self.left  = [[ZZPosition alloc] initWithPopPosition:ZZPopPositionLeft];
    }
    return self;
}

- (void)setTargetPosition:(ZZPopPosition)position {
    switch (position) {
        case ZZPopPositionDown:
            self.target = self.down;
            break;
        case ZZPopPositionUp:
            self.target = self.up;
            break;
        case ZZPopPositionLeft:
            self.target = self.left;
            break;
        case ZZPopPositionRight:
            self.target = self.right;
            break;
        default:
            break;
    }
}

@end
