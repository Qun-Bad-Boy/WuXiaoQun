//
//  UIButton+PreVentMultipleClick.m
//  MethodSwizzingConclusion(黑魔法总结)
//
//  Created by 吴晓群 on 16/10/11.
//  Copyright © 2016年 sanMiTeconology. All rights reserved.
//

#import "UIButton+PreVentMultipleClick.h"
#import <objc/runtime.h>

@implementation UIButton (PreVentMultipleClick)

//默认的按钮点击时间
static const NSTimeInterval defaultDuration = 0.1;

//记录是否忽略按钮点击事件, 默认第一次执行事件
static BOOL _isIgnoreEvent = NO;
//设置执行按钮事件状态
static void resetState(){
    _isIgnoreEvent = NO;
}

static const char *clickDurationTimeKey = "clickDutationTimeKey";
#pragma mark ----关联对象
- (void)setClickDurationTime:(NSTimeInterval)clickDurationTime
{
#warning 这里最后的类型不能使用OBJC_ASSOCIATION_ASSIGN,否则时间间隔不是整数的话会崩溃.写成这样就可以了
    objc_setAssociatedObject(self, clickDurationTimeKey, @(clickDurationTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)clickDurationTime
{
    return [objc_getAssociatedObject(self, clickDurationTimeKey) floatValue];
}

#pragma mark ----重写系统点击方法
- (void)replaceSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    // 保险起见, 判断下class类型
    if ([self isKindOfClass:[UIButton class]])
    {
        //1. 按钮点击间隔事件
        self.clickDurationTime = self.clickDurationTime == 0 ? defaultDuration : self.clickDurationTime;
        
        //2. 是否忽略按钮点击事件
        if (_isIgnoreEvent)
        {
            //2.1 忽略按钮事件
            //直接拦截掉super函数进行发送消息
            return;
        }
        else if (self.clickDurationTime > 0)
        {
            //2.2 不忽略按钮事件
            //后续在间隔时间内直接忽视按钮事件
            [self replaceSendAction:action to:target forEvent:event];
            _isIgnoreEvent = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                resetState();
            });
        }
    }
}

#pragma mark ----交换系统方法
+ (void)load
{
    Method buttonMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method replaceMethod = class_getInstanceMethod([self class], @selector(replaceSendAction:to:forEvent:));
    method_exchangeImplementations(buttonMethod, replaceMethod);
}

@end
