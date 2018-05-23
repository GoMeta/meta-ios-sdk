//
//  ViewController.m
//  MetaSDKObjC
//
//  Created by Sean Thielen on 5/19/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

#import "ViewController.h"

@import Meta;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([self view].frame.size.width / 6, ([self view].frame.size.height - 54) / 2, [self view].frame.size.width / 3 * 2, 54)];
    button.backgroundColor = [UIColor colorWithRed:0.58 green:0.46 blue:0.80 alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 4.0;
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"Present Experience" attributes: @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16]
    }];
    [button setAttributedTitle:titleString forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentExperience) forControlEvents:UIControlEventTouchUpInside];

    [[self view] addSubview:button];
}

- (void)presentExperience {
    MetaExperience *experience = [[MetaExperience alloc] initWithId:@"cff4fbc6-f489-4781-a1db-03e37069b206"];
    [[Meta shared] presentWithExperience: experience];
}

@end
