//
//  ViewController.m
//  Demo
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cpuUsageLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self fib];
        });
    }];
}

- (void)fib
{
    int minStartingValue = 1;
    int maxStartingValue = 40;
    int r = minStartingValue + arc4random_uniform(maxStartingValue - minStartingValue);
    [self fibonacciOfNumber:r];
}

- (int)fibonacciOfNumber: (int)number
{
    if (number <= 0) {
        return 1;
    } else if (number == 1) {
        return 1;
    } else {
        return [self fibonacciOfNumber:(number - 1)] + [self fibonacciOfNumber:(number - 2)];
    }
}

@end
