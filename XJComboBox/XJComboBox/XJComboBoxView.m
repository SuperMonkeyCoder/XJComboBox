//
//  XJComboBoxView.m
//  XJComboBox
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 DemonDeveloper@163.com. All rights reserved.
//

#import "XJComboBoxView.h"
#import "UIView+ITTAdditions.h"
#define LEFTTITLE self.leftTitle?[NSString stringWithFormat:@"%@：",self.leftTitle]:@""
@interface XJComboBoxView ()<UITableViewDelegate, UITableViewDataSource>

//下拉载数据view
@property (nonatomic, strong) UITableView *combBoxListTableView;

@property (nonatomic, strong) UIView *listView;

@property (nonatomic, strong) UIButton *comBoxBtn;

//显示的文本框
@property (nonatomic, strong) UILabel *disPlayLabel;

//显示数据名 数组
@property (nonatomic, strong) NSMutableArray *displayNames;
//数据ID 数组
@property (nonatomic, strong) NSMutableArray *valueMembers;
@end

@implementation XJComboBoxView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        //触模
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabGestureHandler:)];
        [self addGestureRecognizer:tapGesture];
        [self loadComboBoxView];
        
    }
    return self;
}


- (void)tabGestureHandler:(UITapGestureRecognizer *)gesture
{
    [self comBoxBtnClick:self.comBoxBtn];
}
-(void)loadComboBoxView{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.width - self.height - 10, self.height)];
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

-(void)setDataSource:(NSArray *)dataSource{

    if (self.displayMember!=nil) {
        for (int i = 0; i < dataSource.count; i++) {
            id obj = dataSource[i];
            [self.displayNames addObject: [obj valueForKeyPath:self.displayMember]];
            if (self.valueMember !=nil) {
                [self.valueMembers addObject:[obj valueForKeyPath:self.valueMember]];
            }
        }
    }
}
-(NSMutableArray *)displayNames{
    if (!_displayNames) {
        _displayNames = [NSMutableArray array];
    }
    return _displayNames;
}

-(NSMutableArray *)valueMembers{
    if (!_valueMembers) {
        _valueMembers = [NSMutableArray array];
    }
    return _valueMembers;
}

-(void)setDefaultTitle:(NSString *)defaultTitle{
    _defaultTitle = defaultTitle;
    self.disPlayLabel.text = [NSString stringWithFormat:@"%@%@",LEFTTITLE,defaultTitle];
}

-(void)comBoxBtnClick:(UIButton *)btn{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self convertRect:self.bounds toView:window];
    self.listView.top = rect.origin.y+ self.height;
    self.listView.left = rect.origin.x;
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        [UIView animateWithDuration:0.25 animations:^{
            if( self.displayNames.count * self.height > 160){
                self.listView.height = 160;
                self.combBoxListTableView.height = 160;
            }else{
                self.listView.height = self.displayNames.count * self.height;
                self.combBoxListTableView.height = self.displayNames.count * self.height;
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
-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    self.disPlayLabel.text = [NSString stringWithFormat:@"%@",LEFTTITLE];
}

#pragma mark - 懒加载
-(UITableView *)combBoxListTableView{
    if (!_combBoxListTableView) {
        _combBoxListTableView = [[UITableView alloc]init];
        _combBoxListTableView.delegate = self;
        _combBoxListTableView.dataSource = self;
        _combBoxListTableView.frame = self.listView.bounds;
    }
    return _combBoxListTableView;
}
-(UIView *)listView{
    if (!_listView) {
//        _listView = [[UIView alloc]initWithFrame:CGRectMake(self.left, self.bottom-self.borderWidth, self.width, 0)];
         UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _listView = [[UIView alloc]initWithFrame:CGRectMake(self.left, self.bottom, self.width, 0)];
        if(self.borderColor){
            _listView.layer.borderColor = [self.borderColor CGColor];
        }else{
            _listView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        }
        if (self.borderWidth) {
            _listView.layer.borderWidth = self.borderWidth;
        }else{
            _listView.layer.borderWidth = 1;
        }
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_listView];
        [_listView addSubview:self.combBoxListTableView];
    }
    
    return _listView;
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.displayNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"comboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = self.displayNames[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self comBoxBtnClick:self.comBoxBtn];
    self.disPlayLabel.text = [NSString stringWithFormat:@"%@%@", LEFTTITLE,self.displayNames[indexPath.row]];
    if ([self.disPlayLabel.text isEqualToString:[NSString stringWithFormat:@"%@%@",LEFTTITLE , @"请选择"]])return;
    if ([self.delegate respondsToSelector:@selector(comboBoxView:didSelectRowAtValueMember:displayMember:)]) {
        if (self.valueMembers.count > 0) {
            [self.delegate comboBoxView:self didSelectRowAtValueMember:[NSString stringWithFormat:@"%@",self.valueMembers[indexPath.row]] displayMember:self.displayNames[indexPath.row]];
        }else{
             [self.delegate comboBoxView:self didSelectRowAtValueMember:[NSString stringWithFormat:@"%ld",indexPath.row] displayMember:self.displayNames[indexPath.row]];
        }
       
    }
}

@end
