//
//  ViewController.m
//  GCDAndAFN
//
//  Created by 吴晓群 on 16/11/18.
//  Copyright © 2016年 WuXiaoQun. All rights reserved.
//

#import "ViewController.h"
#import "XQAFNTool.h"

@interface ViewController ()
{
    dispatch_group_t _groupEnter;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#pragma mark ----平常GCD多个事件执行完毕再执行最后一个
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            [self normalMethodOne];
        });
        dispatch_group_async(group, queue, ^{
            [self normalMethodTwo];
        });
        dispatch_group_async(group, queue, ^{
            [self normalMethodThree];
        });
        //监听上面事件完成,调用通知 注意上面为并发,所以不遵循先进先出原则,但是只有上面三个事件执行完毕才执行最后这个notify(无论执行几遍,都是notify里面的方法最后执行)
        dispatch_group_notify(group, queue, ^{
            [self normalMethodFour];
            //也可以在里面加一个主线程,刷新界面 如:
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新UI
            });
        });
    });
    
#pragma mark ----没有执行加入任务组的AFN请求(没有dispatch_group_enter)
    dispatch_queue_t queueNotAFN = dispatch_get_global_queue(0, 0);
    dispatch_async(queueNotAFN, ^{
        dispatch_group_t groupNotAFN = dispatch_group_create();
        dispatch_group_async(groupNotAFN, queueNotAFN, ^{
            [self AFNRequestWithString:@"AFN请求一"];
        });
        dispatch_group_async(groupNotAFN, queueNotAFN, ^{
            [self AFNRequestWithString:@"AFN请求二"];
        });
        dispatch_group_async(groupNotAFN, queueNotAFN, ^{
            [self AFNRequestWithString:@"AFN请求三"];
        });
        dispatch_group_async(groupNotAFN, queueNotAFN, ^{
            [self AFNRequestWithString:@"AFN请求四"];
        });
        
        //使用AFN请求的话,notify里面的方法就不是等待上面请求完成之后再执行了.(可以运行一下试试,多试几次)
        dispatch_group_notify(groupNotAFN, queueNotAFN, ^{
            [self AFNRequestWithString:@"AFN请求五"];
        });
    });
    
#pragma mark ----有dispatch_group_enter的AFN请求(这段代码才真正做到了上面几个请求完成再执行最后一个(或几个)请求);
    dispatch_queue_t queueEnter = dispatch_get_global_queue(0, 0);
    dispatch_async(queueEnter, ^{
        _groupEnter = dispatch_group_create();
        dispatch_group_async(_groupEnter, queueEnter, ^{
            [self enterAFNRequestWithString:@"dispatch_group_enter请求一"];
        });
        dispatch_group_async(_groupEnter, queueEnter, ^{
            [self enterAFNRequestWithString:@"dispatch_group_enter请求二"];
        });
        dispatch_group_async(_groupEnter, queueEnter, ^{
            [self enterAFNRequestWithString:@"dispatch_group_enter请求三"];
        });
        dispatch_group_async(_groupEnter, queueEnter, ^{
            [self enterAFNRequestWithString:@"dispatch_group_enter请求四"];
        });
        
        //在请求中加入了dispatch_group_enter和dispatch_group_leave时,就可以放心使用AFN进行请求了.可以拿到前几个请求完成之后的参数再进行最后一个请求(可以看输出)
        dispatch_group_notify(_groupEnter, queueEnter, ^{
            [self enterAFNRequestWithString:@"dispatch_group_enter请求五"];
        });
    });
}

#pragma mark ----平常方法
- (void)normalMethodOne
{
    NSLog(@"执行平常方法一");
}

- (void)normalMethodTwo
{
    NSLog(@"执行平常方法二");
}

- (void)normalMethodThree
{
    NSLog(@"执行平常方法三");
}

- (void)normalMethodFour
{
    NSLog(@"执行平常方法四");
}

#pragma mark ----AFN请求方法
- (void)AFNRequestWithString:(NSString *)string
{
    NSLog(@"需要拿参%@",string);
    [XQAFNTool post:@"http://192.168.1.188:8080/yhqgov/api/person/selectQuestions" params:nil success:^(id json) {
        NSLog(@"%@",string);
    } failure:^(NSError *error) {
        NSLog(@"%@",string);
    }];
}

#pragma mark ----有dispatch_group_enter的ANF请求
- (void)enterAFNRequestWithString:(NSString *)string
{
    dispatch_group_enter(_groupEnter);
    NSLog(@"AFN拿参%@",string);
    [XQAFNTool post:@"http://192.168.1.188:8080/yhqgov/api/person/selectQuestions" params:nil success:^(id json) {
        NSLog(@"%@",string);
        dispatch_group_leave(_groupEnter);
    } failure:^(NSError *error) {
        NSLog(@"%@",string);
        dispatch_group_leave(_groupEnter);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
