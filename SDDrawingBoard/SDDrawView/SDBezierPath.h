//
//  SDBezierPath.h
//  SocketClinetDemo
//
//  Created by bnqc on 2018/6/11.
//  Copyright © 2018年 骚栋. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    DrawStyleLine,
    DrawStyleSquare,
    DrawStyleCircle,
    DrawStyleArrow
} DrawStyle;

@interface SDBezierPath : UIBezierPath

@property(nonatomic,strong) UIColor *lineColor;//绘制颜色
@property(nonatomic,assign) DrawStyle drawStyle;//绘制样式

@property(nonatomic,assign) CGPoint startPoint;//当是矩形或者是圆的时候,需要使用到这个属性
@property(nonatomic,assign) CGPoint endPoint;//当是矩形或者是圆的时候,需要使用到这个属性

@end
