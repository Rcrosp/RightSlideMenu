//
//  HomeViewController.h
//  RightSlideMenu
//
//  Created by 付付 on 15/8/21.
//  Copyright (c) 2015年 PogoShow. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol homeViewControllerDelegate<NSObject>

-(void)btnDidClick;

@end
@interface HomeViewController : UIViewController

@property(nonatomic, weak)id<homeViewControllerDelegate> delegate;

@end
