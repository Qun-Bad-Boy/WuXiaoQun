//
//  ViewController.m
//  MethodSwizzingConclusion(黑魔法总结)
//
//  Created by 吴晓群 on 16/10/10.
//  Copyright © 2016年 sanMiTeconology. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
//#import "UIButton+PreVentMultipleClick.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
//    button.clickDurationTime = 0.5;
//    NSLog(@"button.clickDurationTime = %.2f",button.clickDurationTime);
    [self.view addSubview:button];
    
    self.view.backgroundColor = [UIColor redColor];
    /**
     *  数组越界防止崩溃
     */
    NSArray *array = @[@"1",@"2",@"3"];
    NSString *string = array[6];
    
    /**
     *7.0一下系统使用一种图片,以上使用另外一种图片
     */
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40);
    imageView.alpha = 1;
    imageView.image = [UIImage imageNamed:@"111"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"上吧,皮卡丘!";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:70];
    label.textColor = [UIColor redColor];
    label.frame = imageView.frame;
    [self.view addSubview:label];
}

#pragma mark ----跳转至下一页.
- (void)buttonEvent
{
    [self presentViewController:[FirstViewController new] animated:YES completion:nil];
//    NSLog(@"1111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
