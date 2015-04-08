//
//  SSMGroupHeadView.m
//  SSMGroupHeadView
//
//  Created by apple on 15-4-7.
//  Copyright (c) 2015年 ZhaoYang. All rights reserved.
//

#import "SSMGroupHeadView.h"

@interface SSMGroupHeadView ()
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, assign) int count;
@end

@implementation SSMGroupHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = 0;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 2)];
        [self addSubview:contentView];
        self.contentView = contentView;
        self.contentView.tag = 10002;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 2, 60, 2)];
        lineView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:lineView];
        self.lineView = lineView;
        self.lineView.tag = 1000;
        self.backgroundColor = [UIColor whiteColor];
        self.tag = 1001;
    }
    return self;
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
    for (int i = 0; i < self.count; i++) {
        SSMGroupItem *item = subviews[i];
        [item setTitleColor:textColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
    NSArray *subviews = self.contentView.subviews;
    for (int i = 0; i < self.count; i++) {
        SSMGroupItem *item = subviews[i];
        [item setTitleColor:selectedTextColor forState:UIControlStateSelected];
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

- (void)moveToItem:(SSMGroupItem *)item
{
    CGPoint center = item.center;
    CGFloat y = self.lineView.center.y;
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
        if (sitem != item) {
            sitem.selected = NO;
            sitem.showArrow = NO;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center = CGPointMake(center.x, y);
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
    NSArray *subviews = self.contentView.subviews;
    int count = (int)subviews.count;
    CGFloat width = self.contentView.frame.size.width / count;
    CGFloat height = self.contentView.frame.size.height;
    self.lineView.center = CGPointMake(width / 2, self.lineView.center.y);
    for (int i = 0; i < count; i++) {
        SSMGroupItem *item = subviews[i];
        item.frame = CGRectMake(i * width, 0, width, height);
    }
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
