//
//  RACBindViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACBindViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACBindViewController ()

@end

@implementation RACBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self bind];
}

- (void)bind {
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        // block调用时刻：只要绑定信号订阅就会调用。不做什么事情，
        return ^RACSignal *(id value, BOOL *stop){
            // 一般在这个block中做事 ，发数据的时候会来到这个block。
            // 只要源信号（subject）发送数据，就会调用block
            // block作用：处理源信号内容
            // value:源信号发送的内容，
            value = @3; // 如果在这里把value的值改了，那么订阅绑定信号的值即44行的x就变了
            NSLog(@"接受到源信号的内容：%@", value);
            //返回信号，不能为nil,如果非要返回空---则empty或 alloc init。
            return [RACSignal return:value]; // 把返回的值包装成信号
        };
    }];
    
    // 3.订阅绑定信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"接收到绑定信号处理完的信号:%@", x);
    }];
    // 4.发送信号
    [subject sendNext:@"111"];
}

@end
