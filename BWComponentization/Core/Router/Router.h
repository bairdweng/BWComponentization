//
//  Router.h
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/25.
//

#import <Foundation/Foundation.h>

#import "RouterProtocol.h"

#define WF_AS_SINGLETION( __class ) \
	+ (__class *)sharedInstance;

#define WF_DEF_SINGLETION( __class ) \
	+ (__class *)sharedInstance \
	{ \
		static dispatch_once_t once; \
		static __class * __singleton__; \
		dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
		return __singleton__; \
	}

@interface Router : NSObject

	WF_AS_SINGLETION(Router)

+ (void)registerName:(NSString *)name ClassName:(NSString *)name;
+ (id<RouterProtocol>)openName:(NSString *)name params:(NSDictionary *)params;
+ (id<RouterProtocol>)openName:(NSString *)name params:(NSDictionary *)params callBack:(RouterCallBack)callback;

@end
