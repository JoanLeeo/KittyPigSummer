//
//  BlankModel.h
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2017/10/15.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlankModel : NSObject

@property (nonatomic, assign) NSInteger index;//位置
@property (nonatomic, assign) NSInteger toIndex;//将要滑到的位置
@property (nonatomic, assign) CGPoint orgin; //滑块位置
@property (nonatomic, assign) NSInteger displayNum; //显示数字

@property (nonatomic, strong) UILabel *blankLb; //label

@end
