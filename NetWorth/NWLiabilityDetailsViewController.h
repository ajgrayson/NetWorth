//
//  NWLiabilityDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "NWConstants.h"

@class NWLiabilityDetailsViewController;

@protocol NWLiabilityDetailsViewControllerDelegate <NSObject>
- (void)liabilityDetailsViewControllerDidCancel:(NWLiabilityDetailsViewController *)controller;
- (void)liabilityDetailsViewController:(NWLiabilityDetailsViewController *)controller didSaveLiability:(PFObject *)liability;
@end

@interface NWLiabilityDetailsViewController : UIViewController

@property (weak, nonatomic) id<NWLiabilityDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) PFObject *user;

@property (weak, nonatomic) PFObject *account;

@property (weak, nonatomic) PFObject *liability;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
