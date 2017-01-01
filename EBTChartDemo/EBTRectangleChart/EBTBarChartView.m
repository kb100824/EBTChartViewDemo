//
//  EBTRectangleChartView.m
//  EBTChartDemo
//
//  Created by ebaotong on 16/4/7.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "EBTBarChartView.h"
#define KBarViewPadding 20 //进度条间距
#define KLabelMonthHeight  24   //月份label的高度
@interface EBTBarChartView ()
{
    CGFloat bar_Width; //设置进度条的宽度
    CGFloat bar_Height; //进度条的高度
    CADisplayLink *displayLink;
}

 @property(nonatomic,strong) NSMutableArray *fillViewArray; //保存填充view
 @property(nonatomic,strong) NSMutableArray *percentLabelArray; //保存对应显示百分比的label

@end

@implementation EBTBarChartView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    
}
- (NSMutableArray *)fillViewArray
{

    if (!_fillViewArray) {
        
        _fillViewArray = [NSMutableArray array];
        
    }
    
    return _fillViewArray;

}

- (NSMutableArray *)percentLabelArray
{
    if (!_percentLabelArray) {
        
        _percentLabelArray = [NSMutableArray array];
    }
    return _percentLabelArray;
}


- (void)setArray_Month:(NSArray *)array_Month
{
   
    
    NSAssert(array_Month.count>0, @"月份数组值不能为空");

    _array_Month = array_Month;
    //获取self自身的宽高度
    [self layoutIfNeeded];
    CGSize selfSize = self.bounds.size;
     bar_Width = (selfSize.width - (_array_Month.count-1)*KBarViewPadding)/(_array_Month.count*1.f);
     bar_Height = selfSize.height - KLabelMonthHeight;
    /**
     *  防止多次创建view
     */
  
    for (UIView *view in self.subviews)
    {
        [self.fillViewArray  removeAllObjects];
        [self.percentLabelArray removeAllObjects];
        [view removeFromSuperview];
    }

    for (NSInteger i = 0; i<_array_Month.count; i++) {
        
        /**
            创建底部view
         */
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake((bar_Width+KBarViewPadding)*i, 0, bar_Width, bar_Height)];
        backView.layer.cornerRadius = 3.f;
        backView.layer.masksToBounds = YES;
        backView.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
        
        /**
         创建月份label
         */
        UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake((bar_Width+KBarViewPadding)*i, selfSize.height- KLabelMonthHeight, bar_Width, KLabelMonthHeight)];
        monthLabel.text = _array_Month[i];
        monthLabel.font = [UIFont systemFontOfSize:12.f];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        monthLabel.textColor = [UIColor blackColor];
        [self addSubview:monthLabel];
        [self addSubview:backView];
        
       
        
        
    }


}

- (void)barChartView:(NSArray *)array_Progress withChartViewColor:(UIColor *)backGroundColor
{

    
    NSAssert(array_Progress.count>0, @"月份进度值不能为空");
    
    if (!self.fillViewArray||!self.percentLabelArray)
    {
        return;
    }
    
    for (NSInteger i = 0; i<array_Progress.count; i++) {
        
        /**
         创建填充view
         */
        UIView *fillView = [[UIView alloc]initWithFrame:CGRectMake((bar_Width+KBarViewPadding)*i,bar_Height, bar_Width, 0)];
        fillView.backgroundColor = backGroundColor;
        fillView.layer.cornerRadius = 2.f;
        fillView.layer.masksToBounds = YES;
        [self addSubview:fillView];
        /**
         创建百分比label
         */
        UILabel *pecentLabel = [[UILabel alloc]initWithFrame:CGRectMake((bar_Width+KBarViewPadding)*i, bar_Height, bar_Width, 0)];
        pecentLabel.textAlignment = NSTextAlignmentCenter;
        pecentLabel.font = [UIFont systemFontOfSize:10];
        pecentLabel.textColor = [UIColor grayColor];
        [self.percentLabelArray addObject:pecentLabel];
        [self addSubview:pecentLabel];
        
        [self.fillViewArray addObject:fillView];
        
    }
    
    /**
     *  重新设置进度条view的frame
     */
    for (NSInteger i = 0; i<self.fillViewArray.count; i++) {
        
        UIView *fillView = self.fillViewArray[i];
        CGRect rect = fillView.frame;
        
        CGFloat progressValue = 0.0f;
        
        if ([array_Progress[i] doubleValue]<=0.f) {
            progressValue = 0.f;
        }
        else if ([array_Progress[i] doubleValue]>=bar_Height) {
            progressValue = bar_Height;
        }
        else
        {
            progressValue = [array_Progress[i] doubleValue];
        }
        rect.origin.y = bar_Height - (progressValue/bar_Height)*bar_Height;
        rect.size.height = (progressValue/bar_Height)*bar_Height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fillView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        
        
        
    }
    
    /**
     *  重新设置百分比的label
     */
    for (NSInteger i = 0; i<self.percentLabelArray.count; i++) {
        
        
        UILabel *percentLabel = self.percentLabelArray[i];
        
        CGRect newRect = percentLabel.frame;
        
        CGFloat progressValue = 0.0f;
        
        if ([array_Progress[i] doubleValue]<=0.f) {
            progressValue = 0.f;
        }
        else if ([array_Progress[i] doubleValue]>=bar_Height) {
            progressValue = bar_Height;
        }
        else
        {
            progressValue = [array_Progress[i] doubleValue];
        }
        CGFloat percent = (progressValue/bar_Height)*100;
        NSString *percentResult = percent==0.00?@"":[NSString stringWithFormat:@"%.f%%",percent];
        percentLabel.attributedText = [self formatterPercent:percentResult];
        newRect.origin.y = bar_Height - (progressValue/bar_Height)*bar_Height-KLabelMonthHeight;
        newRect.size.height = KLabelMonthHeight;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            percentLabel.frame = newRect;
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }
    

    

}



- (NSMutableAttributedString *)formatterPercent:(NSString *)percent
{
    NSMutableAttributedString *attibute = [[NSMutableAttributedString alloc]initWithString:percent];
    
    NSDictionary *dic_Attibute = @{
                                   NSForegroundColorAttributeName:[UIColor redColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:12]
                                   
                                   };
    
    [attibute addAttributes:dic_Attibute range:NSMakeRange(0, percent.length==0?0:percent.length-1)];
    
    return attibute;
    

}



@end
