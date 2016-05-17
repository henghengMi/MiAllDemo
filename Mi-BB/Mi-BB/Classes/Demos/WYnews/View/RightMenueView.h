//
//  RightMenueView.h
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef void (^GobackBtnClick)();

typedef void (^GomainBtnClick)();

@interface RightMenueView : UIView

@property(nonatomic, copy) GobackBtnClick gobackBlock;
@property(nonatomic, copy) GomainBtnClick gomainBlock;


@end
