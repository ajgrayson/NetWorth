//
//  NWHomePageContentViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWOverviewPageContentViewController.h"
#import "NWHelper.h"

@interface NWOverviewPageContentViewController ()

@end

@implementation NWOverviewPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navItem.rightBarButtonItem.title = @"Edit";
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [self.titleLabel setText:[[self.account objectForKey:@"name"] uppercaseString]];
    
    [NWHelper getTotalsForInAccount:self.account withBlock:^(NSNumber *totalAssets, NSNumber *totalLiabilities) {
        NSNumber *netWorth = [[NSNumber alloc] initWithFloat:([totalAssets floatValue]  - [totalLiabilities floatValue])];
        
        [self.netWorthTotalLabel setText:[NWHelper formatNumberAsMoney:netWorth]];
        [self.assetTotalsLabel setText: [NWHelper formatNumberAsMoney:totalAssets]];
        [self.liabilitiesTotalLabel setText: [NWHelper formatNumberAsMoney:totalLiabilities]];
    }];
}

@end
