//
//  NWPortfolioDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 31/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWTabItemProtocol.h"
#import <Parse/Parse.h>

@class NWManagePortfolioTabViewController;

@protocol NWManagePortfolioTabViewControllerDelegate <NSObject>
- (void)portfolioDetailsViewControllerDidDone:(NWManagePortfolioTabViewController *)controller;
@end

@interface NWManagePortfolioTabViewController : UITabBarController<NWTabItemProtocol>

@property (strong, nonatomic) PFObject *account;

@property (strong, nonatomic) PFObject *user;

@property (weak, nonatomic) id<NWManagePortfolioTabViewControllerDelegate> delegate2;

-(void)portfolioViewControllerDidDone:(UITableViewController *)controller;

@end
