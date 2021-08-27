//
//  ViewController.m
//  BWComponentization
//
//  Created by bairdweng on 2021/8/27.
//

#import "ViewController.h"
#import "Router.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)openPage:(id)sender {
	[Router openName:@"Test" params:@{}];
}

- (IBAction)openPageCallBack:(id)sender {
	[Router openName:@"Test" params:@{} callBack:^(NSString *name, id params) {
	         NSLog(@"页面名称：%@  回调内容：%@",name,params);
	 }];
}

@end
