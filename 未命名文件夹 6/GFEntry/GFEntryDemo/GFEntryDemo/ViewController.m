//
//  ViewController.m
//  GFEntryDemo
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "ViewController.h"
#import "GFUserNameRegisterMediator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [GFUserNameRegisterMediator openEntrance:self];
}

@end
