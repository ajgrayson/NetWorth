//
//  NWAssetDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 12/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAssetDetailsViewController.h"
#import "NWConstants.h"
#import "NWCategory.h"
#import "NWHelper.h"

@interface NWAssetDetailsViewController ()

@end

@implementation NWAssetDetailsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.categories = [NWHelper getAssetCategories];
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
//    if(self.asset != nil) {
//        self.nameTextField.text = [self.asset objectForKey:@"name"];
//        self.valueTextField.text = [self.asset objectForKey:@"value"];
//        
//        int cat = 0;
//        if([self.asset objectForKey:@"category"] != nil) {
//            cat = [[self.asset objectForKey:@"category"] intValue];
//        }
//        [self.categoryPicker selectRow:cat inComponent:0 animated:YES];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.categories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NWCategory *cat = (NWCategory *) [self.categories objectAtIndex:row];
    
    return cat.name;
}

- (void)done:(id)sender
{
//    if(self.saving)return;
//    self.saving = YES;
//    
//    PFObject *asset;
//    
//    if([[self.nameTextField text] length] == 0) return;
//    if([[self.valueTextField text] length] == 0) return;
//    
//    if(self.asset != nil) {
//        asset = self.asset;
//    } else {
//        asset = [PFObject objectWithClassName:ItemClassName];
//        
//        // Create relationship
//        [asset setObject:[self user] forKey:@"author"];
//        [asset setObject:[self account] forKey:@"account"];
//        [asset setObject:AssetTypeName forKey:@"type"];
//    }
//    
//    int row = [self.categoryPicker selectedRowInComponent:0];
//    NWCategory *cat = (NWCategory *)self.categories[row];
//    
//    [asset setObject:[self.nameTextField text] forKey:@"name"];
//    [asset setObject:[self.valueTextField text] forKey:@"value"];
//    [asset setObject:cat.id forKey:@"category"];
//    
//    // Save the new post
//    [asset saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            [self.delegate assetDetailsViewController:self didSaveAsset:asset];
//        }
//    }];
}

- (void)cancel:(id)sender
{
    [self.delegate assetDetailsViewControllerDidCancel:self];
}

@end
