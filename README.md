### demo运行效果如下:    
<img src="https://github.com/ONECATYU/WSScrollAnimationTransition/blob/master/DemoRun.gif"/><br>
### 使用
使用WSScrollTransitionDelegate类,重写init和setViewControllers方法,就能实现左右滑动交互转场.
```objective-c
- (instancetype)init
{
    if (self = [super init]) {
        ///初始化方法中构建实例
        _transitionDelegate = [[WSScrollTransitionDelegate alloc]init];
        _transitionDelegate.tabBarController = self;
    }
    return self;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    [super setViewControllers:viewControllers];
    ///将viewControllers数组传给动画控制器
    ///动画控制需要根据viewControllers中fromVC/toVC的index来确定是向左滑还是向右滑(向下还是向上)
    _transitionDelegate.scrollAnimation.viewCtrollers = viewControllers;
}   
```
上拉下拉转场时需要注意:<br>
1.先要将动画控制器的scrollDirection设置为WSAnimationScrollDirectionVertical.<br>
2.再设置tabBarController的selectedIndex
