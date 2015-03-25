//
//  ZUXRefreshView.h
//  msgo
//
//  Created by Char Aznable on 15-1-3.
//  Copyright (c) 2015年 com.ai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZUXRefreshState) {
    ZUXRefreshNormal,
    ZUXRefreshPulling,
    ZUXRefreshLoading
};

typedef NS_ENUM(NSInteger, ZUXRefreshPullDirection) {
    ZUXRefreshPullDown,
    ZUXRefreshPullUp,
    ZUXRefreshPullRight,
    ZUXRefreshPullLeft
};

@class ZUXRefreshView;

// Delegate
@protocol ZUXRefreshViewDelegate <NSObject>

@optional

- (BOOL)refreshViewIsLoading:(ZUXRefreshView *)view;

- (void)refreshViewStartLoad:(ZUXRefreshView *)view;

@end

// ZUXRefreshView
@interface ZUXRefreshView : UIView

@property (assign, nonatomic) id<ZUXRefreshViewDelegate> delegate;

@property (assign, nonatomic) ZUXRefreshState state;

@property (assign, nonatomic) ZUXRefreshPullDirection direction;

@property (assign, nonatomic) CGFloat defaultPadding;

@property (assign, nonatomic) CGFloat pullingMargin;

@property (assign, nonatomic) CGFloat loadingMargin;

- (void)zuxInitial;

- (void)didScrollView:(UIScrollView *)scrollView;

- (void)didEndDragging:(UIScrollView *)scrollView;

- (void)didFinishedLoading:(UIScrollView *)scrollView;

- (void)setRefreshState:(ZUXRefreshState)state;

@end
