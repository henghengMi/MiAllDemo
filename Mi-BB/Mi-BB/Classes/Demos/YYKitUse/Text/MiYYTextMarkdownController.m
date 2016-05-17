//
//  MiYYTextMarkdownController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/27.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiYYTextMarkdownController.h"
#import "YYKit.h"

@interface MiYYTextMarkdownController ()<YYTextViewDelegate>
@property (nonatomic, assign) YYTextView *textView;
@end

@implementation MiYYTextMarkdownController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    NSString *text = @"#Markdown Editor\n[a](https://baidu.com)\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n";

    YYTextSimpleMarkdownParser *parser = [[YYTextSimpleMarkdownParser alloc] init];
    [parser setColorWithDarkTheme];
    
    YYTextView *textView = [[YYTextView alloc] init];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textParser = parser;
    textView.size = self.view.size;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.backgroundColor = [UIColor colorWithWhite:0.134 alpha:1.000];
    textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.selectedRange = NSMakeRange(text.length, 0);
    [self.view addSubview:textView];
    self.textView = textView;
    
}



- (void)edit:(UIBarButtonItem *)item {
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    } else {
        [_textView becomeFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(YYTextView *)textView {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}
@end
