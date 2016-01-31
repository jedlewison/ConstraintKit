//
//  TestViewController.m
//  ConstraintKit
//
//  Created by Jed Lewison on 1/27/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

#import "TestViewController.h"
#import "ConstraintKitHost-Swift.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view clk_edgesAnchor];
    [[self.view.leftAnchor constraintEqualToAnchor:self.view.rightAnchor] clk_activate];

    [[self.view.clk_edgesAnchor constraintsEqualToLayoutGuide:self.view.layoutMarginsGuide] activate];


    UIView *newView = [[UIView alloc] init];

    UIEdgeInsets insets = UIEdgeInsetsZero;

    [[[newView clk_edgesAnchor] constraintsEqualToViewController:self] withConstant:insets priority:UILayoutPriorityRequired];


    [[[self.view clk_edgesAnchor] constraintsEqualToViewController:self] withConstant:UIEdgeInsetsZero priority:UILayoutPriorityRequired];



    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
