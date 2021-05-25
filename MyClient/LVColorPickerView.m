//
//  LVColorPickerView.m
//  MyClient
//
//  Created by liw on 2021/5/24.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "LVColorPickerView.h"

@implementation LVColorPickerView
{
    BOOL bJump;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    
#if DEBUG
    self.backgroundColor = [UIColor lightGrayColor];
#endif
}

-(void)drawRect:(CGRect)rect{
    
//
    CGContextRef context = UIGraphicsGetCurrentContext(); // 获取图形上下文 CGContextSaveGState(context); //压栈当前的绘制状态CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));//画一椭圆（这里是画圆）
//
//    CGContextClip(context); //以后绘制动作都会被限定在那个区域中
//
//    CGContextRestoreGState(context); //堆栈顶部的状态弹出，返回到之前的图形状态

//    CGMutablePathRef path = CGPathCreateMutable();//创建路径
//
//    CGPathMoveToPoint(path, 0, start.x, start.y);// 移动到起点
//
//    CGPathAddLineToPoint(path, 0, end1.x, end1.y); //从起点画到终点的直线
//
//    CGGradientRef gradient = CGGradientCreateWithColors(rgbColorSpace, (__bridge CFArrayRef)colors, NULL);// 创建渐变色
//
//    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);//在当前Context中填充渐变色
//
//    // 创建RGB色彩空间，创建这个以后，context里面用的颜色都是用RGB表示   CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
 
    CGSize size = rect.size;
    CGPoint center =CGPointMake(floorf(size.width/2.0f),floorf(size.height/2.0f));

     CGFloat radius = floorf(size.width/2.0f);

     // 创建RGB色彩空间，创建这个以后，context里面用的颜色都是用RGB表示

     CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();

     CGContextSaveGState(context);

     CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));

     CGContextClip(context);

     NSInteger numberOfSegments =360;

     for(CGFloat i =0; i < numberOfSegments; i++) {

      UIColor*color = [UIColor colorWithHue:1-i/(float)numberOfSegments saturation:1 brightness:1 alpha:1];

      CGContextSetStrokeColorWithColor(context, color.CGColor);

      CGFloat segmentAngle =2*M_PI/ (float)numberOfSegments;

      CGPoint start = center;

      CGPoint end =CGPointMake(center.x+ radius *cosf(i * segmentAngle), center.y+ radius *sinf(i * segmentAngle));

      CGMutablePathRef path = CGPathCreateMutable();

      CGPathMoveToPoint(path,0, start.x, start.y);

      CGFloat offsetFromMid =2.f*(M_PI/180);

      CGPoint end1 =CGPointMake(center.x+ radius *cosf(i * segmentAngle-offsetFromMid), center.y+ radius *sinf(i * segmentAngle-offsetFromMid));

      CGPoint end2 =CGPointMake(center.x+ radius *cosf(i * segmentAngle+offsetFromMid), center.y+ radius *sinf(i * segmentAngle+offsetFromMid));

      CGPathAddLineToPoint(path,0, end1.x, end1.y);

      CGPathAddLineToPoint(path,0, end2.x, end2.y);

      CGContextSaveGState(context);

      CGContextAddPath(context, path);

      CGPathRelease(path);

      CGContextClip(context);

      NSArray*colors =@[(__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor, (__bridge id)color.CGColor];

      // 通过成对的颜色值(colors)和位置(locations)创建一个渐变色，colors是一个由CGColor对象组成的非空数组，如果space非空，所有颜色都会转换到该色彩空间，并且渐变将绘制在这个色彩空间里面；否则（space为NULL），每一种颜色将会被转换并且绘制在一般的RGB色彩空间中。如果locations为NULL，第一个颜色在location 0，最后一个颜色在location 1， 并且中间的颜色将会等距分布在中间。locations中的每一个location应该是一个0~1之间的CGFloat值；locations数字的元素数量应该跟colors中的一样，如果没有颜色提供给0或者1，这个渐变将使用location中最靠近0或者1的颜色值

      CGGradientRef gradient =CGGradientCreateWithColors(rgbColorSpace, (__bridge CFArrayRef)colors,NULL);

      // 在当前context的裁剪的区域中，填充一个从startPoint到endPoint的线性渐变颜色。渐变色中location 0对应着startPoint；location 1对应着endPoint；颜色将根据locations的值线性插入在这两点（startPoint,endPoint）之间。option标志控制在startPoint之前和endPoint之后时候填充颜色。（跟开始的颜色还有最后的颜色相同）

      CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);

      CGGradientRelease(gradient);

      CGContextRestoreGState(context);

     }

     CGColorSpaceRelease(rgbColorSpace);

     CGContextRestoreGState(context);

     CGContextSetStrokeColorWithColor(context, UIColor.clearColor.CGColor);

     CGContextSetLineWidth(context, 1);

     CGContextStrokeEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));

//    作者：蹦擦擦我勒个去
//    链接：https://www.jianshu.com/p/ca855a90fff9
//    来源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    [self calculatePoint:touchPoint];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    [self calculatePoint:touchPoint];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    [self calculatePoint:touchPoint];
}

-(CGFloat )distancePoint:(CGPoint )point1 toP2:(CGPoint )point2{
    return sqrt(pow(point2.x -  point1.x, 2) + pow(point2.y - point1.y, 2));
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"hitTest<<<<%f,%f",point.x,point.y);
    NSLog(@"%@--%@",event,NSStringFromClass(self.class));
    
    CGPoint center = CGPointMake( self.frame.size.width/2.0,  self.frame.size.height/2.0);
    
    CGFloat distance = [self distancePoint:point toP2:center];
    
    NSLog(@"D++= %f,,R= %f",distance,self.frame.size.width/2.0);
    
    
    if (distance<=self.frame.size.width/2.0) {
        bJump = !bJump;
        if (bJump) {
            return nil;
        }
       
        return [super hitTest:point withEvent:event];
    }else{
#if DEBUG
        bJump = !bJump;
        if (bJump) {
            NSLog(@"nilllll");
            return nil;
        }
        if (self.touchBLock) {
            self.touchBLock();
        }
        NSLog(@"selfselflselflself");
        return nil;
#endif
        
        return nil;// [super hitTest:point withEvent:event];
    }
    
    
    if (CGRectContainsPoint(self.frame, point)) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}
-(void)calculatePoint:(CGPoint )touchPoint{
    NSLog(@"begin::<<%f,%f>>",touchPoint.x,touchPoint.y);
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(rect, touchPoint)) {
        NSLog(@"inside:这是ColorPickView被触摸了。");
    }else{
        NSLog(@"outside");
    }
}

@end
