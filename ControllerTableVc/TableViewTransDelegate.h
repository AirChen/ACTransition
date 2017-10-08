//
//  TableViewTransDelegate.h
//  视图控制器转场
//
//  Created by Air_chen on 16/7/24.
//  Copyright © 2016年 Air_chen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TableViewTransDelegate : NSObject<UINavigationControllerDelegate>

@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interaction;

@end
