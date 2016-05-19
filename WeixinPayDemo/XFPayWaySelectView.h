//
//  XFPayWaySelectView.h
//  WeixinPayDemo
//
//  Created by yinxiangfu on 16/5/18.
//  Copyright © 2016年 xiangfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KindModel.h"

#define kUI_WIDTH        [UIScreen mainScreen].bounds.size.width
#define kUI_HEIGHT       [UIScreen mainScreen].bounds.size.height

@interface XFPayWaySelectView : UIView

@property (nonatomic, copy) void(^block)(KindModel *md);

- (instancetype)initWithKindArr:(NSArray<KindModel *> *)kindArr;

- (void)show;

@end
