//
//  TestVC.m
//  ScrollView轮播
//
//  Created by 胡红 on 16/9/23.
//  Copyright © 2016年 huhong. All rights reserved.
//

#import "TestVC.h"
#import "ScrollViewCicle.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray* array = @[@"兰.jpg",@"明.jpg",@"静.jpg",@"云.jpg",@"婷.jpg",@"月.jpg",@"烟.jpg",@"画.jpg",@"芬.jpg",@"雨.jpg",@"霞.jpg"];
    ScrollViewCicle* hh = [[ScrollViewCicle alloc] init];
    [hh ciclePicture:array andFrame:CGRectMake(0, 0, 414, 200) andCurrentImage:0];
    [self.view addSubview:hh];

    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
