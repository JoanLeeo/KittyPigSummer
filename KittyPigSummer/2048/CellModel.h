//
//  CellModel.h
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2018/3/24.
//  Copyright © 2018年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic, assign) NSInteger start1;
@property (nonatomic, assign) NSInteger start2;
@property (nonatomic, assign) NSInteger end;
@property (nonatomic, assign) NSUInteger value;
@property (nonatomic, assign) BOOL isMerged;//是否合并
@property (nonatomic, assign) BOOL isMoved;//是否移动

+ (instancetype)cellModel;
@end
