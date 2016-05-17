//
//  MiActionSheet.m
//  LJMall
//
//  Created by YuanMiaoHeng on 15/10/14.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import "MiActionSheet.h"
#import "MiActionCell.h"
#import "Header.h"

#define kDuration 0.25f
@interface MiActionSheet()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *titles;

@property(nonatomic, strong) NSMutableArray *groupArr;

@property(nonatomic, weak)  UIView *bgView;

@property(nonatomic, assign,getter=isHaveTitle)  BOOL haveTitle;


@end

@implementation MiActionSheet



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super initWithFrame:CGRectZero];
    
    CGFloat self_Heigt = 44 * otherButtonTitles.count + 5 ;
    if (title) {
        self.haveTitle = YES;
        self_Heigt = 44 * (otherButtonTitles.count + 1) + 5 ;
        [self.titles addObject:title];
    }
    
    self.frame = CGRectMake(0, ScreenHeight, ScreenWidth,self_Heigt );
    self.userInteractionEnabled = YES;
    
    
    // 把其他标题数组弄到手
    [self.titles addObjectsFromArray:otherButtonTitles];
    // 再把取消加进去
    [self.titles addObject:cancelButtonTitle];
  
 
    // 拿到 window
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    // 加一层黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [window addSubview:bgView];
        bgView.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        bgView.alpha = 0.4;
        self.frame = CGRectMake(0, ScreenHeight - (44 * self.titles.count) - 5 , ScreenWidth, 44 * self.titles.count + 5 );
    }];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick:)];
    [bgView addGestureRecognizer:tapG ];
    self.bgView = bgView;

    // 自己加进去window
    [window addSubview:self];
    
    // tableView构建
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self_W, self_H) style:UITableViewStylePlain];
    [self addSubview:tableView];
    tableView.backgroundColor = MiColor(240, 240, 240) ;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    // 如果有标题就加表头，如果没有就不加
//    if (title != nil) {
//        UIView *bgView = [[UIView alloc] init];
//
//        UILabel *tableHead = [[UILabel alloc] init];// 高度得根据字数多少判断
//        [bgView addSubview:tableHead];
//        tableHead.textAlignment = NSTextAlignmentCenter;
//        tableHead.font = [UIFont systemFontOfSize:14];
//        tableHead.text = title;
//        CGSize maxSize = [title boundingRectWithSize:CGSizeMake(ScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: tableHead.font} context:nil].size;
//        
//        tableHead.frame = CGRectMake(0, 0, ScreenWidth, maxSize.height);
//        
//        
//        tableView.tableHeaderView = tableHead;
//        tableHead.backgroundColor = MiTestColor_brown();
//        
//    }
    return self;
    
}




- (void)bgViewClick:(UITapGestureRecognizer*)tap
{
    [self dismiss];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count ;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MiActionCell * cell = [[MiActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.row == self.titles.count - 1) { // 如果是取消cell
        cell.cancelCell = YES;
    }
    if (indexPath.row == self.titles.count - 1 || indexPath.row == self.titles.count - 2 ) {
        cell.line.hidden = YES;

    }
   
   [cell.titleButton setTitle:self.titles[indexPath.row] forState:(UIControlStateNormal)];
    
    // 设置默认背景
    if (self.backgroupColorWithButton)
         cell.backgroundColor = self.backgroupColorWithButton;
    
    // 设置字体大小
    if (self.fontSize)
        cell.titleButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    // 设置字体颜色
    if (self.titleColor) {
        [cell.titleButton setTitleColor:self.titleColor forState:(UIControlStateNormal)];
    }
    
    // 如果有标题,第一行字体得设置小一点
    if (self.isHaveTitle) {
        if (indexPath.row == 0) {
            cell.titleButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [cell.titleButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)]; // 默认灰色
            if (self.topTitleColor) {
                [cell.titleButton setTitleColor:self.topTitleColor forState:(UIControlStateNormal)]; // 设置颜色
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (self.isHaveTitle  && indexPath.row == 0) return; // 点击标题没反应
      
   
    if (indexPath.row == self.titles.count -1) { // 当只有2个时，点击取消没反应
        // 点击了取消
           [self dismiss];
        return;
    }
    
    if (self.titleBtnClick) { // 有无标题和多于2个时候的处理
        if (self.isHaveTitle && self.titles.count >1 ) {
                 [self dismiss];
            self.titleBtnClick(indexPath.row - 1);
        }
        else
        {
                 [self dismiss];
            self.titleBtnClick(indexPath.row );
        }
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:kDuration animations:^{
        self.bgView.alpha = 0;
        self.transform = CGAffineTransformTranslate(self.transform, 0, ScreenHeight * 0.5);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
