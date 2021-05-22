//
//  SocketPacketData.m
//  MyClient
//
//  Created by leemac on 2021/5/16.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "SocketPacketData.h"

static int HEAD_LEN = 4+4+4+4;

@implementation SocketPacketHead

-(id)init{
    self = [super init];
    if (self) {
        self.on = false;
    }
    return self;
}

-(void)Deserialize:(SocketByteBuffer *)buf{
    _magic = [buf getInt];// buf.getInt();
    _len = [buf getInt];// buf.getInt();
    _op = [buf getInt];//buf.getInt();
    _param = [buf getInt];//buf.getInt();
}
@end



@implementation SocketPacketData
{
    
//@public
//    int _m_row;
//    int _m_col;
//    NSMutableDictionary *_m_map;
//    NSMutableArray *_m_array;//为何会冲突？dublelicapte?
//    NSString *_INVALID_STRING_VAL;
    
    
//@private
    BOOL m_bResult;
    int m_magic;
    int m_len;
    int m_op;
    int m_param;
    
}


-(int)getM_magic{
    return m_magic;
}
-(void)setM_magic:(int)magic{
    m_magic = magic;
}
-(int)getM_param{
    return m_param;
}
-(void)setM_param:(int)param{
    m_param = param;
}

-(void)PacketData:(int)op{
    m_op = op;
    _m_row = _m_col = 0;
    _m_map = [NSMutableDictionary dictionary];//  new HashMap<String,String>();
    _m_array = [NSMutableArray array];// new Vector<String>();
    _INVALID_STRING_VAL =@"";// new String("");
    self.m_byte_buf = [NSMutableArray array ] ;//new ArrayList<byte[]>();
}

-(BOOL)IsPacketValid{
    return m_bResult;;
}

-(void)setOp:(int)op{
    m_op  = op;
}

-(int)getOp{
    return m_op;
}
-(void)setParam:(int)param{
    m_param = param;
}
-(int)getParam{
    return m_param;
}
-(void)MakeTestPacket:(int)param{
    m_param= param;
    [self addMapElement:@"adfasdf" :@"asdfsadfsadfsdf"];
    [self addMapElement:@"xiaopang" :@"xiao pang"];
    [self addMapElement:@"feifei" :@"feifei"];
    [self setCol:3];
    [self AddRow];
    [self setArrayValue:0 :0 val:@"xiao pang"];
    [self setArrayValue:0 :1 val:@"feifei"];
    [self setArrayValue:0 :2 val:@"ieo"];

    [self AddRow];
    
    [self setArrayValue:1 :0 val:@"project"];
    [self setArrayValue:1 :1 val:@"automation"];
    [self setArrayValue:1 :2 val:@"testpacket"];
    
}

-(void)MakeLoginPacket:(int)param{
    m_param = param;
    [self addMapElement:@"username" :@"58" ];
    [self addMapElement:@"pwd" :@"5dd8" ];
    [self   setCol:1];
    [self AddRow];
    [self setArrayValue:0 :0 val:@"请求验证登录"];
}
-(void)MakeQueryCommandPacket:(int)param{
    m_param = param;
    [self addMapElement:@"rid" :@"103" ];
    [self addMapElement:@"days" :@"30" ];
    [self addMapElement:@"status" :@"TIMEOUT" ];
    [self addMapElement:@"uid" :@"123" ];

    [self   setCol:1];
    [self AddRow];
    [self setArrayValue:0 :0 val:@"请求指令数据"];
}
-(void)ShowPacket{
    NSLog(@"magic+=%d",m_magic);
    NSLog(@"m_len+=%d",m_len);
    NSLog(@"m_op+=%d",m_op);
    NSLog(@"m_param+=%d",m_param);
    NSLog(@"dic = %@",_m_map);
    NSLog(@"dim_arrayc = %@",_m_array);
}
-(void)setPacketHeadLen:(int)len{
    m_len = len;
}
-(void)SerializeHead:(SocketByteBuffer*)buf{
    [buf putInt:m_magic];
    [buf putInt:m_len];
    [buf putInt:m_op];
    [buf putInt:m_param];
    
}
-(void)DeserializeHead:(SocketPacketHead*)packet_head{
    m_magic = packet_head.magic;
    m_len = packet_head.len;
    m_op = packet_head.op;
    m_param = packet_head.param;
    
}
-(void)SerializeBody:(SocketByteBuffer*)buf{
    
    int map_size  = (int)_m_map.allKeys.count;
    [buf putInt:map_size];
    if (map_size>0) {
        for (NSString *key in _m_map.allKeys) {
            
            NSString *value = _m_map[key];
            
            [buf putString:key];
            [buf putString:value];
        }
    }
    
    [buf putInt:_m_row];
    [buf putInt:_m_col];
    if (_m_row>0 && _m_col > 0) {
        for (int i = 0; i< _m_row; i++) {
            for (int j = 0 ; j< _m_col; j++) {
                [buf putString:_m_array[[self CalculPos:i :j]]];
            }
        }
    }
    
    [buf putInt:(int)self.m_byte_buf.count];
    for (int i = 0; i< self.m_byte_buf.count; i++) {
        NSData *data = self.m_byte_buf[i];
        Byte *b = (Byte*)[data bytes];
        
        [buf putByteArray:b len:data.length];
        
    }
    
    
}
-(void)DeserializeBody:(SocketByteBuffer*)buf{
 
    int map_size = buf.getInt;
    if (map_size>0) {
        for (int i = 0; i< map_size; i++) {
            NSString *key = buf.getString;
            NSString *value =buf.getString;
            [_m_map setValue:value forKey:key];
        }
    }
    
    _m_row = buf.getInt;
    _m_col = buf.getInt;
    
    
    if (_m_row >0 && _m_col > 0) {
        for (int i = 0; i< _m_row; i++) {
            for (int j = 0; j< _m_col; j++) {
                NSString *val = buf.getString;
                [_m_array addObject:val];
            }
        }
    }else{
        _m_row = _m_col = 0;
    }
    
    int buf_array_size = buf.getInt;
    for (int i = 0; i< buf_array_size; i++) {
        Byte *bute =  buf.getByteArray;
        NSData *data = [NSData dataWithBytes:bute length:sizeof(bute)];//Byte 2 Data
        
        [self.m_byte_buf addObject:data];
        
    }
    
}

/////////////////关于map的操作/////////////////////////////////////////////////////
-(void)addMapElement:(NSString*)key :(NSString*)val{
    
    [_m_map setValue:val forKey:key];
}

-(NSString*)getMapString:(NSString*)key{
    return [_m_map valueForKey:key];
}
-(BOOL)ContainKey:(NSString*)key{
    return [[_m_map allKeys]containsObject:key];
}
-(int)getMapSize{
    return (int)[_m_map allKeys].count;
}
-(void)AddByteArray:(Byte*)c{
//    Byte *bute =  buf.getByteArray;
    NSData *data = [NSData dataWithBytes:c length:sizeof(c)];//Byte 2 Data
    
    [self.m_byte_buf addObject:data];
}
-(int)GetByteArrayCount{
    return (int)self.m_byte_buf.count;
}
-(Byte*)GetByteArray:(int)pos{
    if (pos < self.m_byte_buf.count && pos>=0) {
        NSData *data = self.m_byte_buf[pos];
        Byte *b = NULL;
        [data getBytes:&b length:data.length];
        return b;
    }
    return nil;
}
-(int)getRow{
    return _m_row;
}
-(int)getCol{
    return _m_col;
}
-(int)setCol:(int)col{
//    _m_col = col;
    int ret = -1;
    if (col >0 ) {
        [_m_array removeAllObjects];
        _m_row = 0;
        _m_col = col;
        ret = 0;
    }
    return ret;
}
-(int)AddRow{
     
    int ret = -1;
    if (_m_col > 0) {
        ret = _m_row;
        ++_m_row;
        for (int i = 0; i< _m_col ; i++) {
            [_m_array addObject:@""];
        }
    }
    
    return  ret;
    
}
-(int)setArrayValue:(int)row :(int)col val:(NSString*)val{
    
    if (false == [self IsPosValid:row :col]) {
        return -1;;
    }
    
    int pos  = [self CalculPos:row :col];
    _m_array [pos] = val;
    
    return 0;
}
-(NSString*)getArrayValue:(int)row :(int)col  {
    
    if (false == [self IsPosValid:row :col]) {
        return _INVALID_STRING_VAL;;
    }
    
    return _m_array[[self CalculPos:row :col]];
    
}
    
-(BOOL)IsPosValid:(int)row : (int)col{
    if ( row< 0 || col <0) {
        return false;
    }
    if (row>= _m_row || col >= _m_col) {
        return false;
    }
    int pos = [self CalculPos:row :col];
    if (pos > _m_array.count) {
        return false;
    }
    return true;
}
-(int)CalculPos:(int)row : (int)col{
    
    int pos = 0;
    
    if (row==0) {
        pos = col;
        
    }
    else{
        pos = row*_m_col + col;
    }
    
    return pos;
}
-(BOOL)IsDataValid:(SocketByteBuffer*)buf{
    
    int min_packet_size = 12+4+(4+4) +4;
    return buf.getBufSize >= min_packet_size;
}


@end
