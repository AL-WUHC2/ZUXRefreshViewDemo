//
//  RefreshView.m
//  ZUXRefreshViewDemo
//
//  Created by Char Aznable on 15-3-25.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "RefreshView.h"
#import "Constant.h"

#define topBlank        88.f*DeviceScale
#define indicatorBounds CGRectMake(0, 0, 15.f, 15.f)
#define commentBounds   CGRectMake(0, 0, 80.f, 20.f)

@interface RefreshView () {
    UIImageView *_arrow;
    UIImageView *_loading;
    CABasicAnimation *_loadingAnimation;
    
    UIImageView *_comment;
    UIImage *_commentNormal;
    UIImage *_commentPulling;
    UIImage *_commentLoading;
}

@end

@implementation RefreshView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self zuxInitial];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self zuxInitial];
    return self;
}

- (void)zuxInitial {
    [super zuxInitial];
    
    _arrow = [[UIImageView alloc] init];
    _arrow.image = [UIImage imageNamed:@"RefreshArrow"];
    _arrow.bounds = indicatorBounds;
    [self addSubview:_arrow];
    
    _loading = [[UIImageView alloc] init];
    _loading.image = [UIImage imageNamed:@"RefreshLoading"];
    _loading.bounds = indicatorBounds;
    _loading.layer.hidden = YES;
    [self addSubview:_loading];
    
    _loadingAnimation = [[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"] retain];
    _loadingAnimation.duration = 0.5;
    _loadingAnimation.repeatCount = HUGE_VALF;
    _loadingAnimation.fromValue = [NSNumber numberWithFloat:0.];
    _loadingAnimation.toValue = [NSNumber numberWithFloat:-2.*M_PI];
    _loadingAnimation.delegate = self;
    
    _commentNormal = [[UIImage imageNamed:@"RefreshCommentNormal"] retain];
    _commentPulling = [[UIImage imageNamed:@"RefreshCommentPulling"] retain];
    _commentLoading = [[UIImage imageNamed:@"RefreshCommentLoading"] retain];
    
    _comment = [[UIImageView alloc] init];
    _comment.image = _commentNormal;
    _comment.bounds = commentBounds;
    [self addSubview:_comment];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    
    _arrow.frame = CGRectMake((width-indicatorBounds.size.width-commentBounds.size.width)/2.,
                              (height-topBlank-indicatorBounds.size.height)/2.+topBlank,
                              indicatorBounds.size.width, indicatorBounds.size.height);
    _loading.frame = CGRectMake((width-indicatorBounds.size.width-commentBounds.size.width)/2.,
                                (height-topBlank-indicatorBounds.size.height)/2.+topBlank,
                                indicatorBounds.size.width, indicatorBounds.size.height);
    _comment.frame = CGRectMake((width-indicatorBounds.size.width-commentBounds.size.width)/2.+indicatorBounds.size.width,
                                (height-topBlank-commentBounds.size.height)/2.+topBlank,
                                commentBounds.size.width, commentBounds.size.height);
}

- (void)setRefreshState:(ZUXRefreshState)state {
    switch (state) {
        case ZUXRefreshNormal:
            _comment.image = _commentNormal;
            
            [UIView beginAnimations:NULL context:NULL];
            [CATransaction setAnimationDuration:0.2];
            if (self.state == ZUXRefreshPulling) {
                _arrow.layer.transform = CATransform3DIdentity;
            }
            _loading.layer.hidden = YES;
            [_loading.layer removeAnimationForKey:@"LoadingAnimation"];
            _arrow.layer.hidden = NO;
            _arrow.layer.transform = CATransform3DIdentity;
            [UIView commitAnimations];
            break;
            
        case ZUXRefreshPulling:
            _comment.image = _commentPulling;
            
            [UIView beginAnimations:NULL context:NULL];
            [CATransaction setAnimationDuration:0.2];
            _loading.layer.hidden = YES;
            [_loading.layer removeAnimationForKey:@"LoadingAnimation"];
            _arrow.layer.hidden = NO;
            _arrow.layer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [UIView commitAnimations];
            break;
            
        case ZUXRefreshLoading:
            _comment.image = _commentLoading;
            
            [UIView beginAnimations:NULL context:NULL];
            [CATransaction setAnimationDuration:0.2];
            _loading.layer.hidden = NO;
            [_loading.layer addAnimation:_loadingAnimation forKey:@"LoadingAnimation"];
            _arrow.layer.hidden = YES;
            _arrow.layer.transform = CATransform3DIdentity;
            [UIView commitAnimations];
            break;
            
        default:
            break;
    }
}

- (void)dealloc {
    [_arrow release];
    [_loading release];
    [_loadingAnimation release];
    
    [_comment release];
    [_commentNormal release];
    [_commentPulling release];
    [_commentLoading release];
    [super dealloc];
}

@end
