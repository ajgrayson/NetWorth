//
//  NWAccountDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 30/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccountDetailsViewController.h"
#import "NWAccountUserViewController.h"
#import "NWConstants.h"

@interface NWAccountDetailsViewController ()

@end

@implementation NWAccountDetailsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.users = [[NSMutableArray alloc] initWithCapacity:0];
    
//    if(self.account != nil) {
//        self.nameTextField.text = [self.account objectForKey:@"name"];
//        [self loadUsers];
//    } else {
//        self.userTableView.hidden = YES;
//        self.inviteUserButton.hidden = YES;
//        self.userTableTitleLabel.hidden = YES;
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"AddAccountUser"]) {
//        NWAccountUserViewController *accountUserViewController = segue.destinationViewController;
//        
//        accountUserViewController.account = self.account;
//    } else if ([segue.identifier isEqualToString:@"EditAccountUser"]) {
//        NWAccountUserViewController *accountUserViewController = segue.destinationViewController;
//        
//        NSIndexPath *indexPath = [self.userTableView indexPathForSelectedRow];
//        
//        PFObject *user = [self.users objectAtIndex:indexPath.row];
//        
//        accountUserViewController.account = self.account;
//        accountUserViewController.user = user;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUsers
{
    self.users = [NSMutableArray arrayWithCapacity:0];
    
//    PFRelation *relation = [self.account relationForKey:@"members"];
//    
//    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            // There was an error
//        } else {
//            [self.users addObjectsFromArray: objects];
//            [self.userTableView reloadData];
//        }
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountUserCell" forIndexPath:indexPath];
    
//    PFObject *user = [self.users objectAtIndex:indexPath.row];
//    [cell.textLabel setText:[user objectForKey:@"username"]];
//    
    return cell;
}

- (IBAction)cancel:(id)sender
{
    [self.delegate accountDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    if(self.saving) return;
    self.saving = YES;
    
//    PFObject *account;
//    PFUser *user = [PFUser currentUser];
//    BOOL isNew = YES;
//    
//    if(self.account != nil) {
//        account = self.account;
//        isNew = NO;
//    } else {
//        account = [PFObject objectWithClassName:AccountClassName];
//        
//        // Create relationship
//        [account setObject:user forKey:@"author"];
//        
//        PFRelation *relation = [account relationForKey:@"members"];
//        [relation addObject:user];
//    }
    
//    [account setObject:[self.nameTextField text] forKey:@"name"];
    
    // Save the new post
//    [account saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            if(isNew) {
//                //PFRelation *relation2 = [user relationForKey:@"accounts"];
//                //[relation2 addObject:account];
//                
//                [self.delegate accountDetailsViewController:self didSaveAccount:account];
//                
////                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
////                    [self.delegate accountDetailsViewController:self didSaveAccount:account];
////                }];
//            } else {
//                [self.delegate accountDetailsViewController:self didSaveAccount:account];
//            }
//        }
//    }];
    
    
}

@end
