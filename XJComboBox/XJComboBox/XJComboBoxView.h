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

-(void)comboBoxView:(XJComboBoxView *)comboBoxView didSelectRowAtIndex:(NSInteger)index rowTitle:(NSString *)rowTitle;
@end


@interface XJComboBoxView : UIView

@property (nonatomic, weak) id<XJComboBoxViewDelegate> delegate;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, copy) NSString *leftTitle;
/**
 *  初始化方法
 *
 *  listArray 为展示的数据  必传
 */
- (instancetype)initWithFrame:(CGRect)frame listArray:(NSArray *)listArray;


@end
