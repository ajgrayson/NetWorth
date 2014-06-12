//
//  NWAssetDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 12/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAsset.h"

@class NWAssetDetailsViewController;

@protocol NWAssetDetailsViewControllerDelegate <NSObject>
- (void)assetDetailsViewControllerDidCancel:(NWAssetDetailsViewController *)controller;
- (void)assetDetailsViewController:(NWAssetDetailsViewController *)controller didSaveAsset:(NWAsset *)asset;
@end

@interface NWAssetDetailsViewController : UIViewController

@property (weak, nonatomic) id<NWAssetDetailsViewControllerDelegate> delegate;

@end
