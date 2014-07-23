//
//  NWLiabilityDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWLiabilityDetailsViewController.h"
#import "NWCategory.h"
#import "NWHelper.h"

@interface NWLiabilityDetailsViewController ()

@end

@implementation NWLiabilityDetailsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.categories = [NWHelper getLiabilityCategories];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
//    if(self.liability != nil) {
//        self.nameTextField.text = [self.liability objectForKey:@"name"];
//        self.valueTextField.text = [self.liability objectForKey:@"value"];
//        
//        int cat = 0;
//        if([self.liability objectForKey:@"category"] != nil) {
//            cat = [[self.liability objectForKey:@"category"] intValue];
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
//    if(self.saving) return;
//    self.saving = YES;
//    
//    PFObject *liability;
//    
//    if([[self.nameTextField text] length] == 0) return;
//    if([[self.valueTextField text] length] == 0) return;
//    
//    if(self.liability != nil) {
//        liability = self.liability;
//    } else {
//        liability = [PFObject objectWithClassName:ItemClassName];
//        
//        // Create relationship
//        [liability setObject:[self user] forKey:@"author"];
//        [liability setObject:[self account] forKey:@"account"];
//        [liability setObject:LiabilityTypeName forKey:@"type"];
//    }
//    
//    int row = [self.categoryPicker selectedRowInComponent:0];
//    NWCategory *cat = (NWCategory *)self.categories[row];
//    
//    [liability setObject:[self.nameTextField text] forKey:@"name"];
//    [liability setObject:[self.valueTextField text] forKey:@"value"];
//    [liability setObject:cat.id forKey:@"category"];
//    
//    // Save the new post
//    [liability saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            [self.delegate liabilityDetailsViewController:self didSaveLiability:liability];
//        }
//    }];
}

- (void)cancel:(id)sender
{
    [self.delegate liabilityDetailsViewControllerDidCancel:self];
}

@end
