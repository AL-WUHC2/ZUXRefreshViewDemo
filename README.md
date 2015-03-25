# ZUXRefreshViewDemo

扩展EGORefreshTableHeaderView, 实现四个方向的拖拽异步刷新, 并适应UIScrollView的contentInset不为UIEdgeInsetsZero的情形.

Demo工程示范了ZUXRefreshView的两个简单应用: 下拉刷新, 上拉加载更多.

---

#####详细说明

1. ZUXRefreshView
    1. ZUXRefreshState : 指示刷新视图状态, 包含ZUXRefreshNormal正常状态, ZUXRefreshPulling下拉状态, ZUXRefreshLoading加载中状态
    2. ZUXRefreshPullDirection : 指示拖拽刷新方向
    3. ZUXRefreshViewDelegate : 刷新视图托管
    4. ZUXRefreshView : 刷新视图. 属性 : defaultPadding指示UIScrollView在拖拽方向上的默认EdgeInset, pullingMargin指示刷新视图在拖拽方向上进出待加载状态的contentOffset边界, loadingMargin指示刷新视图在加载时的contentInset在拖拽方向上的变化量. 方法 : didScrollView:在[UIScrollViewDelegate scrollViewDidScroll:]中调用, didEndDragging:在[UIScrollViewDelegate scrollViewDidEndDragging:willDecelerate:]中调用, didFinishedLoading:在异步刷新完成后调用, setRefreshState:由子类实现不同的刷新视图状态对应的不同视图效果

2. RefreshView
    下拉刷新效果的简单实现

3. LoadmoreView
    上拉加载更多的简单实现

4. ViewController
    下拉刷新与上拉加载更多合并示例, 下拉刷新视图RefreshView位于UITableView上方, 贴合其上边界, 上拉加载更多视图LoadmoreView位于UITableView下方, 贴合其下边界(MAX(contentSize.height, frame.size.height))
    
    使用GCD延迟模拟异步加载效果

---
