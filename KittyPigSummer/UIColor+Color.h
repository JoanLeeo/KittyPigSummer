//
//  UIColor+Color.h
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2017/10/14.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)
/**
 *  将16进制字符串转换成UIColor  e.g. #ffffff
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)blankBgColorWithNum:(NSInteger)num;
+ (UIColor *)blankNumColorWithNum:(NSInteger)num;
@end
