//
//  NWPortfolioDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 31/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWPortfolioDetailsViewController.h"

@interface NWPortfolioDetailsViewController()

@end

@implementation NWPortfolioDetailsViewController

- (IBAction)done:(id)sender
{
    [self.delegate2 portfolioDetailsViewControllerDidDone:self];
}

@end