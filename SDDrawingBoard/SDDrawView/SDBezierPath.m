//
//  SDBezierPath.m
//  SocketClinetDemo
//
//  Created by bnqc on 2018/6/11.
//  Copyright © 2018年 骚栋. All rights reserved.
//

#import "SDBezierPath.h"

@interface SDBezierPath(){
    
    double KEY_POINT_LEN1;
    double KEY_POINT_LEN2;
    double KEY_POINT_LEN3;
    double KEY_POINT_ANGLE1;
    double KEY_POINT_ANGLE2;
    double KEY_POINT_ANGLE3;
    double KEY_POINT_RATIO1;
    double KEY_POINT_RATIO2;
    double KEY_POINT_RATIO3;

    float startX;
    float startY;
    float endX;
    float endY;
}


@end

@implementation SDBezierPath


- (void)setDrawStyle:(DrawStyle)drawStyle{
    
    _drawStyle = drawStyle;
    if (_drawStyle == DrawStyleArrow) {
        
        //初始化箭头的相关固定值
        KEY_POINT_LEN1 = 70;
        KEY_POINT_LEN2 = 55;
        KEY_POINT_LEN3 = 8;
        KEY_POINT_ANGLE1 = 30 * M_PI/ 180;
        KEY_POINT_ANGLE2 = 18 * M_PI/ 180;
        KEY_POINT_ANGLE3 = 90 * M_PI/ 180;
        KEY_POINT_RATIO1 = 0.2;
        KEY_POINT_RATIO2 = 0.157;
        KEY_POINT_RATIO3 = 0.023;
    }
}

- (void)setStartPoint:(CGPoint)startPoint{
    
    _startPoint = startPoint;
    startX = _startPoint.x;
    startY = _startPoint.y;
}

- (void)setEndPoint:(CGPoint)endPoint{
    _endPoint = endPoint;
    endX = endPoint.x;
    endY = endPoint.y;
    
    if (_drawStyle == DrawStyleArrow) {
        [self removeAllPoints];//移除所有的路径点
        //配置箭头的6个点位
        double len1 = KEY_POINT_LEN1;
        double len2 = KEY_POINT_LEN2;
        double len3 = KEY_POINT_LEN3;
    
        double len = sqrt(pow((endX - startX), 2) + pow((endY - startY), 2));
        if (len * KEY_POINT_RATIO1 < KEY_POINT_LEN1) {
            len1 = len * KEY_POINT_RATIO1;
        }
        if (len * KEY_POINT_RATIO2 < KEY_POINT_LEN2) {
            len2 = len * KEY_POINT_RATIO2;
        }
        if (len * KEY_POINT_RATIO3 < KEY_POINT_LEN3) {
            len3 = len * KEY_POINT_RATIO3;
        }
        CGPoint arrXY_11 = [self rotateVecWithPx:endX - startX py:endY - startY ang:KEY_POINT_ANGLE1 newLen:len1];
        CGPoint arrXY_12 = [self rotateVecWithPx:endX - startX py:endY - startY ang:-KEY_POINT_ANGLE1 newLen:len1];
        CGPoint arrXY_21 = [self rotateVecWithPx:endX - startX py:endY - startY ang:KEY_POINT_ANGLE2 newLen:len2];
        CGPoint arrXY_22 = [self rotateVecWithPx:endX - startX py:endY - startY ang:-KEY_POINT_ANGLE2 newLen:len2];
        CGPoint arrXY_31 = [self rotateVecWithPx:startX - endX py:startY - endY ang:KEY_POINT_ANGLE3 newLen:len3];
        CGPoint arrXY_32 = [self rotateVecWithPx:startX - endX py:startY - endY ang:-KEY_POINT_ANGLE3 newLen:len3];;
        
        float x11 = endX - arrXY_11.x;
        float y11 = endY - arrXY_11.y;
        float x12 = endX - arrXY_12.x;
        float y12 = endY - arrXY_12.y;
        float x21 = endX - arrXY_21.x;
        float y21 = endY - arrXY_21.y;
        float x22 = endX - arrXY_22.x;
        float y22 = endY - arrXY_22.y;
        float x31 = startX - arrXY_31.x;
        float y31 = startY - arrXY_31.y;
        float x32 = startX - arrXY_32.x;
        float y32 = startY - arrXY_32.y;
        [self moveToPoint:endPoint];
        [self addLineToPoint:CGPointMake(x11, y11)];
        [self addLineToPoint:CGPointMake(x21, y21)];
        [self addLineToPoint:CGPointMake(x32, y32)];
        [self addLineToPoint:CGPointMake(x31, y31)];
        [self addLineToPoint:CGPointMake(x22, y22)];
        [self addLineToPoint:CGPointMake(x12, y12)];

    }
}


/**
 * 极坐标变换
 */

- (CGPoint)rotateVecWithPx:(float)px py:(float)py ang:(double)ang newLen:(double)newLen{
    
    double vx = px * cos(ang) - py * sin(ang);
    double vy = px * sin(ang) + py * cos(ang);
    double d = sqrt(vx * vx + vy * vy);
    vx = vx / d * newLen;
    vy = vy / d * newLen;
    return CGPointMake((float) vx, (float) vy);
}

@end
