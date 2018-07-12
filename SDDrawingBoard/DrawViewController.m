//
//  DrawViewController.m
//  SDDrawingBoard
//
//  Created by bnqc on 2018/7/12.
//  Copyright © 2018年 Dong. All rights reserved.
//

#import "DrawViewController.h"
#import "UIImage+Color.h"
#import "SDDrawView.h"
#define KcurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define KmainHeight  [UIScreen mainScreen].bounds.size.height
#define KmainWidth  [UIScreen mainScreen].bounds.size.width
#define StatusHeight  ([[UIApplication sharedApplication]statusBarFrame].size.height)
#define NavigationBarHeight  (44.0f)

@interface DrawViewController ()

@property(nonatomic,strong)SDDrawView *drawView;
@property(nonatomic,strong)UIButton *lineButton;
@property(nonatomic,strong)UIButton *squareButton;
@property(nonatomic,strong)UIButton *circleButton;
@property(nonatomic,strong)UIButton *arrowButton;
@property(nonatomic,strong)UISlider *lineWidthSlider;//调整线条滑块
@property(nonatomic,strong)UILabel *lineWidthLabel;//调整线条宽度的Label
@property(nonatomic,strong)UIButton *redButton;
@property(nonatomic,strong)UIButton *greenButton;
@property(nonatomic,strong)UIButton *orangeButton;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadNavigationBarAction];
    [self.view addSubview:self.lineButton];
    [self.view addSubview:self.squareButton];
    [self.view addSubview:self.circleButton];
    [self.view addSubview:self.arrowButton];
    [self.view addSubview:self.drawView];
    [self.view addSubview:self.lineWidthSlider];
    [self.view addSubview:self.lineWidthLabel];
    [self.view addSubview:self.redButton];
    [self.view addSubview:self.greenButton];
    [self.view addSubview:self.orangeButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewSafeAreaInsetsDidChange{
    
    [super viewSafeAreaInsetsDidChange];
    if ([KcurrentSystemVersion intValue] > 11.0) {
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(44, 0, 0, 10);
    }
    
}

- (void)loadNavigationBarAction{
    
    self.navigationItem.title = @"画板功能";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空画板" style:UIBarButtonItemStyleDone target:self action:@selector(clearDrawViewAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回退上一步" style:UIBarButtonItemStyleDone target:self action:@selector(rollbackDrawViewAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
}

- (void)clearDrawViewAction{
    
    [_drawView cleanAction];
    
}

- (void)rollbackDrawViewAction{
    
    [_drawView rollbackAction];
    
}

#pragma mark - 懒加载(这种情况没毛用,习惯而已)
- (UIButton *)lineButton{
    
    if(_lineButton == nil){
        _lineButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusHeight + NavigationBarHeight, KmainWidth/4.0, 40)];
        _lineButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        _lineButton.selected = YES;
        [_lineButton setTitle:@" 直线" forState:UIControlStateNormal];
        [_lineButton setImage:[UIImage imageNamed:@"曲线"] forState:UIControlStateNormal];
        [_lineButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_lineButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_lineButton addTarget:self action:@selector(selectLineDrawType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lineButton;
}

- (UIButton *)squareButton{
    
    if(_squareButton == nil){
        _squareButton = [[UIButton alloc] initWithFrame:CGRectMake(KmainWidth/4.0, StatusHeight + NavigationBarHeight, KmainWidth/4.0, 40)];
        _squareButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [_squareButton setTitle:@" 矩形" forState:UIControlStateNormal];
        [_squareButton setImage:[UIImage imageNamed:@"矩形"] forState:UIControlStateNormal];
        [_squareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_squareButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_squareButton addTarget:self action:@selector(selectLineDrawType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _squareButton;
}


- (UIButton *)circleButton{
    
    if(_circleButton == nil){
        _circleButton = [[UIButton alloc] initWithFrame:CGRectMake(KmainWidth/2.0, StatusHeight + NavigationBarHeight, KmainWidth/4.0, 40)];
        _circleButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [_circleButton setTitle:@" 圆形" forState:UIControlStateNormal];
        [_circleButton setImage:[UIImage imageNamed:@"圆形"] forState:UIControlStateNormal];
        [_circleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_circleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_circleButton addTarget:self action:@selector(selectLineDrawType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleButton;
}


- (UIButton *)arrowButton{
    
    if(_arrowButton == nil){
        _arrowButton = [[UIButton alloc] initWithFrame:CGRectMake(KmainWidth/4.0*3, StatusHeight + NavigationBarHeight, KmainWidth/4.0, 40)];
        _arrowButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [_arrowButton setTitle:@" 箭头" forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_arrowButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_arrowButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_arrowButton addTarget:self action:@selector(selectLineDrawType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowButton;
}


- (SDDrawView *)drawView{
    
    if(_drawView == nil){
        
        _drawView = [[SDDrawView alloc] initWithFrame:CGRectMake(0, StatusHeight + NavigationBarHeight + 40, KmainWidth, KmainHeight - StatusHeight - NavigationBarHeight - 40 - 40 - 60)];
        _drawView.drawViewColor = [UIColor whiteColor];
        _drawView.lineWidth = 2.0f;
        _drawView.drawStyle = DrawStyleLine;
        _drawView.lineColor = [UIColor redColor];
        _drawView.layer.borderWidth = 1.0f;
        _drawView.layer.borderColor = [self hexStringToColor:@"c0c0c0"].CGColor;
    }
    return _drawView;
    
}

- (UISlider *)lineWidthSlider{
    
    
    if(_lineWidthSlider == nil){
        _lineWidthSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_drawView.frame), KmainWidth - 40 - 60, 40)];
        [_lineWidthSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
        [_lineWidthSlider addTarget:self action:@selector(lineWidthAction:) forControlEvents:UIControlEventValueChanged];
        _lineWidthSlider.minimumTrackTintColor = [self hexStringToColor:@"facc60"];
        _lineWidthSlider.minimumValue = 2;
        _lineWidthSlider.maximumValue = 8;
    }
    return _lineWidthSlider;
    
}

- (UILabel *)lineWidthLabel{
    
    if(_lineWidthLabel == nil){
        _lineWidthLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lineWidthSlider.frame) + 5, CGRectGetMaxY(_drawView.frame), 55, 40)];
        _lineWidthLabel.font = [UIFont systemFontOfSize:12];
        _lineWidthLabel.text = @"宽度:2.0";
        _lineWidthLabel.textColor = [UIColor blackColor];
    }
    return _lineWidthLabel;
    
}

- (UIButton *)redButton{
    
    if(_redButton == nil){
        _redButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_lineWidthLabel.frame) + 15, KmainWidth/3.0 - 40, 30)];
        _redButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _redButton.backgroundColor = [UIColor redColor];
        _redButton.layer.cornerRadius = 4.0f;
        _redButton.layer.masksToBounds = YES;
        [_redButton setTitle:@"" forState:UIControlStateNormal];
        [_redButton setTitle:@"✔️" forState:UIControlStateSelected];
        [_redButton addTarget:self action:@selector(selectDrawViewColorAction:) forControlEvents:UIControlEventTouchUpInside];
        _redButton.selected = YES;
    }
    return _redButton;
    
}

- (UIButton *)greenButton{
    
    if(_greenButton == nil){
        _greenButton = [[UIButton alloc] initWithFrame:CGRectMake(20 + KmainWidth/3.0 , CGRectGetMaxY(_lineWidthLabel.frame) + 15, KmainWidth/3.0 - 40, 30)];
        _greenButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _greenButton.backgroundColor = [UIColor greenColor];
        _greenButton.layer.cornerRadius = 4.0f;
        _greenButton.layer.masksToBounds = YES;
        [_greenButton setTitle:@"" forState:UIControlStateNormal];
        [_greenButton setTitle:@"✔️" forState:UIControlStateSelected];
        [_greenButton addTarget:self action:@selector(selectDrawViewColorAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _greenButton;
    
}

- (UIButton *)orangeButton{
    
    if(_orangeButton == nil){
        _orangeButton = [[UIButton alloc] initWithFrame:CGRectMake(20 + KmainWidth/3.0*2 , CGRectGetMaxY(_lineWidthLabel.frame) + 15, KmainWidth/3.0 - 40, 30)];
        _orangeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _orangeButton.backgroundColor = [UIColor orangeColor];
        _orangeButton.layer.cornerRadius = 4.0f;
        _orangeButton.layer.masksToBounds = YES;
        [_orangeButton setTitle:@"" forState:UIControlStateNormal];
        [_orangeButton setTitle:@"✔️" forState:UIControlStateSelected];
        [_orangeButton addTarget:self action:@selector(selectDrawViewColorAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orangeButton;
    
}

#pragma mark - 选择绘制样式(方式很low)
- (void)selectLineDrawType:(UIButton *)sender{
    
    _lineButton.selected = NO;
    _squareButton.selected = NO;
    _circleButton.selected = NO;
    _arrowButton.selected = NO;
    sender.selected = YES;
    
    if([sender isEqual: _lineButton]){
        _drawView.drawStyle = DrawStyleLine;
    }else if([sender isEqual: _squareButton]){
        _drawView.drawStyle = DrawStyleSquare;
    }else if([sender isEqual: _circleButton]){
        _drawView.drawStyle = DrawStyleCircle;
    }else{
        _drawView.drawStyle = DrawStyleArrow;
    }
    
}

#pragma mark - 修改绘制线条的宽度

//设置宽度 (2.0 -8.0)
- (void)lineWidthAction:(UISlider *)sender{
    
    _drawView.lineWidth = sender.value;
    _lineWidthLabel.text = [NSString stringWithFormat:@"宽度:%.1f",sender.value];
    
}


#pragma mark - 选择绘制颜色

- (void)selectDrawViewColorAction:(UIButton *)sender{
    
    _redButton.selected = NO;
    _greenButton.selected = NO;
    _orangeButton.selected = NO;
    sender.selected = YES;
    
    if([sender isEqual: _redButton]){
        _drawView.lineColor = [UIColor redColor];
    }else if([sender isEqual: _greenButton]){
        _drawView.lineColor = [UIColor greenColor];
    }else{
        _drawView.lineColor = [UIColor orangeColor];
    }
    
}

#pragma mark - 工具类(颜色)

- (UIColor *)hexStringToColor:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert
                          stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}


@end











