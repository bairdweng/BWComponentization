//
//  AppDelegate.m
//  BWComponentization
//
//  Created by bairdweng on 2021/8/27.
//

#import "AppDelegate.h"
#import "Router.h"
#import "BWService.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	[self configRouter];
	[self configServiceMaps];
	return YES;
}

// 配置路由
- (void)configRouter {
	[Router registerName:@"Test" ClassName:@"TestViewController"];
	[Router registerName:@"Comment" ClassName:@"CommentViewController"];
}
// 配置服务
- (void)configServiceMaps {
	NSDictionary *mapDic = @{
		@"LoginProtocol":@"LoginImp",
		@"CommentProtocol":@"CommentImp"
	};
	//recommend : 项目Map较多，可plist文件维护【避免代码硬编码类出错】！
	[[BWService sharedManger] configProtocolServiceMapsWithDic:mapDic];
}


@end
