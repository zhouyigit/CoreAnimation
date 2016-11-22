//
//  ViewController.h
//  CoreAnimation
//
//  Created by still on 16/11/21.
//  Copyright © 2016年 still. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController : UIViewController<CAAnimationDelegate>

@property (nonatomic, strong) UIView *aNav;
@property (nonatomic, strong) UIImageView *anIV;


@end

