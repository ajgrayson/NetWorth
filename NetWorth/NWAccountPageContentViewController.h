//
//  NWPageContentViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWPageContentViewProtocol.h"

@interface NWAccountPageContentViewController : UIViewController <NWPageContentViewProtocol>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property NSUInteger pageIndex;

@property (strong, nonatomic) UINavigationItem *navItem;

@end
