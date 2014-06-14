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

@interface NWPortfolioAssetsTableViewController : UITableViewController<NWAssetDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) UITabBarController<NWTabItemProtocol> *delegate;

- (IBAction)done:(id)sender;

@end
