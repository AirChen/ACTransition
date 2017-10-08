//
//  NaviTransAnimate.h
//  视图控制器转场
//
//  Created by Air_chen on 16/7/25.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol  NaviTransAnimateDelegate<NSObject>

-(void)echoViewStatus:(UIView *)view;

@end

@interface NaviTransAnimate : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,strong) id<NaviTransAnimateDelegate> deleg;
@end
