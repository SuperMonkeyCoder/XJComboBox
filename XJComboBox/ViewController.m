//
//  ViewController.m
//  XJComboBox
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 DemonDeveloper@163.com. All rights reserved.
//

#import "ViewController.h"
#import "XJComboBoxView.h"
#import "UIView+ITTAdditions.h"


@interface ViewController ()<XJComboBoxViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *listArray =@[@{@"display":@"停止运行",@"value":@"N"},@{@"display":@"正在运行",@"value":@"Y"}];
    XJComboBoxView *comboBox = [[XJComboBoxView alloc]initWithFrame:CGRectMake(100, 100, 250, 44)];
    comboBox.displayMember = @"display";
//    comboBox.valueMember = @"value";
    comboBox.dataSource = listArray;
    comboBox.borderColor =[UIColor redColor];
    comboBox.cornerRadius = 5;
    comboBox.leftTitle = @"描述";
    comboBox.defaultTitle = @"请选择";
    comboBox.delegate = self;
    [self.view addSubview:comboBox];
    
    
}

-(void)comboBoxView:(XJComboBoxView *)comboBoxView didSelectRowAtValueMember:(NSString *)valueMember displayMember:(NSString *)displayMember{
    NSLog(@"valueMember = %@, displayMember=%@", valueMember, displayMember);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
