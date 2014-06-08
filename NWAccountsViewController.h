//
//  NWAccountsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAccountDetailsViewController.h"

@interface NWAccountsViewController : UITableViewController <NWAccountDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *accounts;

@end