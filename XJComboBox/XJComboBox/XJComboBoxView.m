//
//  XJComboBoxView.m
//  XJComboBox
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 DemonDeveloper@163.com. All rights reserved.
//

#import "XJComboBoxView.h"
#import "UIView+ITTAdditions.h"

@interface XJComboBoxView ()<UITableViewDelegate, UITableViewDataSource>

//下拉载数据view
@property (nonatomic, strong) UITableView *combBoxListTableView;

@property (nonatomic, strong) NSMutableArray *listArrayM;

@property (nonatomic, strong) UIView *listView;

@property (nonatomic, strong) UIButton *comBoxBtn;

@property (nonatomic, strong) UILabel *disPlayLabel;
@end

@implementation XJComboBoxView

-(instancetype)initWithFrame:(CGRect)frame listArray:(NSArray *)listArray{
    if (self = [super initWithFrame:frame]) {
        self.listArrayM = [listArray mutableCopy];
        [self.listArrayM insertObject:@"请选择" atIndex:0];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        //触模手热
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabGestureHandler)];
        [self addGestureRecognizer:tapGesture];
        [self loadComboBoxView];
    }
    return self;
}
- (void)tabGestureHandler
{
    [self comBoxBtnClick:self.comBoxBtn];
}
-(void)loadComboBoxView{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.width - self.height - 10, self.height)];
    lable.text = @"请选择";
    self.disPlayLabel = lable;
    [self addSubview:lable];
    UIButton *comBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.comBoxBtn = comBoxBtn;
    comBoxBtn.frame = CGRectMake(lable.right, 0, self.height, self.height);
    [comBoxBtn setImage:[UIImage imageNamed:@"DownAccessory"] forState:UIControlStateNormal];
    [comBoxBtn setImage:[UIImage imageNamed:@"UpAccessory"] forState:UIControlStateSelected];
    [comBoxBtn addTarget:self action:@selector(comBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:comBoxBtn];
}

-(void)comBoxBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        [UIView animateWithDuration:0.25 animations:^{
            if( self.listArrayM.count * self.height > 160){
                self.listView.height = 160;
                self.combBoxListTableView.height = 160;
            }else{
                self.listView.height = self.listArrayM.count * self.height;
                self.combBoxListTableView.height = self.listArrayM.count * self.height;
            }
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.listView.height = 0;
            self.combBoxListTableView.height = 0;
        }];
    }
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = [borderColor CGColor];
}

#pragma mark - 懒加载
-(UITableView *)combBoxListTableView{
    if (!_combBoxListTableView) {
        _combBoxListTableView = [[UITableView alloc]init];
        _combBoxListTableView.delegate = self;
        _combBoxListTableView.dataSource = self;
        _combBoxListTableView.frame = self.listView.bounds;
        _combBoxListTableView.showsVerticalScrollIndicator = NO;
    }
    return _combBoxListTableView;
}
-(UIView *)listView{
    if (!_listView) {
        _listView = [[UIView alloc]initWithFrame:CGRectMake(self.left, self.bottom-1, self.width, 0)];
        _listView.layer.borderWidth = 1;
        if(self.borderColor){
            _listView.layer.borderColor = [self.borderColor CGColor];
        }else{
            _listView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        }
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_listView];
        [_listView addSubview:self.combBoxListTableView];
    }
    
    return _listView;
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArrayM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"comboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = self.listArrayM[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self comBoxBtnClick:self.comBoxBtn];
    self.disPlayLabel.text = self.listArrayM[indexPath.row];
    if ([self.disPlayLabel.text isEqualToString:@"请选择"])return;
    if ([self.delegate respondsToSelector:@selector(comboBoxView:didSelectRowAtIndex:rowTitle:)]) {
        [self.delegate comboBoxView:self didSelectRowAtIndex:indexPath.row-1 rowTitle:self.disPlayLabel.text];
    }
}

@end
