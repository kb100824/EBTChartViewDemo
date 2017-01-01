//
//  ViewController.m
//  EBTChartDemo
//
//  Created by ebaotong on 16/4/7.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "ViewController.h"
#import "EBTBarChartView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet EBTBarChartView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    
    NSArray *arr1 = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月"];
    NSArray *arr2 = @[@80,@120,@160,@400,@180,@(160),@(140)];
    
    
    self.chartView.array_Month = arr1;
    
    [self.chartView barChartView:arr2 withChartViewColor:[UIColor colorWithRed:0.000 green:0.000 blue:0.665 alpha:1.000]];
    
    
}

@end
