//
//  RACMulticastConnectionViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACMulticastConnectionViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

/**
 *  当有多个订阅者，但是我们只想发送一个信号的时候怎么办？这时我们就可以用RACMulticastConnection，来实现
 */
@interface RACMulticastConnectionViewController ()

@end

@implementation RACMulticastConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self test2];
}

// 普通写法, 这样的缺点是：每订阅一次信号就得重新创建并发送请求，这样很不友好
- (void)test {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // didSubscribeblock中的代码都统称为副作用。
        // 发送请求---比如afn
        NSLog(@"发送请求啦");
        // 发送信号
        [subscriber sendNext:@"ws"];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

// 比较好的做法。 使用RACMulticastConnection，无论有多少个订阅者，无论订阅多少次，我只发送一个。
- (void)test2 {
    // 1.发送请求，用一个信号内包装，不管有多少个订阅者，只想发一次请求
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        NSLog(@"发送请求啦");
        // 发送信号
        [subscriber sendNext:@"ws"];
        return nil;
    }];
    //2. 创建连接类
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //3. 连接。只有连接了才会把信号源变为热信号
    [connection connect];
}

@end
