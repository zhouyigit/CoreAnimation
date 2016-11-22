//
//  ViewController.m
//  CoreAnimation
//
//  Created by still on 16/11/21.
//  Copyright © 2016年 still. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.aNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    self.aNav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.aNav];
    
    self.anIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 60, 90)];
    self.anIV.image = [UIImage imageNamed:@"image.jpg"];
    self.anIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allAnimation:)];
    [self.anIV addGestureRecognizer:tap];
    [self.view addSubview:self.anIV];
    
    float width = WIDTH/3.0;
    float height_44 = 44;
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, HEIGHT-height_44, width, height_44)];
    [button1 setTitle:@"position" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor greenColor]];
    [button1 addTarget:self action:@selector(position:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(width, HEIGHT-height_44, width, height_44)];
    [button2 setTitle:@"opacity" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor greenColor]];
    [button2 addTarget:self action:@selector(opacity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(width*2, HEIGHT-height_44, width, height_44)];
    [button3 setTitle:@"transform" forState:UIControlStateNormal];
    [button3 setBackgroundColor:[UIColor greenColor]];
    [button3 addTarget:self action:@selector(transform:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)allAnimation:(UITapGestureRecognizer*)tap {
    CGPoint fromPoint = self.anIV.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(300, 460);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
    animGroup.duration = 1;
    [self.anIV.layer addAnimation:animGroup forKey:nil];
}

-(void) position:(UIButton*)button {
    CGPoint fromPoint = self.anIV.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(300, 460);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    [self.anIV.layer addAnimation:moveAnim forKey:nil];
}

-(void)opacity:(UIButton*)button{
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    [self.anIV.layer addAnimation:opacityAnim forKey:nil];
}

-(void)transform:(UIButton*)button{
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    [self.anIV.layer addAnimation:scaleAnim forKey:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = 5;
    animation.repeatCount = MAXFLOAT;
//    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.beginTime = CACurrentMediaTime() + 0.0;
    animation.values = [NSArray arrayWithObjects:
                        (id)self.aNav.backgroundColor.CGColor,
                        [UIColor redColor].CGColor,
                        [UIColor yellowColor].CGColor,
                        self.aNav.backgroundColor.CGColor, nil];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    //添加动画并执行，PS：key值要与value相符，否则无效
    [self.aNav.layer addAnimation:animation forKey:@"backgroundColor"];
    
    //动画执行中被移除
//    [self performSelector:@selector(removeAnimationForKey:) withObject:@"backgroundColor" afterDelay:4];
    
}

- (void)removeAnimationForKey:(NSString*)key {
    [self.aNav.layer removeAnimationForKey:key];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationDidStart:(CAAnimation *)anim; {
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop %d", flag);
}

@end
