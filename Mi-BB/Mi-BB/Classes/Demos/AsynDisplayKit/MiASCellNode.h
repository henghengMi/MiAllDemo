//
//  MiASCellNode.h
//  AsyncDisplayKit-Test01
//
//  Created by YuanMiaoHeng on 16/5/6.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface MiASCellNode : ASCellNode
@property(nonatomic, weak) ASTextNode * textNode ;
@property(nonatomic, weak) ASImageNode * imgeNode ;

- (void)startAnimating;


@end
