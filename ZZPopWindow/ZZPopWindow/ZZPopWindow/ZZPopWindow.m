//
//  ZZPopWindow.m
//  ZZPopWindow
//
//  Created by liuweizhen on 2017/5/17.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "ZZPopWindow.h"
#define kMinPadding 5.0

#pragma mark - Class ZZContentViewInfo

@interface ZZContentViewInfo : NSObject

@property (nonatomic) CGRect frame;
@property (nonatomic) CGAffineTransform startTransform;
@property (nonatomic) CGAffineTransform endTransform;

@end

@implementation ZZContentViewInfo

@end

////////////////////////////////////////////////////////////////////////

typedef NS_OPTIONS(NSUInteger, ZZAtViewPosition) {
    ZZAtViewPositionDown  = 1 <<  0,
    ZZAtViewPositionUp    = 1 <<  1,
    ZZAtViewPositionLeft  = 1 <<  2,
    ZZAtViewPositionRight = 1 <<  3
};

////////////////////////////////////////////////////////////////////////

#pragma mark - Class ZZAtViewInfo

@interface ZZAtViewInfo : NSObject

@property (nonatomic, weak) ZZPopWindow *masterWindow;

@property (nonatomic) CGRect frame;
/**
 * atView位于PopWindow的位置
 */
@property (nonatomic) ZZAtViewPosition position;
@property (nonatomic) CGPoint currentCenter;
@property (nonatomic) CGPoint targetCenter;

- (BOOL)positioniIsDown;
- (BOOL)positionIsUp;
- (BOOL)positionIsRight;
- (BOOL)positionIsLeft;
@end

@implementation ZZAtViewInfo

- (BOOL)positioniIsDown {
    return [self judgePosition:ZZAtViewPositionDown];
}

- (BOOL)positionIsUp {
    return [self judgePosition:ZZAtViewPositionUp];
}

- (BOOL)positionIsRight {
    return [self judgePosition:ZZAtViewPositionRight];
}

- (BOOL)positionIsLeft {
    return [self judgePosition:ZZAtViewPositionLeft];
}

- (BOOL)judgePosition:(ZZAtViewPosition)p {
    return p == (self.position & p);
}

- (CGPoint)currentCenter {
    return [self getCenterWithPosition:self.masterWindow.positionList.test.position];
}

- (CGPoint)targetCenter {
    return [self getCenterWithPosition:self.masterWindow.positionList.target.position];
}

- (CGPoint)getCenterWithPosition:(ZZPopPosition)position {
    switch (position) {
        case ZZPopPositionDown:
            return CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
        case ZZPopPositionUp:
            return CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame));
        case ZZPopPositionRight:
            return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame));
        case ZZPopPositionLeft:
            return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame));
        default:
            @throw [NSException exceptionWithName:@"getTargetCenter exception" reason:@"position illegal!" userInfo:nil];
    }
}

@end

////////////////////////////////////////////////////////////////////////

@interface ZZValidateContentFrameInfo : NSObject
@property (nonatomic, weak) ZZPopWindow *masterWindow;
@property (nonatomic) CGRect contentFrame;
@property (nonatomic) CGRect targetContentFrame;

+ (instancetype)validateInfoWithContentFrame:(CGRect)frame masterWindow:(ZZPopWindow *)masterWindow;

- (BOOL)contentFrameError;
- (BOOL)contentFrameError:(CGRect)contentFrame;
- (BOOL)leftError;
- (CGRect)resetLeft;
- (CGRect)resetLeftForce;
- (BOOL)rightError;
- (CGRect)resetRight;
- (CGRect)resetRightForce;
- (BOOL)upError;
- (CGRect)resetUp;
- (CGRect)resetUpForce;
- (BOOL)downError;
- (CGRect)resetDown;
- (CGRect)resetDownForce;

@end

@implementation ZZValidateContentFrameInfo

+ (instancetype)validateInfoWithContentFrame:(CGRect)frame masterWindow:(ZZPopWindow *)masterWindow {
    ZZValidateContentFrameInfo *info = [[ZZValidateContentFrameInfo alloc] init];
    info.masterWindow = masterWindow;
    info.contentFrame = frame;
    return info;
}

- (BOOL)contentFrameError {
    return CGRectContainsRect(self.masterWindow.bounds, self.contentFrame) == NO;
}

- (BOOL)contentFrameError:(CGRect)contentFrame {
    return CGRectContainsRect(self.masterWindow.bounds, contentFrame) == NO;
}

- (BOOL)leftError {
    return self.contentFrame.origin.x < 0;
}

- (BOOL)rightError {
    return CGRectGetMaxX(self.contentFrame) > CGRectGetMaxX(self.masterWindow.bounds);
}
- (BOOL)upError {
    return self.contentFrame.origin.y < 0;
}

// left-righht弹出方向：上方越界，下移
- (CGRect)resetUp {
    CGRect frame    = self.contentFrame;
    CGFloat originY = frame.origin.y;
    CGFloat padding = frame.size.height + kMinPadding > self.masterWindow.bounds.size.height ? 0 : kMinPadding;
    originY         = originY - CGRectGetMinY(frame) + padding;
    frame.origin.y  = originY;
    return frame;
}

- (BOOL)downError {
    return CGRectGetMaxY(self.contentFrame) > self.masterWindow.bounds.size.height;
}

// left-right弹出方向：下方越界，上移
- (CGRect)resetDown {
    CGRect frame    = self.contentFrame;
    CGFloat originY = frame.origin.y;
    CGFloat padding = frame.size.height + kMinPadding > self.masterWindow.bounds.size.height ? 0 : kMinPadding;
    originY         = originY - (CGRectGetMaxY(frame) - self.masterWindow.bounds.size.height) - padding;
    frame.origin.y  = originY;
    return frame;
}

// down-up弹出方向：左侧越界，右移
- (CGRect)resetLeft {
    CGRect frame = self.contentFrame;
    CGFloat originX = frame.origin.x;
    CGFloat padding = frame.size.width + kMinPadding > self.masterWindow.bounds.size.width ? 0 : kMinPadding;
    originX = MAX(padding, originX);
    frame.origin.x = originX;
    return frame;
}

- (CGRect)resetLeftForce {
    CGRect frame = [self resetLeft];
    return self.masterWindow.enableForceReset ? [self resetLeftAndRightForce:frame] : frame;
}

// down-up弹出方向：右侧越界，左移
- (CGRect)resetRight {
    CGRect frame    = self.contentFrame;
    CGFloat originX = frame.origin.x;
    CGFloat padding = frame.size.width + kMinPadding > self.masterWindow.bounds.size.width ? 0 : kMinPadding;
    originX         = originX - (CGRectGetMaxX(frame) - self.masterWindow.bounds.size.width) - padding;
    frame.origin.x  = originX;
    return frame;
}

- (CGRect)resetRightForce {
    CGRect frame = [self resetRight];
    return self.masterWindow.enableForceReset ? [self resetLeftAndRightForce:frame] : frame;
}

- (CGRect)resetLeftAndRightForce:(CGRect)frame {
    if ([self contentFrameError:frame] == NO) {
        return frame;
    }
    frame.size.width = MIN(frame.size.width, self.masterWindow.bounds.size.width);
    if (self.masterWindow.positionList.target.position == ZZPopPositionDown) {
        frame.size.height = MIN(frame.size.height, self.masterWindow.bounds.size.height);
    } else {
        frame.size.height = MIN(frame.size.height, frame.size.height + frame.origin.y);
    }
    frame.origin.x = MAX(0, frame.origin.x);
    frame.origin.y = MAX(0, frame.origin.y);
    return frame;
}

- (CGRect)resetUpForce {
    CGRect frame = [self resetUp];
    return self.masterWindow.enableForceReset ? [self resetDownAndUpForce:frame] : frame;
}

- (CGRect)resetDownForce {
    CGRect frame = [self resetDown];
    return self.masterWindow.enableForceReset ? [self resetDownAndUpForce:frame] : frame;
}

- (CGRect)resetDownAndUpForce:(CGRect)frame {
    if ([self contentFrameError:frame] == NO) {
        return frame;
    }
    frame.size.height = MIN(frame.size.height, self.masterWindow.bounds.size.height);
    if (self.masterWindow.positionList.target.position == ZZPopPositionRight) {
        frame.size.width = MIN(frame.size.width, self.masterWindow.bounds.size.width - frame.origin.x);
    } else {
        frame.size.width = MIN(frame.size.width, CGRectGetMaxX(frame));
    }
    frame.origin.x = MAX(0, frame.origin.x);
    frame.origin.y = MAX(0, frame.origin.y);
    return frame;
}

@end

////////////////////////////////////////////////////////////////////////

#pragma mark - Class ZZPopWindow

@interface ZZPopWindow()

@property (nonatomic) ZZContentViewInfo *contentViewInfo;
@property (nonatomic) UIView *atView;
@property (nonatomic) ZZAtViewInfo *atViewInfo;
@property (nonatomic) ZZPositionList *positionList;

@property (nonatomic) CGAffineTransform startTransform;
@property (nonatomic) CGAffineTransform endTransform;
@end

@implementation ZZPopWindow {
    BOOL _isiOS7;
}

- (void)showAtView:(UIView *)atView {
    self.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
    
    // 1. make visible
    [self makeKeyWindow];
    self.windowLevel = UIWindowLevelAlert;
    self.hidden = NO;
    
    // 2. get at view info
    self.atView = atView;
    
    // 3. get content view info
    [self setContentViewInfo]; // -> content view info
    
    // 4. show
    [self show];
}

- (void)printFrame:(CGRect)rect {
    NSLog(@"%@", NSStringFromCGRect(rect));
}

- (instancetype)init {
    return [self initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _isiOS7               = ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending);
    self.animationIn      = 0.25;
    self.animationOut     = 0.0f;
    self.enableForceReset = YES;
    self.animationSpring  = _isiOS7;
}

- (void)setContentViewInfo {
    [self getTargetPosition]; // 确保首先找到合适的弹出方向
    
    CGRect contentFrame = [self getCommonContentViewFrameWithPosition:self.positionList.target];
    [self printFrame:contentFrame];
    ZZValidateContentFrameInfo *info = [ZZValidateContentFrameInfo validateInfoWithContentFrame:contentFrame masterWindow:self];
    if (!info.contentFrameError) { // 符合条件
        self.contentViewInfo.frame = contentFrame;
        return;
    } else { // contentFrame不符合条件，调整frame
        switch (self.positionList.target.position) {
            case ZZPopPositionDown:
            case ZZPopPositionUp: {
                if (self.atViewInfo.positionIsLeft) {
                    self.contentViewInfo.frame = [info resetLeftForce];
                } else {
                    self.contentViewInfo.frame = [info resetRightForce];
                }
            }
            break;
            case ZZPopPositionLeft:
            case ZZPopPositionRight: {
                if (self.atViewInfo.positioniIsDown) { // atView位置居下
                    self.contentViewInfo.frame = [info resetDownForce];
                } else { // atView位置居上
                    self.contentViewInfo.frame = [info resetUpForce];
                }
            }
            break;
            default:
                break;
        }
    }
}

- (ZZPosition *)getTargetPosition {
    return self.positionList.target;
}

- (BOOL)validateContentFrameHorizontal:(CGRect)frame {
    if (frame.size.width > self.bounds.size.width) {
        return NO;
    }
    if (frame.origin.x < 0 || CGRectGetMaxX(frame) > self.bounds.size.width) {
        return NO;
    }
    return YES;
}

- (CGRect)contentFrameDownReset:(CGRect)frame {
    CGRect contentFrame = frame;
    CGFloat originX     = contentFrame.origin.x;
    CGFloat padding     = frame.size.width + kMinPadding > self.bounds.size.width ? 0 : kMinPadding;
    // 调整frame
    if (self.atViewInfo.positionIsLeft) {
        originX = MAX(padding, originX);
        contentFrame.origin.x = originX;
    } else if (self.atViewInfo.positionIsRight) {
        
    }
    return CGRectNull;
}

- (CGRect)contentFrameUpReset:(CGRect)frame {
    return CGRectNull;
}

- (CGRect)contentFrameLeftReset:(CGRect)frame {
    return CGRectNull;
}

- (CGRect)contentFrameRightReset:(CGRect)frame {
    return CGRectNull;
}

- (CGRect)getCommonContentViewFrameWithPosition:(ZZPosition *)p {
    CGRect contentViewFrame = self.contentView.frame;
    [self printFrame:contentViewFrame];
    CGPoint currentCenter = [self.atViewInfo getCenterWithPosition:p.position];
    switch (p.position) {
        case ZZPopPositionDown: {
            CGFloat originX = currentCenter.x - contentViewFrame.size.width / 2.0;
            CGFloat originY = currentCenter.y;
            contentViewFrame.origin.x = originX;
            contentViewFrame.origin.y = originY;
            [self printFrame:contentViewFrame];
            return contentViewFrame;
        }
        case ZZPopPositionUp: {
            CGFloat originX = currentCenter.x - contentViewFrame.size.width / 2.0;
            CGFloat originY = currentCenter.y - contentViewFrame.size.height;
            contentViewFrame.origin.x = originX;
            contentViewFrame.origin.y = originY;
            [self printFrame:contentViewFrame];
            return contentViewFrame;
        }
        case ZZPopPositionLeft: {
            CGFloat originX = currentCenter.x - contentViewFrame.size.width;
            CGFloat originY = currentCenter.y - contentViewFrame.size.height / 2.0;
            contentViewFrame.origin.x = originX;
            contentViewFrame.origin.y = originY;
            [self printFrame:contentViewFrame];
            return contentViewFrame;
        }
        case ZZPopPositionRight: {
            CGFloat originX = currentCenter.x;
            CGFloat originY = currentCenter.y - contentViewFrame.size.height / 2.0;
            contentViewFrame.origin.x = originX;
            contentViewFrame.origin.y = originY;
            [self printFrame:contentViewFrame];
            return contentViewFrame;
        }
        default:
            break;
    }
    return CGRectNull;
}

- (CGRect)getContentViewFrame {
    return CGRectNull;
}

- (ZZContentViewInfo *)contentViewInfo {
    if (_contentViewInfo == nil) {
        _contentViewInfo = [[ZZContentViewInfo alloc] init];
    }
    return _contentViewInfo;
}

- (void)setPopPosition:(ZZPopPosition)popPosition {
    _popPosition = popPosition;
    [self.positionList setTargetPosition:popPosition];
}

- (ZZPositionList *)positionList {
    if (_positionList == nil) {
        _positionList = [[ZZPositionList alloc] init];
    }
    return _positionList;
}

- (void)didFindFrameAndPosition {}

#pragma mark - public methods
- (void)setAtView:(UIView *)atView {
    _atView = atView;
    
    // Get the at view info
    self.atViewInfo          = [[ZZAtViewInfo alloc] init];
    CGRect frame             = [self convertRect:self.atView.frame toView:self];
    self.atViewInfo.frame    = frame;
    CGPoint centerAtView     = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGPoint centerSelf       = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.atViewInfo.position = centerAtView.y >= centerSelf.y ? ZZAtViewPositionDown : ZZAtViewPositionUp;
    ZZAtViewPosition p       = centerAtView.x >= centerSelf.x ? ZZAtViewPositionRight : ZZAtViewPositionLeft;
    self.atViewInfo.position |= p;
    self.atViewInfo.masterWindow = self;
}

- (void)show {
    self.contentView.frame = self.contentViewInfo.frame;
    [self addSubview:self.contentView];

    if (self.animationIn > 0.0001) {
        [self setAnchorPoint];
        switch (self.positionList.target.position) {
            case ZZPopPositionDown:
            case ZZPopPositionUp: {
                self.contentViewInfo.startTransform = self.contentView.transform = CGAffineTransformMakeScale(1.0, 0.0);;
                self.contentViewInfo.endTransform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            break;
            case ZZPopPositionLeft:
            case ZZPopPositionRight: {
                self.contentViewInfo.startTransform = self.contentView.transform = CGAffineTransformMakeScale(0.0, 1.0);;
                self.contentViewInfo.endTransform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            break;
                
            default:
                break;
        }
        // animation
        if (self.animationSpring && _isiOS7) {
            [UIView animateWithDuration:self.animationIn delay:0
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:3
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.contentView.transform = self.contentViewInfo.endTransform;
                             }
                             completion:^(BOOL finished) {
                                 if (self.didShowHandler) {
                                     self.didShowHandler();
                                 }
                             }];
        } else {
            [UIView animateWithDuration:self.animationIn
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.contentView.transform = self.contentViewInfo.endTransform;
                             } completion:^(BOOL finished) {
                                 if (self.didShowHandler) {
                                     self.didShowHandler();
                                 }
                             }];
        }
    } else {
        // No animation
    }
}

- (void)setAnchorPoint {
    CGPoint anchorPoint = CGPointZero;
    CGPoint showPoint = [self convertPoint:self.atViewInfo.targetCenter toView:self.contentView];
    NSLog(@"%@", NSStringFromCGPoint(showPoint));
    CGRect popViewFrame = self.contentViewInfo.frame;
    switch (self.positionList.target.position) {
        case ZZPopPositionDown: {
            anchorPoint = CGPointMake(showPoint.x / popViewFrame.size.width, 0);
            break;
        }
        case ZZPopPositionUp: {
            anchorPoint = CGPointMake(showPoint.x / popViewFrame.size.width, 1);
            break;
        }
        case ZZPopPositionRight: {
            anchorPoint = CGPointMake(0, showPoint.y / popViewFrame.size.height);
            break;
        }
        case ZZPopPositionLeft: {
            anchorPoint = CGPointMake(1, showPoint.y / popViewFrame.size.height);
            break;
        }
        default:
            break;
    }
    NSLog(@"%@", NSStringFromCGPoint(anchorPoint));
    CGPoint lastAnchor = self.contentView.layer.anchorPoint;
    NSLog(@"%@", NSStringFromCGPoint(lastAnchor));
    self.contentView.layer.anchorPoint = anchorPoint;
    // 锚点和position的移动公式，由于锚点改变，为了使view的位置不发生变化，相应的改变它的position
    UIView *view = self.contentView;
    view.layer.position = CGPointMake(view.layer.position.x + (anchorPoint.x - lastAnchor.x) * view.layer.bounds.size.width, view.layer.position.y + (anchorPoint.y - lastAnchor.y) * view.layer.bounds.size.height);
}

- (void)dismiss {
    [UIView animateWithDuration:self.animationOut animations:^{
        if (self.animationOut > 0.0001) {
            // http://stackoverflow.com/questions/2690337/get-just-the-scaling-transformation-out-of-cgaffinetransform
            CGAffineTransform t = self.contentViewInfo.startTransform;
            double x = sqrt(t.a * t.a + t.c * t.c);
            x = x > 0 ? x : 0.0001;
            double y = sqrt(t.b * t.b + t.d * t.d);
            y = y > 0 ? y : 0.0001;
            CGAffineTransform transform = CGAffineTransformScale(self.contentView.transform, x, y);
            self.contentView.transform = transform;
        } else {
            self.contentView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self resignKeyWindow];
        self.hidden = YES;
        if (self.didDismissHandler) {
            self.didDismissHandler();
        }
    }];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismiss];
}

@end











