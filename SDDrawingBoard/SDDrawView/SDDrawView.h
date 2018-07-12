//
//  SDDrawView.h
//  SocketClinetDemo
//
//  Created by bnqc on 2018/6/11.
//  Copyright © 2018年 骚栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDBezierPath.h"

@interface SDDrawView : UIView

//SDDrawView是图形绘制的View

/***********通用属性**************/

@property(nonatomic,strong) UIColor *drawViewColor;//画板颜色
@property(nonatomic,assign) CGFloat lineWidth;//画笔宽度
@property(nonatomic,assign) DrawStyle drawStyle;//绘制样式
@property(nonatomic,strong) UIColor *lineColor;//画笔颜色

- (void)cleanAction;//清除画板
- (void)rollbackAction;//回退上一步

@end
