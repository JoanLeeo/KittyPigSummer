//
//  CellView.m
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2018/3/25.
//  Copyright © 2018年 GreatGate. All rights reserved.
//

#import "CellView.h"
@interface CellView()
@property (nonatomic, strong) UILabel *cellLb;

@end
@implementation CellView


+(instancetype)createCellViewPosition:(CGPoint)position
                            cellWidth:(CGFloat)cellWidth
                                value:(NSUInteger)value {
    
    CGRect cellRect = CGRectMake(position.x, position.y, cellWidth, cellWidth);
    CellView *cell = [[CellView alloc] init];
    cell.backgroundColor = [UIColor grayColor];
    cell.frame = cellRect;
    cell.value = value;
    
    
    UILabel *cellLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellWidth)];
    cellLb.textAlignment = NSTextAlignmentCenter;
    cellLb.text = [NSString stringWithFormat:@"%ld", value];
    cellLb.font = [UIFont systemFontOfSize:14];
    cell.cellLb = cellLb;
    
    [cell addSubview:cellLb];
    
    return cell;
    
    
}
- (void)setValue:(NSUInteger)value {
    _value = value;
    self.cellLb.text = [NSString stringWithFormat:@"%ld", _value];
    self.cellLb.textColor = [UIColor blankNumColorWithNum:_value];
    self.backgroundColor = [UIColor blankBgColorWithNum:_value];
    
    NSLog(@"value = %ld", value);
    
}
@end
