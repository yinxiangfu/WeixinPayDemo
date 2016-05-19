//
//  XFPayView.m
//  WeixinPayDemo
//
//  Created by yinxiangfu on 16/5/18.
//  Copyright © 2016年 xiangfu. All rights reserved.
//

#import "XFPayView.h"
#import "XFPayWaySelectView.h"

@interface XFPayView () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    KindModel *_kindModel;
    CGFloat _money;
    
}
@property (nonatomic, strong) UITextField *pswdTextfiled;
@property (nonatomic, strong) NSMutableArray *pointArr;
@end
@implementation XFPayView

- (instancetype)initWithKindModel:(KindModel *)kindModel money:(CGFloat)money
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.pointArr = [NSMutableArray arrayWithCapacity:6];
        _kindModel = kindModel;
        _money = money;
        [self initSubViews];
    }
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)remv{
    [self removeFromSuperview];
}

- (void)initSubViews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUI_WIDTH-100, 40+80+40+60) style:UITableViewStylePlain];
    tableView.center = CGPointMake(self.center.x, self.center.y-50);
    tableView.clipsToBounds = YES;
    tableView.layer.cornerRadius = 10;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator= NO;
    [self addSubview:tableView];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *cellID1 = @"cellID1";
    static NSString *cellID2 = @"cellID2";
    static NSString *cellID3 = @"cellID3";
    static NSString *cellID4 = @"cellID4";

    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40)];
            lb.text = @"请输入支付密码";
            lb.textColor = [UIColor blackColor];
            lb.textAlignment = NSTextAlignmentCenter;
            lb.font = [UIFont systemFontOfSize:17 weight:1];
            [cell addSubview:lb];
            
            UIButton *backbt = [UIButton buttonWithType:UIButtonTypeSystem];
            [backbt setTitle:@"X" forState:UIControlStateNormal];
            [backbt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [backbt addTarget:self action:@selector(remv) forControlEvents:UIControlEventTouchUpInside];
            backbt.frame = CGRectMake(5, 40/2-30/2, 30, 30);
            [cell addSubview:backbt];
        }
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            
            UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(tableView.frame), 30)];
            companyLabel.text = @"我的公司";
            companyLabel.textColor = [UIColor blackColor];
            companyLabel.textAlignment = NSTextAlignmentCenter;
            companyLabel.font = [UIFont systemFontOfSize:14];
            [cell addSubview:companyLabel];
            
            UILabel *moneyLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(companyLabel.frame)-10, CGRectGetWidth(tableView.frame), 50)];
            moneyLb.text = [NSString stringWithFormat:@"￥%.2f", _money];
            moneyLb.textColor = [UIColor blackColor];
            moneyLb.font = [UIFont systemFontOfSize:19 weight:1];
            moneyLb.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:moneyLb];
            
        }
    }else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.imageView.image = [UIImage imageNamed:_kindModel.img];
        cell.textLabel.text = [_kindModel.name stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:cellID4];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID4];
        }
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(tableView.frame)-10*2, 40)];
        v.layer.borderColor = [UIColor lightGrayColor].CGColor;
        v.layer.borderWidth = 0.5;
        [cell addSubview:v];
        
        UITextField *pswdTextfiled = [[UITextField alloc] initWithFrame:CGRectZero];
        [v addSubview:pswdTextfiled];
        pswdTextfiled.delegate = self;
        pswdTextfiled.keyboardType = UIKeyboardTypeNumberPad;
        [pswdTextfiled becomeFirstResponder];
        
        [self.pointArr removeAllObjects];
        for (int i = 0; i < 6; i ++) {
            CGPoint point = CGPointMake(CGRectGetWidth(v.frame)/6*(i+1), 0);
            
            UIBezierPath *linePath = [[UIBezierPath alloc] init];
            [linePath moveToPoint:point];
            [linePath addLineToPoint:CGPointMake(point.x, CGRectGetHeight(v.frame))];
            CAShapeLayer *lineLayer = [CAShapeLayer layer];
            lineLayer.strokeColor = v.layer.borderColor;
            lineLayer.fillColor = nil;
            lineLayer.lineWidth = v.layer.borderWidth;
            lineLayer.path = linePath.CGPath;
            [v.layer addSublayer:lineLayer];
            
            point = CGPointMake(CGRectGetWidth(v.frame)/6*(i+1) - CGRectGetWidth(v.frame)/12, CGRectGetHeight(v.frame)/2);
                                
            UIBezierPath *pointPath = [UIBezierPath bezierPathWithArcCenter:point radius:CGRectGetHeight(v.frame)/4 startAngle:0 endAngle:M_PI*2 clockwise:YES];
            CAShapeLayer *pointLayer = [CAShapeLayer layer];
            pointLayer.strokeColor = nil;
            pointLayer.fillColor = [UIColor blackColor].CGColor;
            pointLayer.path = pointPath.CGPath;
            [v.layer addSublayer:pointLayer];
            pointLayer.hidden = YES;
            [self.pointArr addObject:pointLayer];
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }else if (indexPath.row == 1){
        return 80;
    }else if (indexPath.row == 2){
        return 40;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.block) {
                self.block(@"change");
            }
            [self remv];
        });
    }
}
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:textField.text];
    [str replaceCharactersInRange:range withString:string];
    
    for (int i = 0; i < 6; i ++) {
        CAShapeLayer *layer = self.pointArr[i];
        if (i < str.length) {
            layer.hidden = NO;
        }else
            layer.hidden = YES;
    }
    if (str.length == 6) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.block) {
                self.block(str);
            }

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self remv];
            });
        });
    }
    return YES;
}
@end
