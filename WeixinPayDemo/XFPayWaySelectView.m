//
//  XFPayWaySelectView.m
//  WeixinPayDemo
//
//  Created by yinxiangfu on 16/5/18.
//  Copyright © 2016年 xiangfu. All rights reserved.
//

#import "XFPayWaySelectView.h"

const CGFloat cellHeight = 40;

@interface XFPayWaySelectView () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_kindArr;
}
@end
@implementation XFPayWaySelectView

- (instancetype)initWithKindArr:(NSArray<KindModel *> *)kindArr
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _kindArr = kindArr;
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUI_WIDTH-100, cellHeight*(2+_kindArr.count)) style:UITableViewStylePlain];
    tableView.center = CGPointMake(self.center.x, self.center.y);
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
    return _kindArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.row == _kindArr.count) {
        cell.imageView.image = nil;
        cell.textLabel.text = @"               使用新卡支付";
    }else{
        KindModel *md = _kindArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:md.img];
        cell.textLabel.text = md.name;
    }
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), cellHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headerView.frame), cellHeight)];
    lb.text = @"选择支付方式";
    lb.textColor = [UIColor blackColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:17 weight:1];
    [headerView addSubview:lb];
    
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBt setTitle:@"<" forState:UIControlStateNormal];
    [backBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(remv) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = 30;
    backBt.frame = CGRectMake(5, cellHeight/2-width/2, width, width);
    [headerView addSubview:backBt];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-1, CGRectGetWidth(headerView.frame), 0.3)];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self remv];
        if (self.block) {
            if (indexPath.row == _kindArr.count) {
                self.block(nil);
            }else
                self.block(_kindArr[indexPath.row]);
        }
    });
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointZero;
    }
}
@end
