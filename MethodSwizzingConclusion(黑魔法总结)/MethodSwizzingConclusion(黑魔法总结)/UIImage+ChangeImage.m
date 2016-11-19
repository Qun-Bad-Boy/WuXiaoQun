//
//  UIImage+ChangeImage.m
//  WXQRuntime
//
//  Created by 吴晓群 on 16/9/23.
//  Copyright © 2016年 sanMiTeconology. All rights reserved.
//

#import "UIImage+ChangeImage.h"
#import <objc/runtime.h>            //runtime类

@implementation UIImage (ChangeImage)


#pragma mark ----给类别添加属性
static const char *titleStringKey;

- (void)setTitleString:(NSString *)titleString
{
    /**
     *  第一个参数: 给哪个对象添加关联
     第二个参数: 关联的key, 通过这个key获取
     第三个参数: 关联的value
     第四个参数: 关联的策略,就是copy, strong, assign 等
     */
    objc_setAssociatedObject(self, &titleStringKey, titleString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)titleString
{
    //根据关联的key,获取关联的值.
    return objc_getAssociatedObject(self, &titleStringKey);
}


#pragma mark ----自定义实现图片方法
+ (UIImage *)WXQ_imageName:(NSString *)name
{
    double verSion = [UIDevice currentDevice].systemVersion.doubleValue;
    if ((verSion >= 7.0))
    {
        //如果系统版本是7.0以上, 使用另外一套文件名结尾是'_os7'的图片
        name = [name stringByAppendingString:@"_os7"];
    }
    UIImage *image = [UIImage WXQ_imageName:name];
    if (image == nil)
    {
        NSLog(@"图片没有加载出来");
    }
    return [UIImage WXQ_imageName:name];
}

//加载分类到内存的时候调用
+ (void)load
{
    /**
     *  通过class_getInstanceMethod()函数从当前对象中的method list 获取method结构体,如果是类方法就使用class_getClassMethod()函数获取
     *
     *  @param class]     类
     *  @param suiBianXie 对象方法(减号方法)
     *
     *  @return 返回哪个类中的减号方法
     */
//    Method methodObject = class_getInstanceMethod([self class], @selector(suiBianXie));
    
    //获取两个类的类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(WXQ_imageName:));
    
    method_exchangeImplementations(m1, m2);
}
@end
