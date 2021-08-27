//
//  LoginImp.m
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/19.
//

#import "LoginImp.h"

@interface LoginImp ()<LoginProtocol>

@end

@implementation LoginImp

- (void)openLogin {
	NSLog(@"打开登录");
}

@end
