//
//  ViewController.m
//  WeixinPayDemo
//
//  Created by yinxiangfu on 16/5/18.
//  Copyright © 2016年 xiangfu. All rights reserved.
//

#import "ViewController.h"
#import "XFPayWaySelectView.h"
#import "XFPayView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)click:(id)sender {
    [self showKindeSelectView];
}

- (void)showKindeSelectView
{
    KindModel *md1 = [[KindModel alloc] init];
    md1.img = @"gongshang";
    md1.name = @"工商银行 储蓄卡（1234）";
    
    KindModel *md2 = [[KindModel alloc] init];
    md2.img = @"gongshang";
    md2.name = @"农业银行 储蓄卡（5678）";
    
    KindModel *md3 = [[KindModel alloc] init];
    md3.img = @"gongshang";
    md3.name = @"瑞士银行 储蓄卡（6666）";
    
    NSArray *arr = @[md1, md2, md3];
    
    XFPayWaySelectView *payWaySelectView = [[XFPayWaySelectView alloc] initWithKindArr:arr];
    
    __weak typeof(self)weakSelf = self;
    payWaySelectView.block = ^(KindModel *md){
        if (md == nil) {
            UIViewController *ctr = [[UIViewController alloc] init];
            ctr.title = @"添加新卡";
            ctr.view.backgroundColor = [UIColor whiteColor];
            [weakSelf.navigationController pushViewController:ctr animated:YES];
        }else{
            XFPayView *payView = [[XFPayView alloc] initWithKindModel:md money:1000.00];
            payView.block = ^(NSString *pswd){
                if ([pswd isEqualToString:@"change"]) {
                    [self showKindeSelectView];
                }else{
                    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)) {
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"输入密码"
                                                                                       message:pswd
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                              handler:^(UIAlertAction * action) {}];
                        
                        [alert addAction:defaultAction];
                        [weakSelf presentViewController:alert animated:YES completion:nil];
                    }else{
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"输入密码" message:pswd delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alter show];
                    }
                }
                
            };
            [payView show];
        }
    };
    [payWaySelectView show];
}
@end
