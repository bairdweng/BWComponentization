//
//  RouterProtocol.h
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^RouterCallBack)(NSString *name,id params);

@protocol RouterProtocol <NSObject>

@optional

- (void)openVc:(UIViewController *)vc;

- (void)eventCallBack:(RouterCallBack)callBack;

@end
