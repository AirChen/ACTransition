//
//  LayoutSliderAnimate.h
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ACTransitionType) {
    ACTransitionNav,
    ACTransitionTab,
    ACTransitionMod,
};

typedef NS_ENUM(NSInteger, ACTabOperateDirection) {
    ACTabOperateDirectionLeft,
    ACTabOperateDirectionRight,
};

typedef NS_ENUM(NSInteger, ACModalOperation) {
    ACModalOperationPresentation,
    ACModalOperationDismissal,
};

@interface LayoutSliderAnimate : NSObject<UIViewControllerAnimatedTransitioning>

-(instancetype)initWithTransitionType:(ACTransitionType) type andOperation:(NSInteger)operation;

@end
