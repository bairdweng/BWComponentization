//
//  CommentProtocol.h
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/19.
//

#import <Foundation/Foundation.h>

@protocol CommentProtocol <NSObject>
// 定义一个打开评论
- (void)openComment;
- (void)getComment:(void (^)(NSString *text))block;

@end
