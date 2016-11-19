//
//  UIButton+PreVentMultipleClick.h
//  MethodSwizzingConclusion(黑魔法总结)
//
//  Created by 吴晓群 on 16/10/11.
//  Copyright © 2016年 sanMiTeconology. All rights reserved.
//
/**
 *  使用黑魔法防止按钮在一定时间内被多次点击造成多次跳转至同一个界面,但是这会造成无论点击哪个按钮, 在规定的时间内都不能再点击任何按钮
 */
#import <UIKit/UIKit.h>

@interface UIButton (PreVentMultipleClick)

@property (nonatomic, assign)NSTimeInterval clickDurationTime;  //点击间隔时间
@end
