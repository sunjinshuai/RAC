//
//  RACValuePassedViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACValuePassedViewController.h"
#import "RACTestViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACValuePassedViewController ()

@property(nonatomic, strong) UIButton *pustButton;

@end

@implementation RACValuePassedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.pustButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, ([UIScreen mainScreen].bounds.size.height - 50)/2, 100, 50);
    [self.view addSubview:self.pustButton];
}

- (void)push {
    RACTestViewController *test = [[RACTestViewController alloc] init];
    test.subject = [RACSubject subject];
    // 这里的x便是sendNext发送过来的信号
    [test.subject subscribeNext:^(id x) {
        NSLog(@"%@", x);
        [self.pustButton setTitle:x forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:test animated:YES];
}

- (UIButton *)pustButton {
    if (!_pustButton) {
        _pustButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pustButton setTitle:@"push" forState:UIControlStateNormal];
        [_pustButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_pustButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_pustButton];
    }
    return _pustButton;
}

@end
