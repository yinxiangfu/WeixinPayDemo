//
//  XFPayView.h
//  WeixinPayDemo
//
//  Created by yinxiangfu on 16/5/18.
//  Copyright © 2016年 xiangfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KindModel.h"

@interface XFPayView : UIView

@property (nonatomic, copy) void(^block)(NSString *pswd);

- (instancetype)initWithKindModel:(KindModel *)kindModel money:(CGFloat)money;

- (void)show;

@end
