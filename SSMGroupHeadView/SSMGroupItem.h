//
//  SSMGroupItem.h
//  SSMGroupHeadView
//
//  Created by apple on 15-4-7.
//  Copyright (c) 2015年 ZhaoYang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  箭头指示器方向
 */
typedef enum {
    /**
     *  无箭头指示器
     */
    ArrowDirectionNone,
    /**
     *  向上箭头指示器
     */
    ArrowDirectionUp,
    /**
     *  向下箭头指示器
     */
    ArrowDirectionDown
}ArrowDirection;

@interface SSMGroupItem : UIButton
/**
 *  箭头指示器方向
 */
@property(nonatomic,assign)ArrowDirection direction;
/**
 *  是否显示箭头指示器
 */
@property (nonatomic, assign) BOOL showArrow;
@end
