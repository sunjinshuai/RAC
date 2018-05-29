//
//  LoginViewModel.h
//  RACDemo
//
//  Created by QMMac on 2018/5/29.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewModel : NSObject

// 处理按钮是否允许点击
@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;

/// 保存登录界面的账号和密码
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;
// 登录按钮的命令
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
