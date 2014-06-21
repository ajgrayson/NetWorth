//
//  NWAccountsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAccountDetailsViewController.h"
#import <Parse/Parse.h>

@interface NWAccountsTableViewController : UITableViewController <NWAccountDetailsViewControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *accounts;

@property BOOL loading;

@end
