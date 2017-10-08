//
//  BottomViewController.m
//  视图控制器转场
//
//  Created by Air_chen on 16/7/26.
//  Copyright © 2016年 Air_chen. All rights reserved.
//

#import "BottomViewController.h"

@interface BottomViewController ()

@end

@implementation BottomViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Bottom Appear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Bottom DidLoad");
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"Bottom DisAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    [super prepareForSegue:segue sender:sender];
//    
//    NSLog(@"model");
//}


@end
