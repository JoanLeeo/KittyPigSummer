//
//  _2048ViewController.m
//  KittyPigSummer
//
//  Created by Leonardo on 2017/10/13.
//  Copyright © 2017年 GreatGate. All rights reserved.
//

#import "_2048ViewController.h"
#import "PigHeader.h"
#import "BlankModel.h"

@interface _2048ViewController () {
    CGFloat _blankW;
    UIView *gameBgView;
}
@property (nonatomic, strong) NSMutableArray *numArray;//存储响应位置数字  0 空白 > 0 响应数字 2 4 8...
@property (nonatomic, strong) NSMutableArray *blankViewArray;
@end

@implementation _2048ViewController

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
    
    [self newGameBtnAction];
    
    for (int i = 0; i < 16; i++) {
        BlankModel *blank = [[BlankModel alloc] init];
        blank.index = i;
        blank.toIndex = 0;
        blank.orgin = CGPointMake(i % 4 * (_blankW + 8) + 8, i / 4 * (_blankW + 8) + 8);
        blank.displayNum = 0;
        blank.blankLb = nil;
        [self.numArray addObject:blank];
    }
   
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
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [gameBgView addGestureRecognizer:panGes];
    
    
    CGFloat blankGap = 8;
    CGFloat blankBgViewX = 0;
    CGFloat blankBgViewY = 0;
    CGFloat blankBgViewW = (gameBgViewW - blankGap * 5) / 4;
    CGFloat blankBgViewH = blankBgViewW;
    _blankW = blankBgViewW;
    for (int i = 0; i < 16; i++) {
        blankBgViewX = i % 4 * (blankBgViewW + blankGap) + blankGap;
        blankBgViewY = i / 4 * (blankBgViewH + blankGap) + blankGap;
        UIView *blankBgView = [[UIView alloc] initWithFrame:CGRectMake(blankBgViewX, blankBgViewY, blankBgViewW, blankBgViewH)];
        blankBgView.backgroundColor = [UIColor colorWithHexString:@"#ccc0b3"];
        blankBgView.layer.cornerRadius = 3;
        blankBgView.layer.masksToBounds = YES;
        [gameBgView addSubview:blankBgView];
        
        UILabel *blankLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, blankBgViewW, blankBgViewH)];
        blankLb.textAlignment = NSTextAlignmentCenter;
        blankLb.font = [UIFont boldSystemFontOfSize:30];
        blankLb.layer.cornerRadius = 3;
        blankLb.layer.masksToBounds = YES;
        [self.blankViewArray addObject:blankLb];
    }
    
}
- (void)newGameBtnAction {
    
   
    NSInteger rand = arc4random() % 16;
    
    NSInteger random =  arc4random() % 100;
    if (random >= 20) { //80% 生成2 20% 生成4
        
    } else {
        
        
    }
    
}
//生成一个 2 或 4
- (void)createNewBlank {
    
    
    
    
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
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
                NSLog(@"向左滑动");
            }else{
                //向右滑动
                NSLog(@"向右滑动");
            }
            
        } else if (absY > absX) {
            if (translation.y < 0) {
                //向上滑动
                NSLog(@"向上滑动");
            } else {
                //向下滑动
                NSLog(@"向下滑动");
            }
        }
    }
    
}
@end
