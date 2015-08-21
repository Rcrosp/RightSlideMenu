//
//  HomeViewController.m
//  RightSlideMenu
//
//  Created by 付付 on 15/8/21.
//  Copyright (c) 2015年 PogoShow. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = [self setupBarItem];
}


/**
 *  添加返回
 */
- (NSArray *) setupBarItem{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
    [backButton setImage:[UIImage imageNamed:@"item_setup_icon"] forState:UIControlStateNormal];
    //    [backButton setTitle:@"设置" forState:UIControlStateNormal];
    backButton.titleLabel.textColor = [UIColor blackColor];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [backButton addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNagativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    leftNagativeSpacer.width = -20;
    
    return @[leftNagativeSpacer,leftBarItem];
}


-(void)backItemAction:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(btnDidClick)]) {
        
        [self.delegate btnDidClick];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
