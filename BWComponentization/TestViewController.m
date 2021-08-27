//
//  TestViewController.m
//  BWComponentization
//
//  Created by bairdweng on 2021/8/27.
//

#import "TestViewController.h"
#import "Router.h"
#import "BWService.h"
#import "CommentProtocol.h"
#import "LoginProtocol.h"
@interface TestViewController ()<RouterProtocol>

@property(nonatomic, copy) RouterCallBack callback;

@end

@implementation TestViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"我是测试页面";
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self sendMessage];
	});
	// Do any additional setup after loading the view from its nib.
}

- (void)sendMessage {
	if (self.callback) {
		self.callback(@"Test", @{@"name":@"hello"});
	}
}

- (void)eventCallBack:(RouterCallBack)callBack {
	self.callback = callBack;
}

- (IBAction)openLoginModule:(id)sender {
	id<LoginProtocol> login = [[BWService sharedManger]serviceInstanceWithProtocol:@protocol(LoginProtocol)];
	[login openLogin];
}

- (IBAction)openCommentModule:(id)sender {
	id<CommentProtocol> comment = [[BWService sharedManger]serviceInstanceWithProtocol:@protocol(CommentProtocol)];
	[comment openComment];
	[comment getComment:^(NSString *text) {
	         NSLog(@"获取评论啊==========%@",text);
	 }];
}


/*
 #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
