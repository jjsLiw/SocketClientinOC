//
//  SocketMyLogic.h
//  MyClient
//
//  Created by liw on 2021/5/22.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "SocketMessageHandler.h"

#import "SocketConnection.h"
#import "SocketPacketData.h"

@interface SocketMyLogic : SocketMessageHandler

{
      SocketConnection *connection;

}



-(void)test:(SocketPacketData*)op;
-(void)ordercome:(SocketPacketData*)op;
-(void)test3:(SocketPacketData*)op;
-(void)test4:(SocketPacketData*)op;
-(void)test5:(SocketPacketData*)op;
-(void)test6:(SocketPacketData*)op;
-(void)test7:(SocketPacketData*)op;
-(void)test8:(SocketPacketData*)op;
-(void)test9:(SocketPacketData*)op;


- (void)MakeAndSendTestPacket:(int)op;


-(void)sendPacket:(SocketPacketData*)packet;


-(SocketConnection *)getConnection;
-(void)setConnetion:(SocketConnection *)con;

@end

 
