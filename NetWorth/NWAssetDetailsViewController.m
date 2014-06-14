//
//  NWAssetDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 12/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAssetDetailsViewController.h"

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
        self.nameTextField.text = self.asset.name;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(id)sender
{
    NWAsset *asset = [[NWAsset alloc] init];
    asset.name = self.nameTextField.text;
    
    if(self.asset != nil) {
        asset.id = self.asset.id;
    } else {
        srandom(time(NULL));
        
        asset.id = [[NSNumber alloc]initWithInt:(arc4random() % 100)];
    }
    
    [self.delegate assetDetailsViewController:self didSaveAsset:asset];
}

- (void)cancel:(id)sender
{
    [self.delegate assetDetailsViewControllerDidCancel:self];
}

@end
