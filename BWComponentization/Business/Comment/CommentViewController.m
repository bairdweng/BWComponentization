//
//  CommentViewController.m
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/26.
//

#import "CommentViewController.h"
#import "Router.h"
@interface CommentViewController ()<RouterProtocol>
@end

@implementation CommentViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"评论模块";
	// Do any additional setup after loading the view from its nib.
}

- (void)openVc:(UIViewController *)vc {
	[vc presentViewController:self animated:YES completion:nil];
}

- (IBAction)clickOntheBtn:(id)sender {
	if (self.callBack) {
		self.callBack(@"comment", @{@"text":@"hello world"});
	}
}

- (void)dealloc {
	NSLog(@"评论模块被释放了～～～～");
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
