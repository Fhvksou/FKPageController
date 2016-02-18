//
//  PageViewController.m
//  PageViewController
//
//  Created by fhkvsou on 16/2/18.
//  Copyright © 2016年 fhkvsou. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()<UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    NSInteger _curPage;
    
}
@property (nonatomic, strong) UIPageViewController * pageView;
@property (nonatomic, strong) UIView * buttonView;
@property (nonatomic, strong) UIScrollView * topScr;
@property (nonatomic, strong) NSMutableArray * vcArr;
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) UIView * backgroundView;


@end

@implementation PageViewController


- (id)initWithTitleArray:(NSArray *)titleArr andVcArray:(NSArray *)VcArray{//titleArr.count must equal VcArray.count
    if (self.vcArr.count>5) {
        NSLog(@"超过上限");
    }else{
        if (self = [super init]) {
            self.titleArr = titleArr;
            [self.vcArr addObjectsFromArray:VcArray];
        }
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI{
    
    [self.view addSubview:self.pageView.view];
    [self.view addSubview:self.topScr];
    [self.topScr addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.buttonView];
    
    for (int i = 0 ; i<self.titleArr.count ; i++) {
        if (self.vcArr.count > 4) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(ScreenWidth+40)/self.vcArr.count, 0,( ScreenWidth+40)/self.vcArr.count, 45)];
            if ( i == 0 ) {
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
            btn.tag = 200+i;
            [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
            [self.backgroundView addSubview:btn];
        }else{
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/self.vcArr.count, 0,ScreenWidth/self.vcArr.count, 45)];
            if ( i == 0 ) {
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
            btn.tag = 200+i;
            [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
            [self.backgroundView addSubview:btn];
        }
    }
    
    self.topScr.contentSize = self.backgroundView.frame.size;
    _buttonView.backgroundColor = [UIColor orangeColor];
}


- (void)change:(UIButton *)btn{
    
    for (int i = 200; i < 200+self.vcArr.count; i++) {
        [self changeButtonColor:i andColor:[UIColor blackColor]];
    }
    NSInteger toPage = btn.tag - 200;
    
    [_pageView setViewControllers:@[_vcArr[toPage]] direction:toPage<_curPage animated:YES completion:^(BOOL finished) {
        if (finished) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _curPage = toPage;
        }
    }];
}

//按钮颜色设置黑色
- (void)changeButtonColor:(NSInteger)tag andColor:(UIColor *)color{
    UIButton * btn = (UIButton *)[self.view viewWithTag:tag];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


#pragma mark UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_vcArr indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return _vcArr[index-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_vcArr indexOfObject:viewController];
    if (index == self.vcArr.count - 1) {
        return nil;
    }
    return _vcArr[index+1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        _curPage = [self.vcArr indexOfObject:pageViewController.viewControllers[0]];
    }
}

#pragma mark- scorlViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.topScr) {
        if (self.vcArr.count > 4) {
            CGFloat width = scrollView.frame.size.width;
            CGFloat ratio = ( ScreenWidth + 40 ) / self.vcArr.count / width;
            CGFloat offsetX = scrollView.contentOffset.x;
            CGFloat offsetXIndicator = ratio * offsetX + (_curPage - 1) * (ScreenWidth + 40) / self.vcArr.count;
            self.buttonView.frame = CGRectMake(offsetXIndicator, 45, (ScreenWidth + 40) / self.vcArr.count, 5);

            if (_curPage >= 3) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.topScr.contentOffset = CGPointMake(40, 0);
                }];
            }
            if (_curPage == 2) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.topScr.contentOffset = CGPointMake(20, 0);
                }];
            }
            if (_curPage <= 1) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.topScr.contentOffset = CGPointMake(0, 0);
                }];
            }
        }else{
            CGFloat width = scrollView.frame.size.width;
            CGFloat ratio = ScreenWidth  / self.vcArr.count / width;
            CGFloat offsetX = scrollView.contentOffset.x;
            CGFloat offsetXIndicator = ratio * offsetX + (_curPage - 1) * ScreenWidth  / self.vcArr.count;
            self.buttonView.frame = CGRectMake(offsetXIndicator, 45, ScreenWidth / self.vcArr.count, 5);
        }
    }
}
//dasdadad

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (int i = 200; i < 200+self.vcArr.count; i++) {
        [self changeButtonColor:i andColor:[UIColor blackColor]];
    }
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:200+_curPage];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
}

#pragma mark 懒加载

- (UIScrollView *)topScr{
    if (_topScr == nil) {
        _topScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 50)];
        _topScr.showsHorizontalScrollIndicator = NO;
    }
    return _topScr;
}


- (UIView *)buttonView{
    if (_buttonView == nil) {
        if (self.vcArr.count <= 4) {
            _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth/self.vcArr.count, 5)];
        }else{
            _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, (ScreenWidth+40)/5, 5)];
    
        }
    }
    return _buttonView;
}


- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        if (self.vcArr.count <= 4) {
            _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        }else{
            _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth+40, 50)];
    
        }
    }
    return _backgroundView;
}


- (UIPageViewController *)pageView{
    if (_pageView == nil) {
        _pageView = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:0 options:nil];
        [_pageView setViewControllers:@[self.vcArr[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        _pageView.delegate = self;
        _pageView.dataSource = self;
        _pageView.view.frame = CGRectMake(0, 64+50, ScreenWidth, ScreenHeigjt-64-50);
        for (UIView * view in _pageView.view.subviews) {
            [view setValue:self forKey:@"delegate"];
        }
    }
    return _pageView;
}


- (NSMutableArray *)vcArr{
    if (_vcArr == nil) {
        _vcArr = [[NSMutableArray alloc]init];
    }
    return _vcArr;
}


- (NSArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [[NSArray alloc]init];
    }
    return _titleArr;
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
