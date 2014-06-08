//
//  NWHomePageContentViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWPageContentViewProtocol.h"
#import "NWAccount.h"

@interface NWOverviewPageContentViewController : UIViewController <NWPageContentViewProtocol>

@property (weak, nonatomic) IBOutlet UILabel *netWorthTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *assetTotalsLabel;

@property (weak, nonatomic) IBOutlet UILabel *liabilitiesTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property NSUInteger pageIndex;

@property (strong, nonatomic) NWAccount *account;

@property (strong, nonatomic) UINavigationItem *navItem;

@end
