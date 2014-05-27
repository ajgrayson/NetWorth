//
//  NWViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAccount.h"

@interface NWViewController : UIViewController  <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pageTitles;

@property (strong, nonatomic) NWAccount *account;

@property (strong, nonatomic) UINavigationItem *navItem;

@end
