//
//  RightMenueView.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "RightMenueView.h"

@implementation RightMenueView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self =  [[NSBundle mainBundle] loadNibNamed:@"RightMenueView" owner:self options:nil][0];
        
        
    }
    return self;
}


- (IBAction)gobackButtonClick:(UIButton *)btn {
    if (self.gobackBlock) {
        self.gobackBlock();
    }
}
- (IBAction)GoMain {
    if (self.gomainBlock) {
        self.gomainBlock();
    }
}

@end
