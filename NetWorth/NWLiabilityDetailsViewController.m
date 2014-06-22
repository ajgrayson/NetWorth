//
//  NWLiabilityDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWLiabilityDetailsViewController.h"

@interface NWLiabilityDetailsViewController ()

@end

@implementation NWLiabilityDetailsViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    if(self.liability != nil) {
        self.nameTextField.text = [self.liability objectForKey:@"name"];
        self.valueTextField.text = [self.liability objectForKey:@"value"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(id)sender
{
    if(self.saving) return;
    self.saving = YES;
    
    PFObject *liability;
    
    if([[self.nameTextField text] length] == 0) return;
    if([[self.valueTextField text] length] == 0) return;
    
    if(self.liability != nil) {
        liability = self.liability;
    } else {
        liability = [PFObject objectWithClassName:ItemClassName];
        
        // Create relationship
        [liability setObject:[self user] forKey:@"author"];
        [liability setObject:[self account] forKey:@"account"];
        [liability setObject:LiabilityTypeName forKey:@"type"];
    }
    
    [liability setObject:[self.nameTextField text] forKey:@"name"];
    [liability setObject:[self.valueTextField text] forKey:@"value"];
    
    // Save the new post
    [liability saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate liabilityDetailsViewController:self didSaveLiability:liability];
        }
    }];
}

- (void)cancel:(id)sender
{
    [self.delegate liabilityDetailsViewControllerDidCancel:self];
}

@end
