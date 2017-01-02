# 动态创建直方图图表(cocoapods)

使用指令  pod 'EBTBarChartView', '~> 0.0.1' 把该库添加到项目中

#在xib或者sb上拖一个view在控制器上面并设置view的class为:EBTBarChartView,

#并拖线条通过设置对应的属性和以及调用对应的方法来实现动态创建的直方图图表

#使用案例

    //设置横坐标数组值
    NSArray *arr1 = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月"];
    
    //设置纵坐标数组值
    NSArray *arr2 = @[@80,@120,@160,@400,@180,@(160),@(140)];
    
    self.chartView.array_Month = arr1;
    
    [self.chartView barChartView:arr2 withChartViewColor:[UIColor colorWithRed:0.000 green:0.000 blue:0.665 alpha:1.000]];







# 效果演示图

![Image](https://github.com/KBvsMJ/EBTChartViewDemo/blob/master/gif/1.gif)
