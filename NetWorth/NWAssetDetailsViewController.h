//
//  NWAssetDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 12/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class NWAssetDetailsViewController;

@protocol NWAssetDetailsViewControllerDelegate <NSObject>
- (void)assetDetailsViewControllerDidCancel:(NWAssetDetailsViewController *)controller;
- (void)assetDetailsViewController:(NWAssetDetailsViewController *)controller didSaveAsset:(PFObject *)asset;
@end

@interface NWAssetDetailsViewController : UIViewController

@property (weak, nonatomic) id<NWAssetDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) PFObject *user;

@property (weak, nonatomic) PFObject *account;

@property (weak, nonatomic) PFObject *asset;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@property BOOL saving;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
