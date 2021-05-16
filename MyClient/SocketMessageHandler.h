//
//  SocketMessageHandler.h
//  MyClient
//
//  Created by leemac on 2021/5/16.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
NS_ASSUME_NONNULL_BEGIN

@interface SocketMessageHandler : NSObject
{
    NSMutableDictionary <NSString * ,NSString*>* m_op_map;
    
}

-(void)addOp:(NSString*)op func:(NSString*)func;
-(void)OnPacketArrived:(NSString*)packet;


@end

NS_ASSUME_NONNULL_END
