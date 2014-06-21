//
//  NWAccountDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 30/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

//#import "NWAccount.h"

@class NWAccountDetailsViewController;

@protocol NWAccountDetailsViewControllerDelegate <NSObject>
- (void)accountDetailsViewControllerDidCancel:(NWAccountDetailsViewController *)controller;
- (void)accountDetailsViewController:(NWAccountDetailsViewController *)controller didSaveAccount:(PFObject *)account;
@end

@interface NWAccountDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) id <NWAccountDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) PFObject *data;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

- (void)setData:(PFObject *)account;

@end
