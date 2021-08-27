//
//  BWService.h
//  BWProtocolExample
//
//  Created by bairdweng on 2021/8/19.
//

#import <Foundation/Foundation.h>

@interface BWService : NSObject

@property (nonatomic,assign) BOOL ignoreSafeMode;

+ (instancetype)sharedManger;

- (id)serviceInstanceWithProtocol:(Protocol *)aProtocol;
- (void)configProtocolServiceMapsWithDic:(NSDictionary < NSString *,NSString *> *)mapDics;

@end
