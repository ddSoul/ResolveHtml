//
//  ViewController.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "ViewController.h"
#import "RHViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configeUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configeUI
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    [button addTarget:self
               action:@selector(click)
     forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)click
{
    RHViewController *rhVc = [[RHViewController alloc] init];
    [self.navigationController pushViewController:rhVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
