//
//  RACSequenceViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACSequenceViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSequenceViewController ()

@end

@implementation RACSequenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test1];
}

- (void)test1 {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
    [dictArr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    } error:^(NSError *error) {
        NSLog(@"===error===");
    } completed:^{
        NSLog(@"ok---完毕");
    }];
}

@end
