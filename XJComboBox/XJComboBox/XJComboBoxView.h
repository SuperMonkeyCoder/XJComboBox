//
//  XJComboBoxView.h
//  XJComboBox
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 DemonDeveloper@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJComboBoxView;
@protocol XJComboBoxViewDelegate <NSObject>

-(void)comboBoxView:(XJComboBoxView *)comboBoxView didSelectRowAtValueMember:(NSString *)valueMember displayMember:(NSString *)displayMember;
@end


@interface XJComboBoxView : UIView

@property (nonatomic, weak) id<XJComboBoxViewDelegate> delegate;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
//左边描述信息
@property (nonatomic, copy) NSString *leftTitle;
//默认显示名
@property (nonatomic, copy) NSString *defaultTitle;

@property (nonatomic, copy) NSString *displayMember;//控件显示的列名
@property (nonatomic, copy) NSString *valueMember;//控件值的列名
@property (nonatomic, strong) NSArray  *dataSource;

//


-(instancetype)initWithFrame:(CGRect)frame;

@end
