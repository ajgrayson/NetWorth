//
//  NWViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWHelper.h"
#import "NWManagePortfolioTabViewController.h"
//#import <Parse/Parse.h>
#import "NWAccountDetailsViewController.h"

@interface NWOverviewViewController : UIViewController  <UIPageViewControllerDataSource, NWManagePortfolioTabViewControllerDelegate, NWAccountDetailsViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property NSInteger *curentIndex;

@property (strong, nonatomic) NSArray *users;

//@property (strong, nonatomic) PFObject *account;

@property (strong, nonatomic) UINavigationItem *navItem;

- (IBAction)manage:(id)sender;

- (void)portfolioDetailsViewControllerDidDone:(NWManagePortfolioTabViewController *)controller;

@end
