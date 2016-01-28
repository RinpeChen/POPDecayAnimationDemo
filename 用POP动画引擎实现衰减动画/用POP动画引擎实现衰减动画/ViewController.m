//
//  ViewController.m
//  用POP动画引擎实现衰减动画
//
//  Created by RinpeChen on 16/1/26.
//  Copyright © 2016年 miaoqu. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // 初始化拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnPan:)];
    [btn addGestureRecognizer:pan];

}

- (void)btnPan:(UIPanGestureRecognizer *)recognizer
{
    // 获取手指移动后的位置
    CGPoint translation = [recognizer translationInView:self.view];
    
    UIButton *btn = (UIButton *)recognizer.view;
    btn.center = CGPointMake(btn.center.x + translation.x, btn.center.y + translation.y);
    
    // 复位, 否则手势会保留上一次的状态
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {    // 手势结束
        // 初始化POP的衰减动画
        POPDecayAnimation *decay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        // 设置加速度值
        decay.velocity = [NSValue valueWithCGPoint:[recognizer velocityInView:self.view]];
        // 添加动画
        [btn.layer pop_addAnimation:decay forKey:nil];
    }
}

// 点击按钮时移除所有POP动画
- (void)btnClick:(UIButton *)btn
{
    [btn.layer pop_removeAllAnimations];
}

@end
