//
//  MiASCellNode.m
//  AsyncDisplayKit-Test01
//
//  Created by YuanMiaoHeng on 16/5/6.
//  Copyright © 2016年 Mi. All rights reserved.
//

#define kImageCount 5
#define kCellHeight 80
#define kImageWH 50

#import "MiASCellNode.h"

@interface MiASCellNode ()

@property(nonatomic, strong) NSMutableArray *  imagesArray;
@property(nonatomic, weak) ASDisplayNode *indicateNode;
@property(nonatomic, weak) ASDisplayNode *switchNode;

@end

@implementation MiASCellNode

- (instancetype)init
{
    if (self = [super init]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imagesArray = [NSMutableArray array];
        
        self.backgroundColor = [UIColor yellowColor];
        
//        for (int i = 0; i < kImageCount; i ++) {
//            ASImageNode *imgeNode = [[ASImageNode alloc] init];
//            [self addSubnode:imgeNode];
//            imgeNode.image = [UIImage imageNamed:@"jiao"];
//            self.imgeNode = imgeNode;
//            imgeNode.clipsToBounds = YES;
//            imgeNode.cornerRadius = kImageWH * 0.5;
//            [self.imagesArray addObject:imgeNode];
//            NSLog(@"add");
//            imgeNode.alpha = 0.5;
//            imgeNode.borderColor = [UIColor redColor].CGColor;
//            imgeNode.borderWidth = 2;
//        }
        
        ASImageNode *imgeNode = [[ASImageNode alloc] init];
        [self addSubnode:imgeNode];
//        imgeNode.image = [UIImage imageNamed:@"jiao"];
        self.imgeNode = imgeNode;
        imgeNode.clipsToBounds = YES;
        imgeNode.cornerRadius = kImageWH * 0.5;
        [self.imagesArray addObject:imgeNode];
        NSLog(@"add");
        imgeNode.alpha = 0.5;
        imgeNode.borderColor = [UIColor redColor].CGColor;
        imgeNode.borderWidth = 2;
        [imgeNode addTarget:self action:@selector(imgeClick:) forControlEvents:(ASControlNodeEventTouchUpInside)];
        imgeNode.view.tag = 10;


        ASTextNode * textCellNode = [[ASTextNode alloc] init];
        [self addSubnode:textCellNode];
        self.textNode = textCellNode;
        self.textNode.backgroundColor = [UIColor redColor];
        [textCellNode addTarget:self action:@selector(textCellNode:) forControlEvents:(ASControlNodeEventTouchUpInside)];


        ASDisplayNode *indicateNode = [[ASDisplayNode alloc] initWithViewBlock:^(UIView *view){
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
            [indicator startAnimating];
            indicator.color = [UIColor blueColor];
            return indicator;
        }];
        [self addSubnode:indicateNode];
        self.indicateNode = indicateNode;

        
        ASDisplayNode *switchNode = [[ASDisplayNode alloc] initWithViewBlock:^(UIView *view){
            UISwitch *aSwitch = [[UISwitch alloc] init];
            aSwitch.tintColor = [UIColor purpleColor];
            aSwitch.onTintColor = [UIColor orangeColor];
            return aSwitch;
        }];
        [self addSubnode:switchNode];
        self.switchNode = switchNode;
        
    }
    return self;
        
}

- (void)startAnimating
{
    if([self.indicateNode.view isKindOfClass:[UIActivityIndicatorView class]])
    {
         UIActivityIndicatorView *indicator   = ( UIActivityIndicatorView *)self.indicateNode.view;
        [indicator startAnimating];
    }
}

- (void)textCellNode:(ASTextNode *)textNode
{
    NSLog(@" textNode.view.tag : %ld", textNode.view.tag);

}

- (void)imgeClick:(ASImageNode *)imageNode
{
     NSLog(@" imageNode.view.tag : %ld", imageNode.view.tag);
}

#pragma mark 计算Cell高度、宽度
- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
//     NSLog(@"%@",NSStringFromCGSize(constrainedSize));
//     NSLog(@"calculateSizeThatFits");
    
    // 设置宽高最大值和
    [self.textNode measure:CGSizeMake(constrainedSize.width, MAXFLOAT)];
    //
    
    NSLog(@"self.textNode.calculatedSize.height:%f",self.textNode.calculatedSize.height);
    return CGSizeMake(constrainedSize.width, kImageWH + self.textNode.calculatedSize.height + 10);
}

#pragma mark 布局
- (void)layout
{
    [super layout];
    
    NSLog(@"layout");
    
//    for (int i = 0; i < self.imagesArray.count; i++) {
//        ASImageNode *imgeNode = self.imagesArray[i];
//       imgeNode.frame = CGRectMake(50 + i * (10 + kImageWH), (kCellHeight - kImageWH) * 0.5, kImageWH, kImageWH);
//    }
    self.imgeNode.frame = CGRectMake((self.bounds.size.width - kImageWH) * 0.5, 0, kImageWH, kImageWH);
    self.textNode.frame = CGRectMake(0, kImageWH  ,CGRectGetWidth(self.frame), self.textNode.calculatedSize.height);
    
    self.indicateNode.frame = CGRectMake(0, 0, 30, 30);
    self.indicateNode.view.center = CGPointMake(20, 20);
    
    self.switchNode.view.center = CGPointMake(self.view.center.x + kImageWH + 50, self.imgeNode.view.center.y);
    
    
}

@end
