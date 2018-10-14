//
//  TScanView.m
//  Examda
//
//  Created by liqi on 2018/1/5.
//  Copyright © 2018年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "TScanView.h"
// tool

#define kRed 27/255.0
#define kGreen 136/255.0
#define kBlue  238/255.0
static CGFloat const ANIMATION_DURATION_SCANNING = 4;

@interface TScanView ()

@property (nonatomic, strong) UIImageView *scanningLine;
@property (nonatomic, assign) CGFloat scanningLineY;
@property (nonatomic, assign) CGSize transparentArea;

@end

@implementation TScanView

- (instancetype)initWithFrame:(CGRect)frame transparentArea:(CGSize)transparentArea
{
    self = [super initWithFrame:frame];
    if (self) {
        self.transparentArea = transparentArea;
        [self setupScanningLine];
        [self setupScanningAlertView];
        [self startAnimation];
    }
    return self;
}

#pragma mark - ScanningLine

- (void)setupScanningLine
{
    CGSize screenSize = self.bounds.size;
    CGFloat x = screenSize.width / 2 - self.transparentArea.width / 2;
    CGFloat y = screenSize.height / 2 - self.transparentArea.height / 2;
    CGFloat width = self.transparentArea.width;
    CGFloat height = 2;
    self.scanningLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sys_sm"]];
    self.scanningLine.contentMode = UIViewContentModeScaleAspectFill;
    [self setupScanningLineFrameWhenStart];
    [self addSubview:self.scanningLine];
}

- (void)setupScanningLineFrameWhenStart
{
    CGSize screenSize = self.bounds.size;
    CGFloat x = screenSize.width / 2 - self.transparentArea.width / 2;
    CGFloat y = screenSize.height / 2 - self.transparentArea.height / 2;
    CGFloat width = self.transparentArea.width;
    CGFloat height = 2;
    self.scanningLine.frame = CGRectMake(x, y, width, height);
}

- (void)setupScanningLineFrameWhenEnd
{
    CGSize screenSize = self.bounds.size;
    CGFloat x = screenSize.width / 2 - self.transparentArea.width / 2;
    CGFloat y = screenSize.height / 2 + self.transparentArea.height / 2 - 2;
    CGFloat width = self.transparentArea.width;
    CGFloat height = 2;
    self.scanningLine.frame = CGRectMake(x, y, width, height);
}

- (void)startAnimation
{
    [UIView animateWithDuration:ANIMATION_DURATION_SCANNING animations:^{
        [self setupScanningLineFrameWhenEnd];
    } completion:^(BOOL finished) {
        [self setupScanningLineFrameWhenStart];
        [self startAnimation];
    }];
}

#pragma mark - Scanning AlertView

- (void)setupScanningAlertView
{
    CGSize screenSize = self.bounds.size;
    CGFloat width = self.transparentArea.width + 10;
    CGFloat height = 28;
    CGFloat x = screenSize.width / 2 - width / 2;
    CGFloat y =  screenSize.height / 2 + self.transparentArea.height / 2 + 10;
    CGRect rect = CGRectMake(x, y, width, height);
    UIImageView *tipBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sys_bg"]];
    tipBg.frame = rect;
    [self addSubview:tipBg];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tipBg.frame.size.width-10, tipBg.frame.size.height)];
    tipLabel.text = @"将二维码放入取景框中即可自动扫描";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor whiteColor];
    [tipBg addSubview:tipLabel];
}

#pragma mark - Draw Rect

- (void)drawRect:(CGRect)rect
{
    CGContextRef ct = UIGraphicsGetCurrentContext();
    [self drawBgLayer:ct];
    [self drawClearLayer:ct];
}

- (void)drawBgLayer:(CGContextRef)ct
{
    CGSize screenSize = self.bounds.size;
    CGRect drawBgRect =CGRectMake(0, 0, screenSize.width,screenSize.height);
    CGContextSetRGBFillColor(ct, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ct, drawBgRect);
}

- (void)drawClearLayer:(CGContextRef)ct
{
    CGSize screenSize = self.bounds.size;
    CGFloat x = screenSize.width / 2 - self.transparentArea.width / 2;
    CGFloat y = screenSize.height / 2 - self.transparentArea.height / 2;
    CGFloat width = self.transparentArea.width;
    CGFloat height = self.transparentArea.height;
    CGRect drawClearRect = CGRectMake(x, y, width, height);
    CGContextClearRect(ct, drawClearRect);
    
    [self drawStokeRectInClearLayer:ct rect:drawClearRect];
    [self drawStokeCornerInClearLayer:ct rect:drawClearRect];
}

- (void)drawStokeRectInClearLayer:(CGContextRef)ctx rect:(CGRect)rect
{
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)drawStokeCornerInClearLayer:(CGContextRef)ctx rect:(CGRect)rect
{
    //画四个边角
    CGContextSetLineWidth(ctx, 3);
    CGContextSetRGBStrokeColor(ctx, kRed, kGreen, kBlue, 1);//红色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.8, rect.origin.y),
        CGPointMake(rect.origin.x+0.8 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.8),CGPointMake(rect.origin.x + 15, rect.origin.y+0.8)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.8, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.8,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.8) ,CGPointMake(rect.origin.x+0.8 +15, rect.origin.y + rect.size.height - 0.8)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.8),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.8 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.8, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.8,rect.origin.y + 15 +0.8 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.8 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.8 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.8),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.8 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx
{
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}

@end
