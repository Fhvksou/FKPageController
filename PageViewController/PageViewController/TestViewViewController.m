//
//  TestViewViewController.m
//  PageViewController
//
//  Created by fhkvsou on 17/8/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "TestViewViewController.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f]

@interface TestViewViewController ()

@end

@implementation TestViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRandomColor;
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
