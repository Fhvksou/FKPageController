//
//  TopTabView.h
//  PageViewController
//
//  Created by fhkvsou on 17/8/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageItem.h"

@protocol TopTabDelegate <NSObject>

- (void)selectAtIndex:(NSInteger)index;

@end

@interface TopTabView : UIView

@property (nonatomic ,strong) UIColor * colorOfSignView;

@property (nonatomic ,assign) BOOL scrollEnable;

@property (nonatomic ,weak) id<TopTabDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfVisiableItems:(CGFloat)numberOfVisiableItems;

- (void)setSelectIndex:(NSInteger)index animation:(BOOL)animation;

- (void)updateWithItems:(NSArray <PageItem *>*)items;

@end
