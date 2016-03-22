//
//  MainViewController.m
//  Views侧滑
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+Extension.h"
#import "NavigationViewController.h"
#import "NewViewController.h"



@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NavigationViewController *showingNavigation;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    NewViewController *newVC = [[NewViewController alloc] init];
/*
    newVC.view.backgroundColor = [UIColor redColor];
    newVC.navigationItem.title = @"POP";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStyleDone target:self action:@selector(leftMenu)];
    newVC.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.leftBarButtonItem = leftBarButtonItem;
    NavigationViewController *newNavi = [[NavigationViewController alloc] initWithRootViewController:newVC];
    self.showingNavigation = newNavi;
    [self.view addSubview:newNavi.view];
    [self addChildViewController:newNavi];
*/
    [self setUp:newVC color:[UIColor redColor] title:@"POP"];

    
    UIViewController *secondVC = [[UIViewController alloc] init];
    [self setUp:secondVC color:[UIColor blueColor] title:@"Second"];
    
    UIViewController *thirdVC = [[UIViewController alloc] init];
    [self setUp:thirdVC color:[UIColor yellowColor] title:@"Third"];
    
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.x = 0;
    tableView.y = 0;
    tableView.width = self.view.bounds.size.width - 100;
    tableView.height = 600;
    tableView.backgroundColor = [UIColor clearColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 100, 200)];
    tableView.tableHeaderView = headerView;
    
    self.tableView = tableView;
    [self.tableView reloadData];
    //设置默认选中的是第一行，然后调用didSelectRowAtIndexPath方法
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:firstIndexPath];
    }
    [self.view insertSubview:tableView atIndex:1];
}
- (void)setUp:(UIViewController *)vc color:(UIColor *)color title:(NSString *)title{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStyleDone target:self action:@selector(leftMenu)];
    vc.navigationItem.leftBarButtonItem = leftBarButtonItem;
    vc.view.backgroundColor = color;
    vc.navigationItem.title = title;
    
    NavigationViewController *newNavi = [[NavigationViewController alloc] initWithRootViewController:vc];
//   self.showingNavigation = newNavi;
    [self addChildViewController:newNavi];
}
//修改状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
//点击按钮时调用
- (void)leftMenu {
/******************实现平移的第一种方法********************/
    
//    [UIView animateWithDuration:0.5 animations:^{
//        if (CGAffineTransformIsIdentity(self.showingNavigation.view.transform)) {
//            UIView *showView = self.showingNavigation.view;
//            CGAffineTransform transform = CGAffineTransformMakeTranslation(290, 0);
//            showView.transform = transform;
//        }else {
//            self.showingNavigation.view.transform = CGAffineTransformIdentity;
//        }
//        }];
    
/********************实现平移的第二种方法*******************/

    [UIView animateWithDuration:0.5 animations:^{
        UIView *showView = self.showingNavigation.view;
        CGAffineTransform transform = CGAffineTransformMakeTranslation(290, 0);
        showView.transform = transform;
        
        //        CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
        //        CGAffineTransform translateForm = CGAffineTransformTranslate(transform, 290, 0);
        //        showView.transform = translateForm;
        
        
//        self.leftBarButtonItem.image = nil;
        UIButton *coverButton = [[UIButton alloc] init];
        [coverButton addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        coverButton.frame = showView.bounds;
        [showView addSubview:coverButton];
    }];
    //平移加动画效果用    CABasicAnimation

}

- (void)coverClick:(UIButton*)cover {
    [UIView animateWithDuration:0.7 animations:^{
        self.showingNavigation.view.transform = CGAffineTransformIdentity;
//        self.leftBarButtonItem.image = [UIImage imageNamed:@"top_navigation_menuicon"];
    }completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"haha";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"5656"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NavigationViewController *oldNavi = self.showingNavigation;
    [oldNavi.view removeFromSuperview];
    NavigationViewController *newNavi = self.childViewControllers[indexPath.row];
    
    newNavi.view.transform = oldNavi.view.transform;
    [self.view addSubview:newNavi.view];
    self.showingNavigation = newNavi;
//    self.leftBarButtonItem.image = [UIImage imageNamed:@"top_navigation_menuicon"];
    [UIView animateWithDuration:0.5 animations:^{
        newNavi.view.transform = CGAffineTransformIdentity;
    }];
    
}
@end
