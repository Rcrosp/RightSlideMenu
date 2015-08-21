//
//  MenuViewController.m
//  RightSlideMenu
//
//  Created by 付付 on 15/8/21.
//  Copyright (c) 2015年 PogoShow. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray *items;
@property(nonatomic, strong)NSMutableArray *iconItems;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray arrayWithArray:@[@"清除缓存", @"意见反馈", @"关于", @"评分", @"推出"]];
//    self.iconItems = [NSMutableArray arrayWithArray:@[@[@"myCell_person",@"myCell_order",@"myCell_bandPhone",@"myCell_ofenConnection",@"myCell_acceptAddress"],@[@"myCell_timeLine",@"myCell_message",@"myCell_chat"],@[/*@"myCell_signIn",*/@"myCell_show",@"myCell_band",@"myCell_area"],@[@"myCell_black"]]];
    
    
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] init];
    
    CGRect rect  = self.view.bounds;
    
//    rect.origin.y = 64;
    rect.origin.x = rect.size.width * 0.25;
        rect.size.width = rect.size.width * 0.75;
    //    rect.size.height =  rect.size.height - 64;
    tableView.frame = rect;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor purpleColor];
    UIImageView *img = [[UIImageView alloc] init];
    img.backgroundColor = [UIColor clearColor];
    img.image = [UIImage imageNamed:@"avator"];
    NSLog(@"%@",NSStringFromCGRect(view.frame));
    
    [view addSubview:img];
    
    CGRect rect  = self.view.bounds;
    rect.size.width = rect.size.width * 0.75;
    rect.origin.x = (rect.size.width * 0.75 - 80) * 0.5;
    rect.origin.y =  100;
    rect.size.width = 80;
    rect.size.height = 80;
    img.frame = rect;
//    img.center = view.center;
    return view;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *myId  =  @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myId];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
        cell.layer.borderWidth = 0.5;
        cell.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
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
