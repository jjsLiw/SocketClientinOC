//
//  SocketMyLogic.m
//  MyClient
//
//  Created by liw on 2021/5/22.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "SocketMyLogic.h"

@implementation SocketMyLogic
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initFuncs];
    }
    return self;
}
-(void)initFuncs{
//    
//    this.AddOp(0x121001, "test");
//            this.AddOp(0x121002, "ordercome");
//            this.AddOp(0x121003, "test3");
//            this.AddOp(0x121004, "test4");
//            this.AddOp(0x121005, "test5");
//            this.AddOp(0x121006, "test6");
//            this.AddOp(0x121007, "test7");
//            this.AddOp(0x121008, "test8");
//            this.AddOp(0x121009, "test9");
    
    [self addOp:@"0x121002" func:@"ordercome"];
    [self addOp:@"0x121003" func:@"test3"];
    [self addOp:@"0x121004" func:@"test4"];
    [self addOp:@"0x121005" func:@"test5"];
    [self addOp:@"0x121006" func:@"test6"];
    [self addOp:@"0x121007" func:@"test7"];
    [self addOp:@"0x121008" func:@"test8"];
    [self addOp:@"0x121009" func:@"test9"];

}

-(void)test:(SocketPacketData*)op{
//    System.out.println("1 packet from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("---------------test包已结束---------------------------\n\n\n");
    
    NSLog(@"1 packet from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"--------------test包已结束---------------------------\n\n");
    
    
    
}


//op=121002 对应的处理方法
//public void ordercome(PacketData op)
//{
//    System.out.println("2 新指令包msg from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------指令接收完------------------------\n\n\n");
//}
-(void)ordercome:(SocketPacketData*)op{
    NSLog(@"2 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"------------------------指令接收完-------------------------------\n\n");
    
}

//public void test3(PacketData op)
//{
//    System.out.println("3 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test3收完------------------------\n\n\n");
//}
-(void)test3:(SocketPacketData*)op{
    NSLog(@"3 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test3收完--------------------------------\n\n");
    
}

//public void test4(PacketData op)
//{
//    System.out.println("4 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test4收完------------------------\n\n\n");
//}

-(void)test4:(SocketPacketData*)op{
    NSLog(@"4 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test4收完--------------------------------\n\n");
    
}
//public void test5(PacketData op)
//{
//    System.out.println("5 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test5收完------------------------\n\n\n");
//}

-(void)test5:(SocketPacketData*)op{
    NSLog(@"5 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test5收完--------------------------------\n\n");
    
}
//public void test6(PacketData op)
//{
//    System.out.println("6 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test6收完------------------------\n\n\n");
//}

-(void)test6:(SocketPacketData*)op{
    NSLog(@"6 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test6收完--------------------------------\n\n");
    
}
//public void test7(PacketData op)
//{
//    System.out.println("7 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test7收完------------------------\n\n\n");
//}

-(void)test7:(SocketPacketData*)op{
    NSLog(@"7 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test7收完--------------------------------\n\n");
    
}
//public void test8(PacketData op)
//{
//    System.out.println("8 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test8收完------------------------\n\n\n");
//}

-(void)test8:(SocketPacketData*)op{
    NSLog(@"8 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test8收完--------------------------------\n\n");
    
}
//public void test9(PacketData op)
//{
//    System.out.println("9 from Server, op = " + op.getOp());
//
//    //处理方法：仅显示包内容
//    op.ShowPacket();
//
//    System.err.println("-----------------test9收完------------------------\n\n\n");
//}

-(void)test9:(SocketPacketData*)op{
    NSLog(@"9 新指令包msg from Server, op =  %d",op.getOp);
    [op ShowPacket];
    NSLog(@"----------------------test9收完--------------------------------\n\n");
    
}

//构造和发送测试包
//public void MakeAndSendTestPacket(int op) {
//    PacketData data = new PacketData(op);
//    data.MakeTestPacket(1001);
//    connection.sendPacket(data);
//}
- (void)MakeAndSendTestPacket:(int)op{
    
    SocketPacketData *opP = [[SocketPacketData alloc]init];
    [opP PacketData:op];
    
    [opP MakeTestPacket:1001];
    
    [connection sendPacket:opP];
    
    
}

-(void)sendPacket:(SocketPacketData*)packet{
    [connection sendPacket:packet];
    
}
-(SocketConnection *)getConnection{
    return connection;
}
-(void)setConnetion:(SocketConnection *)con{
    connection = con;
}
@end
