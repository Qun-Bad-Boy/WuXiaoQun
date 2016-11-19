//
//  AppDelegate.m
//  MethodSwizzingConclusion(黑魔法总结)
//
//  Created by 吴晓群 on 16/10/10.
//  Copyright © 2016年 sanMiTeconology. All rights reserved.
//
#warning 这里是错误的代码
//    /**
//     *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证, 如果UIImage没有实现被交换的方法,会导致失败. 而且UIImage没有交换方法的实现, 但是父类有这个方法, 这样会调用父类的方法, 结果就不是我们想要的结果了. 所以我们在这里通过class_addMethod()的验证, 如果UIImage实现了这个方法, class_addMethod()函数将会返回NO, 我们就可以对其进行交换了.
//     *
//     *  @param class]      需要交换方法的类
//     *  @param imageNamed: 被替换的方法名
//     *  m2: 交换后的方法名
//     *  @return 返回YES,则表示交换成功.NO表示未交换.     不知道为什么这里必须是返回YES,进这个方法才能实现功能
//     */
//
//    if (!class_addMethod([UIImage class], @selector(imageNamed:), method_getImplementation(m2), method_getTypeEncoding(m2)))
//    {
//        //开始交换方法实现
//        method_exchangeImplementations(m1, m2);
//    }
//    NSLog(@"m2的类型 == %s",method_getTypeEncoding(m2));
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
