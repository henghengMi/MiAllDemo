//
//  scrawlView.m
//  涂鸦-01
//
//  Created by 袁妙恒 on 15/6/7.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "scrawlView.h"

@interface scrawlView ()

@property(nonatomic,strong)NSMutableArray *totalarr;

@end

@implementation scrawlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linecolor = [UIColor blackColor];
    }
    return self;
}

- (NSMutableArray *)totalarr
{
    if (_totalarr == nil) {
        _totalarr = [NSMutableArray array];
    }
        return _totalarr;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //拿出手势
    UITouch *touch = [touches anyObject];
    CGPoint beginPoin =  [touch locationInView:touch.view];
    UIBezierPath *beginPath = [UIBezierPath bezierPath];
    [beginPath moveToPoint:beginPoin];
    beginPath.lineCapStyle = kCGLineCapRound;
    beginPath.lineJoinStyle = kCGLineJoinBevel;
    [self.totalarr addObject:beginPath];
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"%s",__func__);
    UITouch *touch = [touches anyObject];
    CGPoint movePoin =  [touch locationInView:touch.view];
    UIBezierPath *movePath = [self.totalarr lastObject];
    [movePath addLineToPoint:movePoin];
    
    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);

    [self touchesMoved:touches withEvent:event];
}


- (void)setLinecolor:(UIColor *)linecolor
{
  _linecolor = linecolor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

    [self.linecolor set];
    for (UIBezierPath  *path in self.totalarr) {
        path.lineWidth = 5;
        path.lineWidth = self.lineW;
        [path stroke];
    }
}

- (void)back
{
    [self.totalarr removeLastObject];
    [self setNeedsDisplay];
}

-(void)clear
{
    [self.totalarr removeAllObjects];
    [self setNeedsDisplay];
}

- (void)setLineW:(CGFloat)lineW
{
    _lineW = lineW;
    [self setNeedsDisplay];
}

//
//- (UIColor *)setLineColor:(UIColor *)color
//{
//    return color;
//}

@end
