//
//  NWAccountDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAccount.h"

@class NWAccountDetailsViewController;

@protocol NWAccountDetailsViewControllerDelegate <NSObject>
- (void)accountDetailsViewControllerDidCancel:(NWAccountDetailsViewController *)controller;
- (void)accountDetailsViewController:(NWAccountDetailsViewController *)controller didAddAccount:(NWAccount *)account;
@end

@interface NWAccountDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, weak) id <NWAccountDetailsViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end