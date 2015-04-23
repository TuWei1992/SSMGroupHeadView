//
//  SSMGroupHeadView.h
//  SSMGroupHeadView
//
//  Created by apple on 15-4-7.
//  Copyright (c) 2015年 ZhaoYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMGroupItem.h"

@class SSMGroupHeadView;

@protocol SSMGroupHeadViewDelegate <NSObject>
@optional
- (void)groupHeadViewGroupClicked:(SSMGroupHeadView *)groupHeadView preIndex:(int)pre atIndex:(int)index sender:(SSMGroupItem *)item;
@end

@interface SSMGroupHeadView : UIView
@property (nonatomic, weak) id<SSMGroupHeadViewDelegate> delegate;
/**
 *  当前选中项索引
 */
@property (nonatomic, assign) int selectedIndex;
/**
 *  文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;
/**
 *  选中文字颜色
 */
@property (nonatomic, strong) UIColor *selectedTextColor;
/**
 *  指示器颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;
/**
 *  插入一个组
 *
 *  @param title 组标题
 */
- (void)insertGroupWithTitle:(NSString *)title;
/**
 *  插入一个箭头指示器组
 *
 *  @param title     组标题
 *  @param direction 箭头指示器方向
 */
- (void)insertGroupWithTitle:(NSString *)title direction:(ArrowDirection)direction;
/**
 *  设置组标题
 *
 *  @param title 标题
 *  @param index 组索引
 */
- (void)setGroupTitle:(NSString *)title atIndex:(int)index;
/**
 *  重新调整布局
 */
- (void)adjustLayout;
@end
