//
//  TopTabView.m
//  PageViewController
//
//  Created by fhkvsou on 17/8/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "TopTabView.h"
#import "ItemCollectionViewCell.h"

#define kScreenWidth self.frame.size.width
#define kScreenHeight self.frame.size.height
#define kAnimationDuration 0.3

@interface TopTabView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic ,strong) NSArray <ItemData *>* items;

@property (nonatomic ,strong) UICollectionView * collectVc;
@property (nonatomic ,strong) UICollectionViewFlowLayout * layout;

@property (nonatomic ,assign) NSInteger selectIndex;

@property (nonatomic ,assign) float numberOfVisiableItems;

@property (nonatomic ,strong) UIView * signView;

@end

@implementation TopTabView

#pragma mark -----------------------外部调用-------------------------

- (instancetype)initWithFrame:(CGRect)frame numberOfVisiableItems:(CGFloat)numberOfVisiableItems{
    if (self = [super initWithFrame:frame]) {
        _numberOfVisiableItems = numberOfVisiableItems;
        _selectIndex = 0;
        [self createViews];
    }
    return self;
}

- (void)updateWithItems:(NSArray<ItemData *> *)items{
    self.items = items;
    
    [self.collectVc reloadData];
    [self.collectVc layoutIfNeeded];
    [self.collectVc setNeedsLayout];
    
    [self setSelectIndex:_selectIndex animation:NO];
}

- (void)setScrollEnable:(BOOL)scrollEnable{
    self.collectVc.scrollEnabled = scrollEnable;
}

- (void)setColorOfSignView:(UIColor *)colorOfSignView{
    self.signView.backgroundColor = colorOfSignView;
}

#pragma mark -----------------------私有方法-------------------------

- (void)createViews{
    [self addSubview:self.collectVc];
    [self.collectVc addSubview:self.signView];
}

- (void)setSelectIndex:(NSInteger)index animation:(BOOL)animation{
    
    NSIndexPath * deselectIndexPath = [NSIndexPath indexPathForItem:_selectIndex inSection:0];
    [self.collectVc deselectItemAtIndexPath:deselectIndexPath animated:NO];
    
    UICollectionViewCell * deselectCell = [self.collectVc cellForItemAtIndexPath:deselectIndexPath];
    ItemCollectionViewCell * deselectItem = (ItemCollectionViewCell *)deselectCell;
    [deselectItem updataSelet:NO];
    
    NSIndexPath * selectIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectVc selectItemAtIndexPath:selectIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    UICollectionViewCell * selectCell = [self.collectVc cellForItemAtIndexPath:selectIndexPath];
    ItemCollectionViewCell * selectItem = (ItemCollectionViewCell *)selectCell;
    [selectItem updataSelet:YES];
    
    [self caculateLocationOfSignView:index animation:animation];
    
    _selectIndex = index;
}

- (void)caculateLocationOfSignView:(NSInteger)index animation:(BOOL)animation{
    CGFloat width = kScreenWidth / (float)_numberOfVisiableItems;;
    if (animation) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.signView.frame = CGRectMake(index * width, 45, width, 5);
        }];
    }else{
        self.signView.frame = CGRectMake(index * width, 45, width, 5);
    }
}

- (void)changeLocationOfSignView:(CGRect)rect{
    CGFloat width = kScreenWidth / (float)_numberOfVisiableItems;;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.signView.frame = CGRectMake(rect.origin.x, 45, width, 5);
    }];
}

- (void)updataContentOffsetOfItems:(CGRect)rect{
    CGFloat width = kScreenWidth / _numberOfVisiableItems;
    CGFloat offset = self.collectVc.contentOffset.x;
    
    CGFloat distance = kScreenWidth - (rect.origin.x - offset);
    
    NSInteger currentDistance = round(distance);
    NSInteger currentWidth = round(width);
    // 待处理   误差问题
    if (currentDistance < currentWidth) {
        if (_selectIndex == self.items.count - 1) {
            [self.collectVc setContentOffset:CGPointMake(self.collectVc.contentSize.width - kScreenWidth, 0) animated:YES];
        }else{
            [self.collectVc setContentOffset:CGPointMake(offset + width, 0) animated:YES];
        }
    }else if (currentDistance == currentWidth){
        [self.collectVc setContentOffset:CGPointMake(offset + width / 2, 0) animated:YES];
    }else if (currentDistance == kScreenWidth){
        [self.collectVc setContentOffset:CGPointMake(offset - width / 2, 0) animated:YES];
    }
}

#pragma mark -----------------------UICollectionViewDelegate-------------------------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.item;
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    ItemCollectionViewCell * item = (ItemCollectionViewCell *)cell;
    [item updataSelet:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectAtIndex:)]) {
        [_delegate selectAtIndex:_selectIndex];
    }
    
    CGRect cellRect = [collectionView convertRect:cell.frame toView:_collectVc];
    [self changeLocationOfSignView:cellRect];
    [self updataContentOffsetOfItems:cellRect];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    ItemCollectionViewCell * item = (ItemCollectionViewCell *)cell;
    [item updataSelet:NO];
}

#pragma mark -----------------------UICollectionViewDataSource------------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PageItemCell" forIndexPath:indexPath];
    
    ItemData * data = [_items objectAtIndex:indexPath.item];
    [cell updateText:data];
    
    if (indexPath.row == _selectIndex) {
        [cell updataSelet:YES];
    }else{
        [cell updataSelet:NO];
    }
    return cell;
}


#pragma mark ------------------UICollectionViewDelegateFlowLayout--------------------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth / (float)_numberOfVisiableItems, kScreenHeight - 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark -------------------------------lazyLoad---------------------------------

- (UICollectionView *)collectVc{
    if (_collectVc == nil) {
        _collectVc = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:self.layout];
        _collectVc.backgroundColor = [UIColor whiteColor];
        _collectVc.showsHorizontalScrollIndicator = NO;
        _collectVc.bounces = NO;
        _collectVc.delegate = self;
        _collectVc.dataSource = self;
        [_collectVc registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"PageItemCell"];
    }
    return _collectVc;
}

- (UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(kScreenWidth / (float)_numberOfVisiableItems, kScreenHeight - 5);
        _layout.minimumLineSpacing = CGFLOAT_MIN;
        _layout.minimumInteritemSpacing = CGFLOAT_MIN;
    }
    return _layout;
}

- (NSArray<ItemData *> *)items{
    if (_items == nil) {
        _items = [[NSArray alloc]init];
    }
    return _items;
}

- (UIView *)signView{
    if (_signView == nil) {
        _signView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth / (float)_numberOfVisiableItems, 5)];
    }
    return _signView;
}

@end
