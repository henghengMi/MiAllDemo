//
//  MiYYTextHomeViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/26.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiYYTextHomeViewController.h"
#import "MiYYTextAttributesController.h"
#import "MiYYTextTagController.h"
#import "MiYYTextAttachmentController.h"
#import "MiYYTextEditController.h"
#import "MiYYTextMarkdownController.h"
#import "YYTextEmoticonExample.h"
#import "YYTextBindingExample.h"
#import "YYTextCopyPasteExample.h"
#import "YYTextUndoRedoExample.h"
#import "YYTextRubyExample.h"
#import "YYTextAsyncExample.h"



@interface MiYYTextHomeViewController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *vcs;
@end

@implementation MiYYTextHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"YYTextDemo";
    self.titles = @[@"TextAttribute",@"TextTag",@"TextAttachment",@"TextEdit",@"Text Parser Markdown",@"Text Parser Emotion",@"Binding",@"Copy and Paste",@"UndoRedo",@"Ruby",@"Async"];
    self.vcs = @[
                 [MiYYTextAttributesController class],
                 [MiYYTextTagController class],
                 [MiYYTextAttachmentController class],
                 [MiYYTextEditController class],
                 [MiYYTextMarkdownController class],
                 [YYTextEmoticonExample class],
                 [YYTextBindingExample class],
                 [YYTextCopyPasteExample class],
                 [YYTextUndoRedoExample class],
                 [YYTextRubyExample class],
                 [YYTextAsyncExample class]
                 ];
}

#pragma mark tableView dataSource & dalegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Class vc = self.vcs[indexPath.row];
    if (vc) {
        UIViewController *viewController = [[vc alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        viewController.title = self.titles[indexPath.row];
    }
}


@end
