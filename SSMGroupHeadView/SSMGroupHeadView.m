//
//  SSMGroupHeadView.m
//  SSMGroupHeadView
//
//  Created by apple on 15-4-7.
//  Copyright (c) 2015年 ZhaoYang. All rights reserved.
//

#import "SSMGroupHeadView.h"

const CGFloat LineMargin = 10.0f;
const CGFloat DefaultLimitWith = 80.0f;

@interface SSMGroupHeadView ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) CGFloat allWidth;
@end

@implementation SSMGroupHeadView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initLayout];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    self.count = 0;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.pagingEnabled = NO;
    contentView.delegate = self;
    [self addSubview:contentView];
    self.contentView = contentView;
    self.contentView.tag = 10002;
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    self.lineView.tag = 1000;
    self.backgroundColor = [UIColor whiteColor];
    self.tag = 1001;
}

- (void)adjustLayout
{
    [self adjustSubViewsFrame];
}

- (void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
    SSMGroupItem *item = (SSMGroupItem *)[self.contentView viewWithTag:selectedIndex];
    [self moveToItem:item];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    NSArray *subviews = self.contentView.subviews;
    for (int i = 0; i < subviews.count; i++) {
        SSMGroupItem *item = subviews[i];
        if ([item isKindOfClass:[SSMGroupItem class]]) {
            [item setTitleColor:textColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
    NSArray *subviews = self.contentView.subviews;
    for (int i = 0; i < subviews.count; i++) {
        SSMGroupItem *item = subviews[i];
        if ([item isKindOfClass:[SSMGroupItem class]]) {
            [item setTitleColor:selectedTextColor forState:UIControlStateSelected];
        }
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.lineView.backgroundColor = indicatorColor;
}

- (void)insertGroupWithTitle:(NSString *)title
{
    SSMGroupItem *item = [SSMGroupItem buttonWithType:UIButtonTypeCustom];
    [item setTitle:title forState:UIControlStateNormal];
    item.direction = ArrowDirectionNone;
    item.tag = self.count;
    [item addTarget:self action:@selector(moveToItem:) forControlEvents:UIControlEventTouchUpInside];
    if (_textColor) {
        [item setTitleColor:_textColor forState:UIControlStateNormal];
    }
    if (_selectedTextColor) {
        [item setTitleColor:_selectedTextColor forState:UIControlStateSelected];
    }
    [self.contentView addSubview:item];
    self.count++;
}

- (void)insertGroupWithTitle:(NSString *)title direction:(ArrowDirection)direction
{
    SSMGroupItem *item = [SSMGroupItem buttonWithType:UIButtonTypeCustom];
    [item setTitle:title forState:UIControlStateNormal];
    item.direction = direction;
    item.tag = self.count;
    [item addTarget:self action:@selector(moveToItem:) forControlEvents:UIControlEventTouchUpInside];
    if (_textColor) {
        [item setTitleColor:_textColor forState:UIControlStateNormal];
    }
    if (_selectedTextColor) {
        [item setTitleColor:_selectedTextColor forState:UIControlStateSelected];
    }
    [self.contentView addSubview:item];
    self.count++;
}

- (void)setGroupTitle:(NSString *)title atIndex:(int)index
{
    SSMGroupItem *item = (SSMGroupItem *)[self.contentView viewWithTag:index];
    if (item && [item isKindOfClass:[SSMGroupItem class]]) {
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitle:title forState:UIControlStateSelected];
    }
}

- (void)moveToItem:(SSMGroupItem *)item
{
    if (![item isKindOfClass:[SSMGroupItem class]]) {
        return;
    }
    item.selected = YES;
    if (item.direction != ArrowDirectionNone) {
        item.showArrow = YES;
        if (item.direction == ArrowDirectionDown) {
            item.direction = ArrowDirectionUp;
        } else {
            item.direction = ArrowDirectionDown;
        }
    }
    for (SSMGroupItem *sitem in self.contentView.subviews) {
        if (sitem != item && [sitem isKindOfClass:[SSMGroupItem class]]) {
            sitem.selected = NO;
            sitem.showArrow = NO;
        }
    }
    CGRect lineRect = self.lineView.frame;
    lineRect.origin.x = item.frame.origin.x + LineMargin;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = lineRect;
    } completion:^(BOOL finished) {
        _selectedIndex = (int)item.tag;
        if ([self.delegate respondsToSelector:@selector(groupHeadViewGroupClicked:preIndex:atIndex:sender:)]) {
            [self.delegate groupHeadViewGroupClicked:self preIndex:(_selectedIndex - 1 < 1)?0:(_selectedIndex - 1) atIndex:_selectedIndex sender:item];
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 2, 0, 2);
    [self adjustSubViewsFrame];
}

- (void)adjustSubViewsFrame
{
    NSMutableArray *subviews = [NSMutableArray array];
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[SSMGroupItem class]]) {
            [subviews addObject:view];
        }
    }
    self.allWidth = self.contentView.frame.size.width / self.count;
    CGFloat height = self.contentView.frame.size.height;
    if (self.allWidth < DefaultLimitWith) {
        self.allWidth = DefaultLimitWith;
    }
    if (_selectedIndex == 0) {
        CGRect lineRect = self.lineView.frame;
        lineRect.size.width = self.allWidth - LineMargin * 2;
        lineRect.origin.x = LineMargin;
        self.lineView.frame = lineRect;
    }
    for (int i = 0; i < self.count; i++) {
        SSMGroupItem *item = subviews[i];
        item.frame = CGRectMake(i * self.allWidth, 0, self.allWidth, height);
    }
    self.contentView.contentSize = CGSizeMake(self.allWidth * self.count, 0);
}

- (void)drawRect:(CGRect)rect
{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context,1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context,0.862, 0.862, 0.913, 1.0);
    //开始绘制
    CGContextBeginPath(context);
    //画笔移动到点
    CGContextMoveToPoint(context,0, rect.size.height);
    //下一点
    CGContextAddLineToPoint(context,0, rect.size.height);
    //下一点
    CGContextAddLineToPoint(context,rect.size.width, rect.size.height);
    //绘制完成
    CGContextStrokePath(context);
}

@end
