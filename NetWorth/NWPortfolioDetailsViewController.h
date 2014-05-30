//
//  NWPortfolioDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 31/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NWPortfolioDetailsViewController;

@protocol NWPortfolioDetailsViewControllerDelegate <NSObject>
- (void)portfolioDetailsViewControllerDidCancel:(NWPortfolioDetailsViewController *)controller;
- (void)portfolioDetailsViewControllerDidSave:(NWPortfolioDetailsViewController *)controller;
@end

@interface NWPortfolioDetailsViewController : UITabBarController

@property (weak, nonatomic) id<NWPortfolioDetailsViewControllerDelegate> delegate2;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
