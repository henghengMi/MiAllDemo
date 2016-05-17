//
//  MiYYTextAttributesController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/27.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiYYTextAttributesController.h"
#import "YYKit.h"
#import "YYTextExampleHelper.h"

@interface MiYYTextAttributesController ()

@end

@implementation MiYYTextAttributesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [YYTextExampleHelper addDebugOptionToViewController:self];
    __weak typeof (self)weakSelf =  self;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Shadow"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor whiteColor];
        YYTextShadow *shadow = [[YYTextShadow alloc] init];
        shadow.color = MiColorRGBA(0, 0, 0, 0.5);
        shadow.offset = CGSizeMake(0, 2);
        shadow.radius = 5;
        one.textShadow = shadow;
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Inner Shadow"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color= [UIColor whiteColor];
        YYTextShadow *shadow = [[YYTextShadow alloc] init];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.40];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 1;
        one.textInnerShadow = shadow;
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];

    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Multiple Shadows"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow.offset = CGSizeMake(0, -1);
        shadow.radius = 1.5;
        YYTextShadow *subShadow = [YYTextShadow new];
        subShadow.color = [UIColor colorWithWhite:1 alpha:0.99];
        subShadow.offset = CGSizeMake(0, 1);
        subShadow.radius = 1.5;
        shadow.subShadow = subShadow;
        one.textShadow = shadow;
        
        YYTextShadow *innerShadow = [YYTextShadow new];
        innerShadow.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow.offset = CGSizeMake(0, 1);
        innerShadow.radius = 1;
        one.textInnerShadow = innerShadow;
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Background Image"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor colorWithRed:1.0 green:0.8 blue:0.014 alpha:1.0f];
        
        // 背景图片。
        CGSize size = CGSizeMake(20, 20);
        UIImage *background = [UIImage imageWithSize:size drawBlock:^(CGContextRef   context) {
            UIColor *c0 = [UIColor colorWithRed:0.054 green:0.879 blue:0.000 alpha:1.000];
            UIColor *c1 = [UIColor colorWithRed:0.869 green:1.000 blue:0.030 alpha:1.000];
            [c0 setFill];
            CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
            [c1 setStroke];
            CGContextSetLineWidth(context, 2);
            for (int i = 0; i < size.width * 2 ; i += 4) {
                CGContextMoveToPoint(context, i, -2);
                CGContextAddLineToPoint(context, i - size.height, size.height + 2);
            }
            CGContextStrokePath(context);
        }];
        one.color = [UIColor colorWithPatternImage:background];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Border"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        
        YYTextBorder *border = [[YYTextBorder alloc] init];
        border.strokeColor = [UIColor colorWithRed:0.564 green:0.029 blue:0.651 alpha:1.000];
        border.strokeWidth = 4;
        border.lineStyle = YYTextLineStylePatternCircleDot;
        border.cornerRadius = 4;
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
        one.textBackgroundBorder = border;
        
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.underlineStyle = NSUnderlineStyleSingle;
        // 1. you can set a highlight with these code
 /*
        one.color = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];
        
        YYTextBorder *border = [[YYTextBorder alloc] init];
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
        border.fillColor = MiColorRGBA(0, 0, 0, 0.2);
        
        YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
        [highlight setBorder:border];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [weakSelf showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [one setTextHighlight:highlight range:one.rangeOfAll];

        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
  */
        /// 2. or you can use the convenience method
        [one setTextHighlightRange:one.rangeOfAll color:MiRandomColor backgroundColor:MiRandomColor userInfo:nil tapAction:^(UIView *  containerView, NSAttributedString *  text, NSRange range, CGRect rect) {
            
            [weakSelf showMessage:[NSString stringWithFormat:@"Tap: %@", [text.string substringWithRange:range]]];

        } longPressAction:^(UIView *  containerView, NSAttributedString *  text, NSRange range, CGRect rect) {
            [weakSelf showMessage:[NSString stringWithFormat:@"LongPress: %@", [text.string substringWithRange:range]]];

        }];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
  
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor redColor];
        
        YYTextBorder *border = [[YYTextBorder alloc] init];
        border.cornerRadius = 50;
        border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        border.strokeWidth = 0.5;
        border.strokeColor = one.color;
        border.lineStyle = YYTextLineStyleSingle;
        one.textBackgroundBorder = border;
        
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = one.color;
        highlightBorder.fillColor = one.color;
        
        YYTextHighlight *highLight = [[YYTextHighlight alloc] init];
        [highLight setColor:[UIColor whiteColor]];
        [highLight setBackgroundBorder:highlightBorder];
        highLight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [weakSelf showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [one setTextHighlight:highLight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
        
        
    }
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor whiteColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        
        YYTextShadow *shadow0 = [YYTextShadow new];
        shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow0.offset = CGSizeMake(0, -1);
        shadow0.radius = 1.5;
        YYTextShadow *shadow1 = [YYTextShadow new];
        shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
        shadow1.offset = CGSizeMake(0, 1);
        shadow1.radius = 1.5;
        shadow0.subShadow = shadow1;
        
        YYTextShadow *innerShadow0 = [YYTextShadow new];
        innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow0.offset = CGSizeMake(0, 1);
        innerShadow0.radius = 1;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        [highlight setShadow:shadow0];
        [highlight setInnerShadow:innerShadow0];
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
    }
    
    
    // YYLabel
    YYLabel *label = [[YYLabel alloc] init];
    label.attributedText = text;
    label.width = self.view.width;
    label.height = self.view.height - 64;
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
    [self.view addSubview:label];
//    label.backgroundColor = [UIColor redColor];
    /*
     If the 'highlight.tapAction' is not nil, the label will invoke 'highlight.tapAction'
     and ignore 'label.highlightTapAction'.
     
     If the 'highlight.tapAction' is nil, you can use 'highlightTapAction' to handle
     all tap action in this label.
     */
    label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        [weakSelf showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
    };
    
}

- (NSAttributedString *)padding
{
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}

- (void)showMessage:(NSString *)msg
{
    CGFloat padding = 10;
    
    YYLabel *label = [[YYLabel alloc] init];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = MiRandomColor;
    label.width = self.view.width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2 *padding;
    
    label.bottom = 0;
    [self.view addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.top = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            label.bottom = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    
    
}

@end
