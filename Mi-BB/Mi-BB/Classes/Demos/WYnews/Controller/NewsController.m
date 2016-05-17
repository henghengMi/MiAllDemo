//
//  NewsController.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "NewsController.h"
#import "TitleButton.h"
@implementation NewsController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


/**
 leftView.y = 150;
 leftView.width =  ScreenWidth - 120;
 leftView.height = ScreenHeight - leftView.y * 2;
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"row-%ld",indexPath.row];
    
    return cell;
}
@end
