//
//  NWPageContentViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWPageContentViewProtocol.h"
#import <Parse/Parse.h>

@interface NWAccountPageContentViewController : UIViewController <NWPageContentViewProtocol>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *assetTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *netWorthTotalLabel;

@property (weak, nonatomic) IBOutlet UILabel *liabilitiesTotalLabel;

@property NSUInteger pageIndex;

@property (strong, nonatomic) PFObject *user;

@property (strong, nonatomic) PFObject *account;

@property (strong, nonatomic) UINavigationItem *navItem;

@end
