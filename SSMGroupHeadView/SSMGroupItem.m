//
//  SSMGroupItem.m
//  SSMGroupHeadView
//
//  Created by apple on 15-4-7.
//  Copyright (c) 2015年 ZhaoYang. All rights reserved.
//

#import "SSMGroupItem.h"

@interface SSMGroupItem ()
@property (nonatomic, weak) UIImageView *arrowImageView;
@end

@implementation SSMGroupItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        arrow.hidden = YES;
        [self addSubview:arrow];
        self.arrowImageView = arrow;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setDirection:(ArrowDirection)direction
{
    _direction = direction;
    if (_direction == ArrowDirectionUp) {
        self.arrowImageView.image = [UIImage imageNamed:@"SSMGroupHeadView.bundle/priceLightDown.png"];
    } else if (_direction == ArrowDirectionDown) {
        self.arrowImageView.image = [UIImage imageNamed:@"SSMGroupHeadView.bundle/priceLightUp.png"];
    } else {
        self.arrowImageView.image = nil;
    }
}

- (void)setShowArrow:(BOOL)showArrow
{
    _showArrow = showArrow;
    self.arrowImageView.hidden = !showArrow;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect imageRect = self.arrowImageView.frame;
    NSString *title = self.currentTitle;
    CGSize textSize = [title boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    imageRect.origin.x = self.frame.size.width / 2 + textSize.width / 2 + imageRect.size.width;
    imageRect.origin.y = (self.frame.size.height - imageRect.size.height) / 2;
    self.arrowImageView.frame = imageRect;
}

- (void)setHighlighted:(BOOL)highlighted
{
}

@end
