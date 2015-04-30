# SSMGroupHeadView
一个可以滑动的选项卡控件，支持无限分组，使用简单。
======
    SSMGroupHeadView *headView = [[SSMGroupHeadView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    [headView insertGroupWithTitle:@"新品"]; //插入一组文字
    [headView insertGroupWithTitle:@"价格" direction:ArrowDirectionUp]; //插入一组文字+带上下箭头指示器
    headView.selectedIndex = 0; //设置当前选择组
    [self.view addSubview:headView];
