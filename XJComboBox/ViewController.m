//
//  ViewController.m
//  XJComboBox
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 DemonDeveloper@163.com. All rights reserved.
//

#import "ViewController.h"
#import "XJComboBoxView.h"

@interface ViewController ()<XJComboBoxViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *listArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    XJComboBoxView *view = [[XJComboBoxView alloc]initWithFrame:CGRectMake(100, 100, 200, 35) listArray:listArray];
    view.borderColor =[UIColor redColor];
    view.cornerRadius = 5;
    view.leftTitle = @"描述";
    view.delegate = self;
    [self.view addSubview:view];
}
-(void)comboBoxView:(XJComboBoxView *)comboBoxView didSelectRowAtIndex:(NSInteger)index rowTitle:(NSString *)rowTitle{
    NSLog(@"index = %ld, rowTitle = %@",index, rowTitle);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
