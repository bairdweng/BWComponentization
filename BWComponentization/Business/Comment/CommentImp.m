//
//  CommentImp.m
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/19.
//

#import "CommentImp.h"
#import "Router.h"
#import "CommentViewController.h"
@interface CommentImp ()<CommentProtocol>

@property(nonatomic, copy) RouterCallBack callBack;

@property(nonatomic, strong) CommentViewController *commentVc;
@end

@implementation CommentImp

- (void)openComment {
	id<RouterProtocol> target = [Router openName:@"Comment" params:nil];
	self.commentVc = (CommentViewController *)target;
}

- (void)getComment:(void (^)(NSString *))block {
	self.commentVc.callBack = ^(NSString *name, id params) {
		if (block) {
			NSString *text = [params objectForKey:@"text"];
			block(text);
		}
	};
}

@end
