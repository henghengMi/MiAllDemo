//
//  MiAsynDisplayKitDemoController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/5/6.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiAsynDisplayKitDemoController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
//#import "TableViewCell.h"
#import "YYKit.h"
#import "YYFPSLabel.h"
#import "MiASCellNode.h"
@interface MiAsynDisplayKitDemoController ()<ASTableViewDataSource,ASTableViewDelegate>
@property(nonatomic, strong) NSMutableArray *titles ;
@property(nonatomic, strong) NSMutableArray *imageNames ;
@property(nonatomic, strong) ASTableView *tableViewAS;
@end


static CGFloat const dataCount = 87 + 12;

@implementation MiAsynDisplayKitDemoController

- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addFPSLabel];
    [self initAtribute];
    [self initImages];
    [self initTableViewNode];
    
}
- (void)initTableViewNode
{
    ASTableView *tableViewAS = [[ASTableView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) ) style:UITableViewStylePlain];
    [self.view addSubview:tableViewAS];
    tableViewAS.asyncDelegate = self;
    tableViewAS.asyncDataSource = self;
    self.tableViewAS = tableViewAS;
}

- (void)initImages
{
    for (int i = 0, k = 1; i < dataCount; i++){
        
        if (i <= 11) {
            [self.imageNames addObject:[NSString stringWithFormat:@"dzs%d",i]];
        }else
        {
            [self.imageNames addObject:[NSString stringWithFormat:@"%d",k]];
            k++;
        }
    }
}

- (void)addFPSLabel
{
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] init ] ;
    fpsLabel.centerY = 30;
    fpsLabel.left = 5;
    self.navigationItem.titleView = fpsLabel;
}

- (void)initAtribute
{
    for (int i = 0 ; i < dataCount; i++) {
        
        NSString *str = (i % 2 == 0) ?  [NSString stringWithFormat:@"%d Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺",i] :  [NSString stringWithFormat:@"%d Async Display Test (∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",i];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        
        text.font = [UIFont systemFontOfSize:10];
        text.lineSpacing = 0;
        text.strokeWidth = @(-3);
        text.strokeColor = [UIColor redColor];
        text.lineHeightMultiple = 1;
        text.maximumLineHeight = 12;
        text.minimumLineHeight = 12;
        
        //        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, 25)];
        //        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        //        [self.titles addObject:layout];
        [self.titles addObject:text];
    }
}

#pragma mark tableView dataSource & dalegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"nodeForRowAtIndexPath");
    
    return self.titles.count;
}

#pragma mark AStableViewDataSource
- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MiASCellNode *cellNode = [[MiASCellNode alloc] init];
    
    [cellNode startAnimating];
    
    cellNode.textNode.view.tag = indexPath.row ;
    cellNode.imgeNode.view.tag = indexPath.row + 100;
    cellNode.textNode.attributedString = self.titles[indexPath.row];
    cellNode.imgeNode.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    
    
    return cellNode;
}


- (void)tableView:(ASTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPathRow%ld",indexPath.row);
    MiASCellNode * nodeCell =  (MiASCellNode *)[tableView nodeForRowAtIndexPath:indexPath];
    [nodeCell startAnimating];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(ASTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.row];
    [self.titles removeObjectAtIndex:indexPath.row];
    [tableView deleteRowAtIndexPath:indexPath withRowAnimation:(UITableViewRowAnimationMiddle)];
}

#pragma mark AStableViewDelegate
- (void)tableView:(ASTableView *)tableView willDisplayNodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MiASCellNode * nodeCell =  (MiASCellNode *)[tableView nodeForRowAtIndexPath:indexPath];
    [nodeCell startAnimating];
}

@end
