//
//  NWAccountDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 30/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAccount.h"

@class NWAccountDetailsViewController;

@protocol NWAccountDetailsViewControllerDelegate <NSObject>
- (void)accountDetailsViewControllerDidCancel:(NWAccountDetailsViewController *)controller;
- (void)accountDetailsViewController:(NWAccountDetailsViewController *)controller didAddAccount:(NWAccount *)account;
@end

@interface NWAccountDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) id <NWAccountDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) NWAccount *data;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

- (void)setData:(NWAccount *)account;

@end
