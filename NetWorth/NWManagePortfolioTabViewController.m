//
//  NWPortfolioDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 31/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWManagePortfolioTabViewController.h"
#import "NWOverviewViewController.h"

@interface NWManagePortfolioTabViewController()

@end

@implementation NWManagePortfolioTabViewController

-(void)portfolioViewControllerDidDone:(UITableViewController *)controller
{
    [[self delegate2] portfolioDetailsViewControllerDidDone:self];
}

@end
