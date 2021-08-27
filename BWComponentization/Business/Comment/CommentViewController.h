//
//  CommentViewController.h
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/26.
//

#import <UIKit/UIKit.h>
#import "RouterProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController<RouterProtocol>

@property(nonatomic, copy) RouterCallBack callBack;

@end

NS_ASSUME_NONNULL_END
