//
//  LeftMenueView.h
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftMenueView;
@protocol LeftMenueViewDelegate <NSObject>

- (void)LeftMenue:(LeftMenueView *)LeftMenue didSelectedWithFormIndex:(NSInteger )formIndex toIndex:(NSInteger)toIndex;

@end

@interface LeftMenueView : UIView


@property(nonatomic, weak) id <LeftMenueViewDelegate>  delegate ;



@end
