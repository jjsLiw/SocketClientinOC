//
//  SocketClient.h
//  MyClient
//
//  Created by leemac on 2021/5/16.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#import "SocketConnection.h"
#import "SocketPacketListener.h"
#import "SocketMessageHandler.h"
#import "SocketMyLogic.h"
#import "SocketPacketData.h"
#import "SocketByteBuffer.h"

 

@interface SocketClient : NSObject
{
    SocketConnection* connect;
    SocketMyLogic *logic;
    NSString *ip;
    int port;
    
}

-(instancetype)initWith:(NSString *)ip port:(int )port;


@end

 
