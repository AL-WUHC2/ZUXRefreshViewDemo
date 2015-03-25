//
//  ViewController.m
//  ZUXRefreshViewDemo
//
//  Created by Char Aznable on 15-3-25.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ViewController.h"
#import "RefreshView.h"
#import "LoadmoreView.h"
#import "Constant.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ZUXRefreshViewDelegate> {
    UITableView *_tableView;
    RefreshView *_refreshView;
    LoadmoreView *_loadmoreView;
    
    NSArray *_dataArray;
    BOOL _loading;
}

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        _tableView = [[[UITableView alloc] init] autorelease];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        
        _refreshView = [[RefreshView alloc] init];
        _refreshView.loadingMargin = refreshMargin;
        _refreshView.pullingMargin = refreshMargin+10;
        _refreshView.delegate = self;
        [_tableView addSubview:_refreshView];
        
        _loadmoreView = [[LoadmoreView alloc] init];
        _loadmoreView.loadingMargin = loadmoreMargin;
        _loadmoreView.pullingMargin = loadmoreMargin+5;
        _loadmoreView.delegate = self;
        [_tableView addSubview:_loadmoreView];
        
        _dataArray = [@[@"噫吁嚱", @"危乎高哉", @"蜀道之难", @"难于上青天", @"蚕丛及鱼凫", @"开国何茫然", @"尔来四万八千岁", @"不与秦塞通人烟", @"西当太白有鸟道", @"可以横绝峨眉巅", @"地崩山摧壮士死", @"然后天梯石栈相钩连", @"上有六龙回日之高标", @"下有冲波逆折之回川", @"黄鹤之飞尚不得过", @"猿猱欲度愁攀援", @"青泥何盘盘", @"百步九折萦岩峦", @"扪参历井仰胁息", @"以手抚膺坐长叹"] retain];
        _loading = NO;
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, statusBarHeight, self.view.frame.size.width, self.view.frame.size.height-statusBarHeight);
    _refreshView.frame = CGRectMake(0, -refreshHeight, _tableView.frame.size.width, refreshHeight);
    _loadmoreView.frame = CGRectMake(0, MAX(_tableView.contentSize.height, _tableView.frame.size.height),
                                     _tableView.frame.size.width, loadmoreHeight);
    
}

- (void)dealloc {
    [_tableView release];
    [_refreshView release];
    [_loadmoreView release];
    [_dataArray release];
    [super dealloc];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"ViewControllerTableCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshView didScrollView:scrollView];
    [_loadmoreView didScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_refreshView didEndDragging:scrollView];
    [_loadmoreView didEndDragging:scrollView];
}

#pragma mark - ZUXRefreshViewDelegate

- (BOOL)refreshViewIsLoading:(ZUXRefreshView *)view {
    return _loading;
}

- (void)refreshViewStartLoad:(ZUXRefreshView *)view {
    _loading = YES;
    // 延迟模拟异步加载
    if ([view isKindOfClass:RefreshView.class]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           _loading = NO;
                           [_tableView reloadData];
                           [_refreshView didFinishedLoading:_tableView];
                       });
    } else if ([view isKindOfClass:LoadmoreView.class]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           _loading = NO;
                           [_tableView reloadData];
                           [_loadmoreView didFinishedLoading:_tableView];
                       });
    }
}

@end
