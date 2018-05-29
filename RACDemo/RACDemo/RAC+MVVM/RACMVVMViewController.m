//
//  RACMVVMViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/29.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACMVVMViewController.h"
#import "LoginViewModel.h"

@interface RACMVVMViewController ()

@property (nonatomic, weak) IBOutlet UITextField *accountField;
@property (nonatomic, weak) IBOutlet UITextField *pwdField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation RACMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MVVM:
    // VM:视图模型----处理展示的业务逻辑  最好不要包括视图
    // 每一个控制器都对应一个VM模型
    // MVVM:开发中先创建VM，把业务逻辑处理好，然后在控制器里执行
    [self bindViewModel];
    [self loginEvent];
}

- (void)bindViewModel {
    // 1.给视图模型的账号和密码绑定信号
    RAC(self.loginVM, account) = self.accountField.rac_textSignal;
    RAC(self.loginVM, pwd) = self.pwdField.rac_textSignal;
}

- (void)loginEvent {
    // 1.处理文本框业务逻辑--- 设置按钮是否能点击
    RAC(self.loginButton, enabled) = self.loginVM.loginEnableSignal;
    // 2.监听登录按钮点击
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        // 处理登录事件
        [self.loginVM.loginCommand execute:nil];
    }];
}

- (LoginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

@end
