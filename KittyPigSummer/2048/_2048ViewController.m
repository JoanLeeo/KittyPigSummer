//
//  _2048ViewController.m
//  KittyPigSummer
//
//  Created by Leonardo on 2017/10/13.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import "_2048ViewController.h"
#import "PigHeader.h"
#import "CellModel.h"
#import "CellView.h"


#define POP_START_SCALE 0.1
#define POP_END_SCALE 1.0
#define ANIMATION_TIME .3f

typedef NS_ENUM(NSInteger, CellMoveDrection) {
    CellMoveDrectionUp = 0,
    CellMoveDrectionDown,
    CellMoveDrectionLeft,
    CellMoveDrectionRight
};

@interface _2048ViewController () {
    CGFloat _blankW;
    CGFloat _blankGap;
    UIView *gameBgView;
}
@property (nonatomic, strong) NSMutableArray *numArray;//存储响应位置数字  0 空白 > 0 响应数字 2 4 8...
@property (nonatomic, strong) NSMutableArray *blankViewArray;
@property (nonatomic, strong) NSMutableDictionary *cellModelDict;//存储cell模型
@end

@implementation _2048ViewController
- (NSMutableDictionary *)cellModelDict {
    if (!_cellModelDict) {
        _cellModelDict = [NSMutableDictionary dictionary];
    }
    return _cellModelDict;
}
- (NSMutableArray *)numArray {
    if (!_numArray) {
        _numArray = [NSMutableArray array];
    }
    return _numArray;
}
- (NSMutableArray *)blankViewArray {
    if (!_blankViewArray) {
        _blankViewArray = [NSMutableArray array];
    }
    return _blankViewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化UI
    [self customUI];
    
//    [self newGameBtnAction];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
   
    // Dispose of any resources that can be recreated.
}

- (void)customUI {
    self.view.backgroundColor = kRGB(240, 240, 210);
//    [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:210 / 255.0 alpha:1];
    
    
    //新游戏
    UIButton *newgameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newgameBtn setTitle:@"新游戏" forState:UIControlStateNormal];
    newgameBtn.frame = CGRectMake(0, 84, 100, 40);
    newgameBtn.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, newgameBtn.frame.origin.y + newgameBtn.frame.size.height * 0.5);
    newgameBtn.backgroundColor = [UIColor colorWithHexString:@"#c5b883"];
    
    newgameBtn.layer.cornerRadius = 5;
    newgameBtn.layer.masksToBounds = YES;
    [newgameBtn addTarget:self action:@selector(newGameBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newgameBtn];
    
    //分数
    UILabel *scoreLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(newgameBtn.frame) + 10, [UIScreen mainScreen].bounds.size.width, 20)];
    scoreLb.textAlignment = NSTextAlignmentCenter;
    scoreLb.font = [UIFont boldSystemFontOfSize:20];
    scoreLb.text = @"分数:0";
    [self.view addSubview:scoreLb];
    
    //bg
    CGFloat gameBgViewX = 15;
    CGFloat gameBgViewY = CGRectGetMaxY(scoreLb.frame) + 10;
    CGFloat gameBgViewW = [UIScreen mainScreen].bounds.size.width - gameBgViewX * 2;
    CGFloat gameBgViewH = gameBgViewW;
    gameBgView = [[UIView alloc] initWithFrame:CGRectMake(gameBgViewX, gameBgViewY, gameBgViewW, gameBgViewH)];
    gameBgView.backgroundColor = [UIColor colorWithHexString:@"#bbada0"];
    
    gameBgView.layer.cornerRadius = 5;
    gameBgView.layer.masksToBounds = YES;
    [self.view addSubview:gameBgView];
    
    //添加滑动手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [gameBgView addGestureRecognizer:panGes];
    
    
    _blankGap = 8;
    CGFloat blankBgViewX = 0;
    CGFloat blankBgViewY = 0;
    CGFloat blankBgViewW = ceilf((gameBgViewW - _blankGap * 5) / 4);
    CGFloat blankBgViewH = blankBgViewW;
    _blankW = blankBgViewW;
    for (int i = 0; i < 16; i++) {
        blankBgViewX = i % 4 * (blankBgViewW + _blankGap) + _blankGap;
        blankBgViewY = i / 4 * (blankBgViewH + _blankGap) + _blankGap;
        UIView *blankBgView = [[UIView alloc] initWithFrame:CGRectMake(blankBgViewX, blankBgViewY, blankBgViewW, blankBgViewH)];
        blankBgView.backgroundColor = [UIColor colorWithHexString:@"#ccc0b3"];
        blankBgView.layer.cornerRadius = 3;
        blankBgView.layer.masksToBounds = YES;
        [gameBgView addSubview:blankBgView];
    }
    
}


- (void)newGameBtnAction {
    
    CellView *cell = [self createNewBlank];
    
    if (cell) {
        cell.layer.affineTransform = CGAffineTransformMakeScale(POP_START_SCALE, POP_START_SCALE);
         [gameBgView addSubview:cell];
        [UIView animateWithDuration:ANIMATION_TIME animations:^{
            cell.layer.affineTransform = CGAffineTransformIdentity;
        }];
    }
    
}
- (NSArray *)moveModel:(NSArray *)cellArr {

    NSMutableArray *moveArr = [NSMutableArray array];
    BOOL isMoved = NO;
    for (int i = 0; i < cellArr.count; i++) {//先把0，移除
        NSUInteger num = [cellArr[i] unsignedIntegerValue];
        if (num == 0) {
            isMoved = YES;
        } else {
            CellModel *cellModel = [CellModel cellModel];
            cellModel.isMoved = isMoved;
            cellModel.start1 = i;
            cellModel.value = num;
            [moveArr addObject:cellModel];
        }
    }
    
    int i = 0;
    NSMutableArray *moveArr2 = [NSMutableArray array];
    while (YES) {//合并
        if (i + 1 >= moveArr.count) {//如果只有一个元素，或者越界了,退出
            if (i + 1 == moveArr.count) {//如果只有一个元素
                CellModel *cellModel = moveArr[i];
                cellModel.end = i;
                [moveArr2 addObject:moveArr[i]];
            }
            break;
        }
        CellModel *cellModel1 = moveArr[i];
        CellModel *cellModel2 = moveArr[i+1];
        cellModel1.end = i;
        if (cellModel1.value == cellModel2.value) {
            cellModel1.start2 = cellModel2.start1;
            cellModel1.isMerged = YES;
            cellModel1.value = cellModel1.value * 2;
            [moveArr2 addObject:cellModel1];
            i += 2;
        } else {
            [moveArr2 addObject:cellModel1];
            i++;
        }
    }
    for (int i = 0; i < moveArr2.count; i++) {
        CellModel *model = moveArr2[i];
        model.end = i;
    }
    
    for (CellModel *model in moveArr2) {
        NSLog(@"start1 = %ld, start2 = %ld, end = %ld", model.start1, model.start2, model.end);
       
    }
     NSLog(@"------\n");
    return moveArr2;
    
}
//生成一个 2 或 4
- (CellView *)createNewBlank {
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (int row = 0; row < 4; row++) {//筛选出所有空白格子
        for (int column = 0; column < 4; column++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:column];
            if (!self.cellModelDict[indexPath]) {
                [mArr addObject:indexPath];
            }
        }
    }
    
    NSInteger mCount = mArr.count;
    if (mCount == 0) {//满了
        NSLog(@"已经满了");
        return nil;
    }
    NSInteger random = arc4random_uniform((uint32_t)mArr.count);
    NSIndexPath *keyIndexPath = mArr[random];
    
    NSLog(@"row = %ld, column = %ld", keyIndexPath.row,  keyIndexPath.section);
    
    NSUInteger valueKey = arc4random_uniform((uint32_t)10);
    NSUInteger value = valueKey < 2 ? 4 : 2;
    CGPoint position = [self createPointIdnexPath:keyIndexPath];
    
    CellView *cell = [CellView createCellViewPosition:position cellWidth:_blankW value:value];
    [self.cellModelDict setObject:cell forKey:keyIndexPath];
    return cell;
    
}

- (void)panGes:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [pan translationInView:self.view];
        CGFloat absX = fabs(translation.x);
        CGFloat absY = fabs(translation.y);
        
        // 设置滑动有效距离
        if (MAX(absX, absY) < 10) {
            NSLog(@"设置滑动有效距离");
            return;
        }
        if (absX > absY ) {
            
            if (translation.x < 0) {
                //向左滑动
//                [self moveDirection:CellMoveDrectionLeft];
                NSLog(@"向左滑动");
            }else{
                //向右滑动
//                [self moveDirection:CellMoveDrectionRight];
                NSLog(@"向右滑动");
            }
            
        } else if (absY > absX) {
            if (translation.y < 0) {
                //向上滑动
                [self moveDirection:CellMoveDrectionUp];
                NSLog(@"向上滑动");
            } else {
                //向下滑动
                [self moveDirection:CellMoveDrectionDown];
                NSLog(@"向下滑动");
            }
        }
        
        [self createNewBlank];
    }
    
}

- (void)moveDirection:(CellMoveDrection)direction {
    
    switch (direction) {
        case CellMoveDrectionDown:
        {
            
            break;
        }
        case CellMoveDrectionUp:
        {
            for (int column = 0; column < 4; column++) {
                
                NSMutableArray *cellArr = [NSMutableArray array];
                for (int row = 0; row < 4; row++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:column];
                    CellView *cellView = self.cellModelDict[indexPath];
                    if (cellView) {
                        [cellArr addObject:@(cellView.value)];
                    } else {
                        [cellArr addObject:@0];
                    }
                }
                NSArray *moveModelArr =  [self moveModel:cellArr];
                [self moveCellView:moveModelArr direction:direction index:column];
            }
            break;
        }
        case CellMoveDrectionLeft:
        {
            break;
        }
        case CellMoveDrectionRight:
        {
            break;
        }
        default:
            break;
    }
    
    
}
- (void)moveCellView:(NSArray *)moveModelArr direction:(CellMoveDrection)direction index:(NSUInteger)index{
    
    
    for (int i = 0; i < moveModelArr.count; i++) {
        CellModel *model = moveModelArr[i];
        
        if (model.start2 >=0 && model.start2 != model.end) {
            NSIndexPath *startIndexPath = [NSIndexPath indexPathForRow:model.start2 inSection:index];
            NSIndexPath *endIndexPath = [NSIndexPath indexPathForRow:model.end inSection:index];
            CellView *cellView = self.cellModelDict[startIndexPath];
            [self.cellModelDict removeObjectForKey:startIndexPath];
            CGRect originRect = cellView.frame;
            originRect.origin = [self createPointIdnexPath:endIndexPath];
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                cellView.frame = originRect;
            } completion:^(BOOL finished) {
                [cellView removeFromSuperview];
            }];
        }
        
        if (model.start1 >= 0) {
            NSIndexPath *startIndexPath = [NSIndexPath indexPathForRow:model.start1 inSection:index];
            NSIndexPath *endIndexPath = [NSIndexPath indexPathForRow:model.end inSection:index];
            if (model.start1 != model.end) {
                CellView *cellView = self.cellModelDict[startIndexPath];
                
                CGRect originRect = cellView.frame;
                originRect.origin = [self createPointIdnexPath:endIndexPath];
                [UIView animateWithDuration:ANIMATION_TIME animations:^{
                    cellView.frame = originRect;
                } completion:^(BOOL finished) {
                    cellView.value = model.value;
                }];
                [self.cellModelDict removeObjectForKey:startIndexPath];
                [self.cellModelDict setObject:cellView forKey:endIndexPath];
            } else {
                CellView *endCellView = self.cellModelDict[endIndexPath];
                endCellView.value = model.value;
            }
        }
        
    }
    
    
}
//获得cell的orgin
- (CGPoint)createPointIdnexPath:(NSIndexPath *)idnexPath {
    
    CGFloat x = idnexPath.section * (_blankW + _blankGap) + _blankGap;
    CGFloat y = idnexPath.row * (_blankW + _blankGap) + _blankGap;
    return CGPointMake(x, y);
}



@end
