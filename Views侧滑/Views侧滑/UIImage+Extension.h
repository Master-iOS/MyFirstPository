//
//  UIImage+Extension.h
//  MyTools马松涛的工具类
//
//  Created by tarena on 15/9/10.
//  Copyright (c) 2015年 Mr.Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 创建一个自定义颜色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 创建一个自定义边框的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
