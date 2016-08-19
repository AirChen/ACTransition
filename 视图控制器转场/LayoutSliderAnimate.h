//
//  LayoutSliderAnimate.h
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SDETransitionType) {
    NavigationTransition,
    TabTransition,
    ModalTransition,
};

typedef NS_ENUM(NSInteger, TabOperationDirection) {
    Left, Right,
};

typedef NS_ENUM(NSInteger, ModalOperation) {
    Presentation, Dismissal,
};

@interface LayoutSliderAnimate : NSObject<UIViewControllerAnimatedTransitioning>

-(instancetype)initWithTransitionType:(SDETransitionType) type andOperation:(NSInteger)operation;

@end
