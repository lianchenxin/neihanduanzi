//
//  ViewController.m
//  ScrollView轮播
//
//  Created by ma c on 15/9/10.
//  Copyright (c) 2015年 huhong. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestVC *vc = [[TestVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
