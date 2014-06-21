//
//  NWAssetDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 12/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAssetDetailsViewController.h"
#import "NWConstants.h"

@interface NWAssetDetailsViewController ()

@end

@implementation NWAssetDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.asset != nil) {
        self.nameTextField.text = [self.asset objectForKey:@"name"];
        self.valueTextField.text = [self.asset objectForKey:@"value"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(id)sender
{
    PFObject *asset;
    
    if([[self.nameTextField text] length] == 0) return;
    if([[self.valueTextField text] length] == 0) return;
    
    if(self.asset != nil) {
        asset = self.asset;
    } else {
        asset = [PFObject objectWithClassName:ItemClassName];
        
        // Create relationship
        [asset setObject:[self user] forKey:@"author"];
        [asset setObject:[self account] forKey:@"account"];
        [asset setObject:AssetTypeName forKey:@"type"];
    }
    
    [asset setObject:[self.nameTextField text] forKey:@"name"];
    [asset setObject:[self.valueTextField text] forKey:@"value"];
    
    // Save the new post
    [asset saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate assetDetailsViewController:self didSaveAsset:asset];
        }
    }];
}

- (void)cancel:(id)sender
{
    [self.delegate assetDetailsViewControllerDidCancel:self];
}

@end
