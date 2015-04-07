//
//  SSMViewController.m
//  SSMGroupHeadView
//
//  Created by apple on 15-4-7.
//  Copyright (c) 2015年 ZhaoYang. All rights reserved.
//

#import "SSMViewController.h"
#import "SSMGroupHeadView.h"

@interface SSMViewController ()

@end

@implementation SSMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SSMGroupHeadView *headView = [[SSMGroupHeadView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    [headView insertGroupWithTitle:@"新品"];
    [headView insertGroupWithTitle:@"价格" direction:ArrowDirectionUp];
    [headView insertGroupWithTitle:@"人气"];
    [headView insertGroupWithTitle:@"销量" direction:ArrowDirectionUp];
    [self.view addSubview:headView];
    headView.selectedIndex = 0;
}

@end
