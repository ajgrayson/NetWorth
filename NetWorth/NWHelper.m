//
//  NWAccount.m
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWHelper.h"

@implementation NWHelper

+ (NSNumber *)sumValues:(NSArray *)objects
{
    if(objects == nil || objects.count == 0) return [[NSNumber alloc] initWithFloat:0];
    
    NSNumber *totalAssets = [[NSNumber alloc] initWithFloat:0];
    
    for (int i = 0; i < objects.count; i++) {
        PFObject *asset = [objects objectAtIndex:i];
        NSString *val = [asset objectForKey:@"value"];
        
        NSNumber *fval = [[NSNumber alloc] initWithDouble:[val floatValue]];
        
        totalAssets = [NSNumber numberWithFloat:([totalAssets floatValue] + [fval floatValue])];
    }
    
    return totalAssets;
}

+ (NSString *)formatNumberAsMoney:(NSNumber *)val
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:0];
    
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[val floatValue]]];
    
    return numberAsString;
}

+ (void)getTotalAssetsInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^) (NSNumber *))onCompleteBlock
{
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"author" equalTo:user];
    [postQuery whereKey:@"account" equalTo:account];
    [postQuery whereKey:@"type" equalTo:AssetTypeName];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSNumber *val = [NWHelper sumValues:objects];
            onCompleteBlock(val);
        }
    }];
}

+ (void)getTotalLiabilitiesInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^)(NSNumber *))onCompleteBlock
{
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"author" equalTo:user];
    [postQuery whereKey:@"account" equalTo:account];
    [postQuery whereKey:@"type" equalTo:LiabilityTypeName];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSNumber *val = [NWHelper sumValues:objects];
            onCompleteBlock(val);
        }
    }];
}

+ (void)getTotalsForInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^) (NSNumber *, NSNumber *))onCompleteBlock
{
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"author" equalTo:user];
    [postQuery whereKey:@"account" equalTo:account];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSNumber *totalAssets = [[NSNumber alloc] initWithFloat:0];
            NSNumber *totalLiabilities = [[NSNumber alloc] initWithFloat:0];
            
            if(objects == nil || objects.count == 0) {
                onCompleteBlock(totalAssets, totalLiabilities);
                return;
            }
            
            for (int i = 0; i < objects.count; i++) {
                PFObject *item = [objects objectAtIndex:i];
                NSString *type = [item objectForKey:@"type"];
                NSString *val = [item objectForKey:@"value"];
                
                NSNumber *fval = [[NSNumber alloc] initWithDouble:[val floatValue]];
                
                if([type isEqualToString:AssetTypeName]) {
                    totalAssets = [NSNumber numberWithFloat:([totalAssets floatValue] + [fval floatValue])];
                } else if([type isEqualToString:LiabilityTypeName]) {
                    totalLiabilities = [NSNumber numberWithFloat:([totalLiabilities floatValue] + [fval floatValue])];
                }
            }

            onCompleteBlock(totalAssets, totalLiabilities);
        }
    }];
}

+ (void)getTotalsForInAccount:(PFObject *)account withBlock:(void (^) (NSNumber *, NSNumber *))onCompleteBlock
{
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"account" equalTo:account];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSNumber *totalAssets = [[NSNumber alloc] initWithFloat:0];
            NSNumber *totalLiabilities = [[NSNumber alloc] initWithFloat:0];
            
            if(objects == nil || objects.count == 0) {
                onCompleteBlock(totalAssets, totalLiabilities);
                return;
            }
            
            for (int i = 0; i < objects.count; i++) {
                PFObject *item = [objects objectAtIndex:i];
                NSString *type = [item objectForKey:@"type"];
                NSString *val = [item objectForKey:@"value"];
                
                NSNumber *fval = [[NSNumber alloc] initWithDouble:[val floatValue]];
                
                if([type isEqualToString:AssetTypeName]) {
                    totalAssets = [NSNumber numberWithFloat:([totalAssets floatValue] + [fval floatValue])];
                } else if([type isEqualToString:LiabilityTypeName]) {
                    totalLiabilities = [NSNumber numberWithFloat:([totalLiabilities floatValue] + [fval floatValue])];
                }
            }
            
            onCompleteBlock(totalAssets, totalLiabilities);
        }
    }];
}


@end
