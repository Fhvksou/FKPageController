//
//  PageViewController.m
//  PageViewController
//
//  Created by fhkvsou on 16/2/18.
//  Copyright © 2016年 fhkvsou. All rights reserved.
//

#import "PageViewController.h"
#import "ItemCollectionViewCell.h"
#import "TopTabView.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeigjt self.view.bounds.size.height

@interface PageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,TopTabDelegate,UIScrollViewDelegate>
{
    NSInteger _currentPage;
    
}
@property (nonatomic ,strong) UIPageViewController * pageView;
@property (nonatomic ,strong) NSArray <PageItem *>* items;
@property (nonatomic ,strong) TopTabView * topView;

@end

@implementation PageViewController

- (instancetype)initWithItems:(NSArray <PageItem *> *)items{
    if (self = [super init]) {
        self.items = items;
        _currentPage = 0;
        _numberOfVisiableItems = 3.5;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)setColorOfSignView:(UIColor *)colorOfSignView{
    self.topView.colorOfSignView = colorOfSignView;
}

- (void)createViews{
    [self.view addSubview:self.topView];
    
    [self.topView updateWithItems:self.items];
    
    PageItem * defaultItem = [_items objectAtIndex:0];
    
    [self.pageView setViewControllers:@[defaultItem.controller] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageView];
    [self.view addSubview:self.pageView.view];
    
    for (UIView * view in self.pageView.view.subviews) {
        [view setValue:self forKey:@"delegate"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
}

#pragma mark UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self currentNum:viewController];
    if (index == 0) {
        return nil;
    }
    
    PageItem * defaultItem = [_items objectAtIndex:index - 1];
    return defaultItem.controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self currentNum:viewController];
    if (index == self.items.count - 1) {
        return nil;
    }
    
    PageItem * defaultItem = [_items objectAtIndex:index + 1];
    return defaultItem.controller;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        _currentPage = [self currentNum:pageViewController.viewControllers[0]];
        [self.topView setSelectIndex:_currentPage animation:YES];
    }
}

- (NSInteger)currentNum:(UIViewController *)controller{
    NSInteger i = 0;
    for (PageItem * item in self.items) {
        if (item.controller == controller) {
            return i;
        }
        i++;
    }
    return 0;
}

#pragma mark -------------------------------TopTabDelegate---------------------------------

- (void)selectAtIndex:(NSInteger)index{
    PageItem * defaultItem = [_items objectAtIndex:index];
    [self.pageView setViewControllers:@[defaultItem.controller] direction:index < _currentPage animated:YES completion:nil];
    _currentPage = index;
}

#pragma mark -------------------------------lazyLoad---------------------------------

- (NSArray<PageItem *> *)items{
    if (_items == nil) {
        _items = [[NSArray alloc]init];
    }
    return _items;
}

- (UIPageViewController *)pageView{
    if (_pageView == nil) {
        _pageView = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:0 options:nil];
        _pageView.delegate = self;
        _pageView.dataSource = self;
        _pageView.view.frame = CGRectMake(0, 64 + 50, ScreenWidth, ScreenHeigjt - 64 - 50);
    }
    return _pageView;
}

- (TopTabView *)topView{
    if (!_topView) {
        _topView = [[TopTabView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 50) numberOfVisiableItems:_numberOfVisiableItems];
        _topView.delegate = self;
    }
    return _topView;
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
