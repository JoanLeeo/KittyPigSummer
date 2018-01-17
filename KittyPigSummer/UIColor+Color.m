//
//  UIColor+Color.m
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2017/10/14.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor blackColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor blackColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R
    NSString *rString = [cString substringWithRange:range];
    //G
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //B
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0];
}

+ (UIColor *)blankBgColorWithNum:(NSInteger)num {
    switch (num) {
        case 2: return [self colorWithHexString:@"#eee4da"]; break;
        case 4: return [self colorWithHexString:@"#ede0c8"]; break;
        case 8: return [self colorWithHexString:@"#f2b179"]; break;
        case 16: return [self colorWithHexString:@"#f59563"]; break;
        case 32: return [self colorWithHexString:@"#f67c5f"]; break;
        case 64: return [self colorWithHexString:@"#f65e3b"]; break;
        case 128: return [self colorWithHexString:@"#edcf72"]; break;
        case 256: return [self colorWithHexString:@"#edcc61"]; break;
        case 512: return [self colorWithHexString:@"#99cc00"]; break;
        case 1024: return [self colorWithHexString:@"#33b5e5"]; break;
        case 2048: return [self colorWithHexString:@"#0099cc"]; break;
        case 4096: return [self colorWithHexString:@"#aa66cc"]; break;
        case 8192: return [self colorWithHexString:@"#9933c"]; break;
        default: return [UIColor redColor]; break;
    }
    return [UIColor redColor];
}
+ (UIColor *)blankNumColorWithNum:(NSInteger)num {
    return num > 4 ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#776e65"];
}
@end
