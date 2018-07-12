//
//  SDDrawView.m
//  SocketClinetDemo
//
//  Created by bnqc on 2018/6/11.
//  Copyright © 2018年 骚栋. All rights reserved.
//

#import "SDDrawView.h"

@interface SDDrawView()

@property(nonatomic,strong)NSMutableArray <SDBezierPath*>*pathsArray;

@end

@implementation SDDrawView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _pathsArray = [NSMutableArray arrayWithCapacity:16];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//清除
- (void)cleanAction{
    [self.pathsArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}

//回退
- (void)rollbackAction{
    [self.pathsArray removeLastObject];
    //重绘
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 获取触摸对象
    UITouch *touch=[touches anyObject];
    // 获取手指的位置
    CGPoint point=[touch locationInView:touch.view];
    //当手指按下的时候就创建一条路径
    SDBezierPath *path=[SDBezierPath bezierPath];
    path.drawStyle = _drawStyle;
    //设置画笔宽度
    if(_lineWidth<=0){
        [path setLineWidth:5];
    }else{
        [path setLineWidth:_lineWidth];
    }
    //设置画笔颜色
    [path setLineColor:_lineColor];
    //设置起点
    switch (path.drawStyle) {
        case DrawStyleLine:
            [path moveToPoint:point];
            break;
        case DrawStyleSquare:case DrawStyleCircle:
            [path moveToPoint:point];

            path.startPoint = point;
            break;
        case DrawStyleArrow:
            path.startPoint = point;
            break;
    }
    // 把每一次新创建的路径 添加到数组当中
    [self.pathsArray addObject:path];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // 获取触摸对象
    UITouch *touch=[touches anyObject];
    // 获取手指的位置
    CGPoint point=[touch locationInView:touch.view];
    // 连线的点
    SDBezierPath *path = self.pathsArray.lastObject;
    
    switch (path.drawStyle) {
        case DrawStyleLine:
            [path addLineToPoint:point];
            break;
        case DrawStyleSquare:case DrawStyleCircle:
            path.endPoint = point;
            break;
        case DrawStyleArrow:
            path.endPoint = point;

            break;
    }
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 连线的点
    SDBezierPath *path = self.pathsArray.lastObject;
    switch (path.drawStyle) {
        case DrawStyleLine:{
            // 获取触摸对象
            UITouch *touch=[touches anyObject];
            // 获取手指的位置
            CGPoint point=[touch locationInView:touch.view];
            // 连线的点
            [[self.pathsArray lastObject] addLineToPoint:point];
            // 重绘
            [self setNeedsDisplay];
            
        }break;
        case DrawStyleSquare:case DrawStyleCircle:
            break;
        case DrawStyleArrow:
            break;
    }
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (SDBezierPath *path in self.pathsArray) {
        
        switch (path.drawStyle) {
            case DrawStyleLine: {
                //设置颜色
                [path.lineColor set];
                // 设置连接处的样式
                [path setLineJoinStyle:kCGLineJoinRound];
                // 设置头尾的样式
                [path setLineCapStyle:kCGLineCapRound];
                //渲染
                [path stroke];
                
            }break;
            case DrawStyleSquare:{
                UIBezierPath *drawPath = [UIBezierPath bezierPathWithRect:CGRectMake(path.startPoint.x, path.startPoint.y, path.endPoint.x - path.startPoint.x, path.endPoint.y - path.startPoint.y)];
                //设置宽度
                drawPath.lineWidth = path.lineWidth;
                //设置颜色
                [path.lineColor set];
                // 设置连接处的样式
                [drawPath setLineJoinStyle:kCGLineJoinRound];
                // 设置头尾的样式
                [drawPath setLineCapStyle:kCGLineCapRound];
                //渲染
                [drawPath stroke];
                
            }break;
                
            case DrawStyleCircle: {
                UIBezierPath *drawPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(path.startPoint.x, path.startPoint.y, path.endPoint.x - path.startPoint.x, path.endPoint.y - path.startPoint.y)];
                //设置宽度
                drawPath.lineWidth = path.lineWidth;
                //设置颜色
                [path.lineColor set];
                // 设置连接处的样式
                [drawPath setLineJoinStyle:kCGLineJoinRound];
                // 设置头尾的样式
                [drawPath setLineCapStyle:kCGLineCapRound];
                //渲染
                [drawPath stroke];
            }break;
            case DrawStyleArrow: {
                //设置颜色
                [path.lineColor set];
                // 设置连接处的样式
                [path setLineJoinStyle:kCGLineJoinMiter];
                // 设置头尾的样式
                [path setLineCapStyle:kCGLineCapSquare];
                
                [path fill];
            }break;
        }
    }
}


@end
