//
//  NWPageContentViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccountPageContentViewController.h"
#import "NWHelper.h"
#import "NWConstants.h"

@interface NWAccountPageContentViewController ()

@end

@implementation NWAccountPageContentViewController

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
    PFObject *user = (PFObject *)[self user];
    [user fetchIfNeeded];
    [self.label setText:[[user objectForKey:@"username"] uppercaseString]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navItem.rightBarButtonItem.title = @"Manage";
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [NWHelper getTotalsForInAccount:self.account forUser:self.user withBlock:^(NSNumber *totalAssets, NSNumber *totalLiabilities) {
        NSNumber *netWorth = [[NSNumber alloc] initWithFloat:([totalAssets floatValue]  - [totalLiabilities floatValue])];
        
        [self.netWorthTotalLabel setText:[NWHelper formatNumberAsMoney:netWorth]];
        [self.assetTotalLabel setText: [NWHelper formatNumberAsMoney:totalAssets]];
        [self.liabilitiesTotalLabel setText: [NWHelper formatNumberAsMoney:totalLiabilities]];
    }];
}



@end
