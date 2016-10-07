# ACTransition
原生态的iOS转场动画，有基于交互和基于非交互两种类型，方便进行需要转场效果的开发。
详情可以参考我的博客：http://blog.sina.com.cn/s/blog_bfb0501f0102w8he.html

学习了seedante大神的《iOS 视图控制器转场详解》https://github.com/seedante/iOS-Note/wiki/ViewController-Transition
觉得iOS的自定义转场功能十分强大，可以实现许多绚丽的动画效果。seedante大神的博客中代码是用的Swift语言编写的，此文中介绍的侧滑效果用ObjectiveC实现，关键性的地方有参考该文章。

在学习转场之前首先要理清楚转场中的一些关键词：

1.转场代理(Transition Delegate)：自定义转场的第一步便是提供转场代理，告诉系统使用我们提供的代理而不是系统的默认代理来执行转场。有如下三种转场代理，对应上面三种类型的转场：
UINavigationControllerDelegate //UINavigationController 的 delegate 属性遵守该协议。
UITabBarControllerDelegate //UITabBarController 的 delegate 属性遵守该协议。
UIViewControllerTransitioningDelegate //UIViewController 的 transitioningDelegate 属性遵守该协议。
这里除了UIViewControllerTransitioningDelegate是 iOS 7 新增的协议，其他两种在 iOS 2 里就存在了，在 iOS 7 时扩充了这两种协议来支持自定义转场。转场发生时，UIKit 将要求转场代理将提供转场动画的核心构件：动画控制器和交互控制器(可选的)；由我们实现。

2.动画控制器(Animation Controller)：最重要的部分，负责添加视图以及执行动画；遵守UIViewControllerAnimatedTransitioning协议；由我们实现。

3.交互控制器(Interaction Controller)：通过交互手段，通常是手势来驱动动画控制器实现的动画，使得用户能够控制整个过程；遵守UIViewControllerInteractiveTransitioning协议；系统已经打包好现成的类供我们使用。

4.转场环境(Transition Context):提供转场中需要的数据；遵守UIViewControllerContextTransitioning协议；由 UIKit 在转场开始前生成并提供给我们提交的动画控制器和交互控制器使用。

5.转场协调器(Transition Coordinator)：可在转场动画发生的同时并行执行其他的动画，其作用与其说协调不如说辅助，主要在 Modal 转场和交互转场取消时使用，其他时候很少用到；遵守UIViewControllerTransitionCoordinator协议；由 UIKit 在转场时生成，UIViewController 在 iOS 7 中新增了方法transitionCoordinator()返回一个遵守该协议的对象，且该方法只在该控制器处于转场过程中才返回一个此类对象，不参与转场时返回 nil。

相较于一般的非交互转场，交互转场在UIViewControllerTransitioningDelegate协议里面多实现了一下两个方法：

- (nullable id )interactionControllerForPresentation:(id )animator;
-(nullable id )interactionControllerForDismissal:(id )animator;

用来返回一个UIViewControllerInteractiveTransitioning交互控制器，该类可以控制转场过程的进度，在使用中，只需返回一个UIPercentDrivenInteractiveTransition对象即可。该对象通过以下几个方法来控制转场过程的进度：

- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
-(void)finishInteractiveTransition;

调用第一个成员方法需要给它一个进度的参数，告诉代理此转场应该进度一个多少，一般可以将此函数加入到手势里面调用。后面两个方法，可以直接调用，完成的结果和非交互的转场效果一样。

以下是在UIScreenEdgePanGestureRecognizer手势里面调用：

    -(void)handleAction:(UIScreenEdgePanGestureRecognizer *)gesture

    {

      CGFloat translationX = [gesture translationInView:_bottomVc.view].x;

      CGFloat translationBase = _bottomVc.view.frame.size.width;

      CGFloat translationAbs = translationX > 0 ? translationX : -translationX;

      CGFloat percent = translationAbs > translationBase ? 1.0:translationAbs/translationBase;

      if (gesture.state == UIGestureRecognizerStateBegan) {

          [_bottomVc presentViewController:self.navigation animated:YES completion:nil];

      }

    if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.interaction updateInteractiveTransition:percent];

    }

    if (gesture.state == UIGestureRecognizerStateEnded) {

        if (percent > 0.5) {

            [self.interaction finishInteractiveTransition];

        }        else

            [self.interaction cancelInteractiveTransition];

        NSLog(@"%@",_bottomVc.view);

      }

    }

转场的代理设置如下：

    _navigation.modalPresentationStyle = UIModalPresentationCustom;

    _navigation.transitioningDelegate = self;

在使用UIModalPresentationCustom模式进行转场的时候有一个注意点，就是在UIViewControllerAnimatedTransitioning动画控制器中实现代理方法​- (void)animateTransition:(id )transitionContext;时，当用UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];来获得fromView，在转场进入的时候，会为空。所以要使用[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];在返回控制器的View。（注意，在转场出现和转场退出的时候，fromView和toVc是互换的，但是在转场退出时，fromView还是会为空）。

我们可以在类中设置一个成员变量来保持上下文UIViewControllerContextTransitioning，在

    -(void)animationEnded:(BOOL)transitionCompleted

    {

    NSLog(@"toView %@",[_context viewForKey:UITransitionContextToViewKey]);

    NSLog(@"fromView %@",[_context viewForKey:UITransitionContextFromViewKey]);

    NSLog(@"toVc %@",[_context viewControllerForKey:UITransitionContextToViewControllerKey]);

    NSLog(@"fromVc %@",[_context viewControllerForKey:UITransitionContextFromViewControllerKey]);

    NSLog(@"toView--vc %@",[_context viewControllerForKey:UITransitionContextToViewControllerKey].view);

    NSLog(@"fromView--vc %@",[_context viewControllerForKey:UITransitionContextFromViewControllerKey].view);

    }

可以看不同调用方式的情况。

在转场完成和转场退出后，之前的presentedView会丢失，为了在侧滑时可用同时显示两个界面，在转场动画中应该设置一个静态的UIView用来保存presentingView的父视图，在[toVc isBeingPresented]的条件下，我们进行一个保存presentingView = fromView.superview;然后在动画完成时添加[presentingView addSubview:fromView];，在[fromVc isBeingDismissed]的条件下，动画完成时应该这样添加

    BOOL isCancel = [transitionContext transitionWasCancelled];

    if (!isCancel) {

       [presentingView addSubview:toView];

       [fromView removeFromSuperview]; 
    }

一套模仿QQ的UI：https://github.com/AirChen/UITest
