# SDDrawView
SDDrawView is iOS DrawingBoard ,SDDrawView have a good arrow's draw way!!! welcome download SDDrawView

SDDrawView 是 iOS的一个画板工具组件,简单上手~ 包含了线条、矩形、圆形、箭头.颜色设置,线条宽度设置,这里说一下SDDrawView最大的特点就是箭头 不再是以往的那种一个三角形加上一个矩形的样式 而是类似于QQ截图中的矩形,更加的圆滑,欢迎下载尝试!

<br>

#### SDDrawView简介
***
SDDrawView 是一款基于贝塞尔曲线的画板组件,目前样式包含线条、矩形、圆形、箭头等样式.具有调整画板颜色,线条宽度,线条颜色等基本功能.后期准备接入图片涂改,橡皮擦功能,添加文字等功能.至于为什么要做SDDrawView这样的一个三方画板组件,其实SDDrawView大部分功能和现在网上的画板组件都是类似的,是一个不折不扣的造轮子组件.其实,在网上找了很多的画板组件三方中**箭头**样式令人不是太满意显得非常的生硬,大部分是一个矩形加一个三角形组成的多边形箭头.SDDrawView的箭头样式却不同,SDDrawView箭头样式更类似于QQ截图中的箭头,更加的圆滑更加趋近于现实.接下来,看一下SDDrawView的效果演示图.

![](https://upload-images.jianshu.io/upload_images/1396375-3b48f2d68c5a9301.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<br>

#### SDDrawView快速集成
***
如何快速集成SDDrawView?非常简单,只需要把[SDDrawViewDemo](https://github.com/wang82426107/SDDrawView)下载下来,然后把Demo中的**SDDrawView**文件夹拖到你的工程中,然后如下导入头文件即可.
```
#import "SDDrawView.h"
```
SDDrawView初始化也比较简单.我们初始化一个SDDrawView对象然后添加到对应的View视图上即可.
```
//懒加载的形式初始化(可用可不用~)
- (SDDrawView *)drawView{
    
    if(_drawView == nil){
        _drawView = [[SDDrawView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _drawView.drawViewColor = [UIColor whiteColor];//画板颜色
        _drawView.lineWidth = 2.0f;//线条宽度
        _drawView.drawStyle = DrawStyleLine;//样式
        _drawView.lineColor = [UIColor redColor];//线条颜色
    }
    return _drawView;
    
}
```
图形样式选择是一个枚举值,只需设定对应的样式,就可绘制不同的图形.
```
typedef enum : NSUInteger {
    DrawStyleLine,
    DrawStyleSquare,
    DrawStyleCircle,
    DrawStyleArrow
} DrawStyle;
```

这里说明一下**SDDrawView**所有的属性和方法.

|属性或者方法|说明|
|:---:|:---:|
|drawViewColor|画板颜色|
|lineWidth|画笔宽度|
|drawStyle|绘制样式 值为DrawStyle的枚举值|
|lineColor|画笔颜色|
|- (void)cleanAction;|清除画板|
|- (void)rollbackAction;|回退上一步|


<br>


#### [实现过程博客地址传送门](https://www.jianshu.com/p/b778008c61c8)
