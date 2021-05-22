//
//  SocketClient.m
//  MyClient
//
//  Created by leemac on 2021/5/16.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "SocketClient.h"

@implementation SocketClient

-(id)init{
    self = [super init];
    if (self) {
        connect = [[SocketConnection alloc]init];
        logic = [[SocketMyLogic alloc]init];
        [logic setConnetion:connect];
        
    }
    return self;
}
-(instancetype)initWith:(NSString *)outip port:(int )outPort{
    self = [super init];
    if (self) {
        ip = outip;
        port = outPort;
        
        connect = [[SocketConnection alloc]init];
        BOOL isSuccess  = [connect start:ip withPort:port];
//        = [connect start:ip withPort:port];
        if (isSuccess) {
            NSLog(@"成功连接");
        }else{
            NSLog(@"NO成功连接NNNN");
        }
        
        
        logic = [[SocketMyLogic alloc]init];
        [logic setConnetion:connect];
    }
    return self;
}

-(void)close{
    
}


@end
