//
//  SocketConnection.h
//  MyClient
//
//  Created by leemac on 2021/5/16.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#import "SocketPacketListener.h"
#import "SocketByteBuffer.h"
#import "SocketPacketData.h"
#import "SocketMessageHandler.h"

static int TIME_OUT_VAL = 1000;

 

@interface SocketConnection : SocketPacketListener
{
@private
    BOOL m_bValid;
    int m_sock;
    
    char*  m_input;
    char*  m_output;
    
    SocketByteBuffer *m_buf;
    SocketPacketHead *m_head;
    
    
}

-(void)Connection:(SocketMessageHandler *)handler;
-(void)ConnectionWS:(int)socket;


-(void)sendPacket:(SocketPacketData*)packet;

-(int)start:(NSString *)server_addr withPort:(int)port;

-(BOOL)initWith:(NSString *)server_addrString withPort:(int)port;

-(void)close;


@end

 
