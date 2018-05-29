//
//  LoginViewModel.m
//  RACDemo
//
//  Created by QMMac on 2018/5/29.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

// 处理按钮是否允许点击
@property (nonatomic, strong) RACSignal *loginEnableSignal;
// 登录按钮的命令
@property (nonatomic, strong) RACCommand *loginCommand;

@end

@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 1. 处理登录点击的信号
    self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)]
                                               reduce:^id(NSString *account, NSString *pwd){
                                                   return @(account.length && pwd.length);
                                               }];
    
    // 2.处理登录点击命令
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令就会调用
        // block作用：事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                // 发送数据
                [subscriber sendNext:@"发送登录的数据"];
                [subscriber sendCompleted]; // 一定要记得写
            });
            return nil;
        }];
    }];
    
    // 3.处理登录的请求返回的结果
    // 创建登录命令
    // 获取命令中的信号源
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 4.处理登录执行过程
    [[self.loginCommand.executing skip:1] subscribeNext:^(id x) { // 跳过第一步（"没有执行"这步）
        if ([x boolValue]) {
            NSLog(@"--正在执行");
            // 显示蒙版
        } else { //执行完成
            NSLog(@"执行完成");
            // 取消蒙版
        }
    }];
}

@end
