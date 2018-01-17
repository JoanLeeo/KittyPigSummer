//
//  BlankModel.m
//  KittyPigSummer
//
//  Created by AHUI_MAC on 2017/10/15.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import "BlankModel.h"

@implementation BlankModel



- (void)setBlankLb:(UILabel *)blankLb {
    _blankLb = blankLb;
    CGRect rect = {_orgin, blankLb.bounds.size.width, blankLb.bounds.size.width};
    _blankLb.frame = rect;
    
    _blankLb.text = [NSString stringWithFormat:@"%ld", _displayNum];
    _blankLb.textColor = [UIColor blankNumColorWithNum:_displayNum];
    _blankLb.backgroundColor = [UIColor blankBgColorWithNum:_displayNum];
    
}

@end
