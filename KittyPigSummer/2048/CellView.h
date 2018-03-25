//
//  CellView.h
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2018/3/25.
//  Copyright © 2018年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UIView

@property (nonatomic, assign) NSUInteger value;

+(instancetype)createCellViewPosition:(CGPoint)position
                            cellWidth:(CGFloat)cellWidth
                                value:(NSUInteger)value;

@end
