//
//  NWPortfolioLiabilitiesTableViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWLiabilityDetailsViewController.h"
#import "NWTabItemProtocol.h"
#import <Parse/Parse.h>

@interface NWPortfolioLiabilitiesTableViewController : UITableViewController<NWLiabilityDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *liabilities;

@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong) PFObject *user;

@property (nonatomic, strong) PFObject *account;

@property (nonatomic, strong) UITabBarController<NWTabItemProtocol> *delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addLiabilityButton;

- (IBAction)done:(id)sender;

@end
