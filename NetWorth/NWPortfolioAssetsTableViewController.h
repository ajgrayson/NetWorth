//
//  NWPortfolioEditItemTableViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 11/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWTabItemProtocol.h"
#import "NWAssetDetailsViewController.h"
#import <Parse/Parse.h>

@interface NWPortfolioAssetsTableViewController : UITableViewController<NWAssetDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong) PFObject *user;

@property (nonatomic, strong) PFObject *account;

@property (nonatomic, strong) UITabBarController<NWTabItemProtocol> *delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addAssetButton;

- (IBAction)done:(id)sender;

@end
