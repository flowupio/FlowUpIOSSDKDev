//
//  ViewController.m
//  Demo
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (readwrite, nonatomic) NSMutableArray *memoryThings;
@property (weak, nonatomic) IBOutlet UILabel *cpuUsageLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.memoryThings = [[NSMutableArray alloc] init];
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

    NSLog(@"Storing %d values", r * 1000);
    for (int i = 0; i < r * 1000; i++) {
        [self.memoryThings addObject:[[NSObject alloc] init]];
    }

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
