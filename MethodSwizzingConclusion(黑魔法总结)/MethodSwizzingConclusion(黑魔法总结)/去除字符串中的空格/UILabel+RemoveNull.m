//
//  UILabel+RemoveNull.m
//  取出字符串中的null
//
//  Created by 吴晓群 on 16/10/18.
//  Copyright © 2016年 sanMiTeconology. All rights reserved.
//

#import "UILabel+RemoveNull.h"
#import <objc/runtime.h>

@implementation UILabel (RemoveNull)
+ (void)load
{
    [super load];
    Method method = class_getInstanceMethod([self class], @selector(setText:));
    Method removeMethod = class_getInstanceMethod([self class], @selector(removeNullSetText:));
    method_exchangeImplementations(method, removeMethod);
}

- (void)removeNullSetText:(NSString *)string
{
    if (string == nil || [string isEqualToString:@"(null)"])
    {
        string = @"";
    }
#pragma mark ----字符串中包含某个字符串
    else if ([string rangeOfString:@"(null)"].location != NSNotFound)
    {
#pragma mark ----使用某字符串代替原来的字符串
        string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    [self removeNullSetText:string];
}
@end
