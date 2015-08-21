//
//  ViewController.m
//  RightSlideMenu
//
//  Created by 付付 on 15/8/21.
//  Copyright (c) 2015年 PogoShow. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
typedef enum state {
    kStateHome,
    kStateMenu
}state;


#define UIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]
static const CGFloat viewSlideHorizonRatio = 0.75;
static const CGFloat viewHeightNarrowRatio = 0.80;
static const CGFloat menuStartNarrowRatio  = 0.70;
@interface ViewController ()<homeViewControllerDelegate>


@property (assign, nonatomic) state   sta;              // 状态(Home or Menu)
@property (assign, nonatomic) CGFloat distance;         // 距离右边的边距
@property (assign, nonatomic) CGFloat rightDistance;
@property (assign, nonatomic) CGFloat menuCenterXStart; // menu起始中点的X
@property (assign, nonatomic) CGFloat menuCenterXEnd;   // menu缩放结束中点的X
@property (assign, nonatomic) CGFloat panStartX;        // 拖动开始的x值
@property(nonatomic, strong)MenuViewController *rightVc;
@property(nonatomic, strong)HomeViewController *menuController;
@property(nonatomic, strong)UINavigationController *navVc;
@property(nonatomic, strong)UIView *cover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sta = kStateHome;
    self.distance = 0;
    self.menuCenterXStart = [UIScreen mainScreen].bounds.size.width * menuStartNarrowRatio;
    self.menuCenterXEnd = self.view.center.x;
    self.rightDistance = [UIScreen mainScreen].bounds.size.width * viewSlideHorizonRatio;
    
    self.view.backgroundColor = [UIColor orangeColor];
    // 设置背景
    //    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    //    bg.frame = [[UIScreen mainScreen] bounds];
    //    [self.view addSubview:bg];
    
    self.rightVc = [[MenuViewController alloc] init];
    [self.view addSubview:self.rightVc.view];
    self.rightVc.view.frame = [[UIScreen mainScreen] bounds];
    self.rightVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuStartNarrowRatio, menuStartNarrowRatio);
    self.rightVc.view.center = CGPointMake(self.menuCenterXStart, self.rightVc.view.center.y);
    
    // 设置遮盖
    self.cover = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.cover.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.cover];
    self.cover.hidden = YES;
    
    
    
    self.menuController = [[HomeViewController alloc] init];
    self.navVc = [[UINavigationController alloc] init];
    
    self.navVc.navigationBar.barTintColor = UIColorFromRGB(0xf15e63);
    [self.navVc setViewControllers:@[self.menuController]];
    self.menuController.delegate = self;
    
    
    [self.view addSubview:self.navVc.view];
    
    //添加滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.navVc.view addGestureRecognizer:pan];
    [self.view addSubview:self.tabBarController.view];
}



/**
 *  处理拖动事件
 *
 *  @param recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // 当滑动水平X大于75时禁止滑动
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartX = [recognizer locationInView:self.view].x;
    }
    if (self.sta == kStateHome && self.panStartX <= 75) {
        return;
    }
    
    CGFloat x = [recognizer translationInView:self.view].x;
    // 禁止在主界面的时候向右滑动
    if (self.sta == kStateHome && x > 0) {
        return;
    }
    
    CGFloat dis = self.distance - x;
    // 当手势停止时执行操作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (dis >= [UIScreen mainScreen].bounds.size.width * viewSlideHorizonRatio / 2.0) {
            [self showMenu];
        } else {
            [self showHome];
        }
        return;
    }
    //
    CGFloat proportion = (viewHeightNarrowRatio - 1) * dis / self.rightDistance + 1;
    if (proportion < viewHeightNarrowRatio || proportion > 1) {
        return;
    }
    self.navVc.view.center = CGPointMake(self.view.center.x - dis, self.view.center.y);
    self.navVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    
    
    CGFloat menuProportion = dis * (1 - menuStartNarrowRatio) / self.rightDistance + menuStartNarrowRatio;
    CGFloat menuCenterMove = dis * (self.menuCenterXEnd - self.menuCenterXStart) / self.rightDistance;
    self.rightVc.view.center = CGPointMake(self.menuCenterXStart + menuCenterMove, self.view.center.y);
    self.rightVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
}



/**
 *  设置statusbar的状态
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)btnDidClick
{
    if (self.sta == kStateMenu) {
        [self showHome];
    }else{
        [self showMenu];
    }
}

/**
 *  展示侧边栏
 */
- (void)showMenu {
    self.distance = self.rightDistance;
    self.sta = kStateMenu;
    [self doSlide:viewHeightNarrowRatio];
}

/**
 *  展示主界面
 */
- (void)showHome {
    self.distance = 0;
    self.sta = kStateHome;
    [self doSlide:1];
}



/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)proportion {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.navVc.view.center = CGPointMake(self.view.center.x - self.distance, self.view.center.y);
        self.navVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        CGFloat menuCenterX;
        CGFloat menuProportion;
        if (proportion == 1) {
            menuCenterX = self.menuCenterXStart;
            menuProportion = menuStartNarrowRatio;
        } else {
            menuCenterX = self.menuCenterXEnd;
            menuProportion = 1;
        }
        self.rightVc.view.center = CGPointMake(menuCenterX, self.view.center.y);
        self.rightVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
