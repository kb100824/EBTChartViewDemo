//
//  EBTRectangleChartView.h
//  EBTChartDemo
//
//  Created by ebaotong on 16/4/7.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBTBarChartView : UIView

/**
 *  月份
 */
@property(nonatomic,strong) NSArray *array_Month;







- (void)barChartView:(NSArray *)array_Progress withChartViewColor:(UIColor *)backGroundColor;


@end
