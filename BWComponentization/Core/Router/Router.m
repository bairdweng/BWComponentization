//
//  Router.m
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/25.
//

#import "Router.h"
#import <UIKit/UIKit.h>

@interface Router ()

@property(nonatomic, strong) NSMutableDictionary *routerEnter;
@property(nonatomic, strong) UINavigationController *rootVc;
@end

@implementation Router

WF_DEF_SINGLETION(Router)

+ (id<RouterProtocol>)openName:(NSString *)name params:(NSDictionary *)params {
	return [self openName:name params:params callBack:nil];
}

+ (id<RouterProtocol>)openName:(NSString *)name params:(NSDictionary *)params callBack:(RouterCallBack)callback {
	NSString *className = (NSString *)[[self sharedInstance].routerEnter objectForKey:name];
	if (!className) {
		NSLog(@"class不存在%@",className);
		return nil;
	}
	Class targetClass = NSClassFromString(className);
	id target = [[targetClass alloc]init];
	// 实现了协议
	if ([target conformsToProtocol:@protocol(RouterProtocol)]) {
		id <RouterProtocol> helloVc = target;
		if ([helloVc respondsToSelector:@selector(openVc:)]) {
			[helloVc openVc:[self sharedInstance].rootVc];
		}
		else {
			[[self sharedInstance]openTarget:target];
		}
		if ([helloVc respondsToSelector:@selector(eventCallBack:)]) {
			[helloVc eventCallBack:callback];
		}
		return target;
	}
	// 未实现
	else {
		[[self sharedInstance]openTarget:target];
	}
	return target;
}

+ (void)registerName:(NSString *)name ClassName:(NSString *)clsName {
	[[self sharedInstance].routerEnter setObject:clsName forKey:name];
}

- (void)openTarget:(id)target {
	if ([target isKindOfClass:[UIViewController class]]) {
		[self.rootVc pushViewController:target animated:YES];
	}
}

- (NSMutableDictionary *)routerEnter {
	if (!_routerEnter) {
		_routerEnter = [[NSMutableDictionary alloc]init];
	}
	return _routerEnter;
}

- (UINavigationController *)rootVc {
	UIWindow *window =  [[UIApplication sharedApplication].windows firstObject];
	return (UINavigationController *)window.rootViewController;
}

@end
