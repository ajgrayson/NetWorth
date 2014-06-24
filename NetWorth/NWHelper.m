//
//  NWAccount.m
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWHelper.h"
#import "NWCategory.h"

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
    PFQuery *query = [PFQuery queryWithClassName:ItemClassName];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // Follow relationship
    [query whereKey:@"author" equalTo:user];
    [query whereKey:@"account" equalTo:account];
    [query whereKey:@"type" equalTo:AssetTypeName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSNumber *val = [NWHelper sumValues:objects];
            onCompleteBlock(val);
        }
    }];
}

+ (void)getTotalLiabilitiesInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^)(NSNumber *))onCompleteBlock
{
    PFQuery *query = [PFQuery queryWithClassName:ItemClassName];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // Follow relationship
    [query whereKey:@"author" equalTo:user];
    [query whereKey:@"account" equalTo:account];
    [query whereKey:@"type" equalTo:LiabilityTypeName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSNumber *val = [NWHelper sumValues:objects];
            onCompleteBlock(val);
        }
    }];
}

+ (void)getTotalsForInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^) (NSNumber *, NSNumber *))onCompleteBlock
{
    PFQuery *query = [PFQuery queryWithClassName:ItemClassName];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // Follow relationship
    [query whereKey:@"author" equalTo:user];
    [query whereKey:@"account" equalTo:account];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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
    PFQuery *query = [PFQuery queryWithClassName:ItemClassName];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // Follow relationship
    [query whereKey:@"account" equalTo:account];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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

+(NSArray *)getAssetCategories
{
    NWCategory *cat1 = [[NWCategory alloc] init];
    cat1.id = [[NSNumber alloc] initWithInt:0];
    cat1.name = @"Liquid";
    
    NWCategory *cat2 = [[NWCategory alloc] init];
    cat2.id = [[NSNumber alloc] initWithInt:1];
    cat2.name = @"Large or Fixed";
    
    NWCategory *cat3 = [[NWCategory alloc] init];
    cat3.id = [[NSNumber alloc] initWithInt:2];
    cat3.name = @"Personal Item";
    
    return [[NSArray alloc] initWithObjects:cat1, cat2, cat3, nil];
}

+(NSArray *)getLiabilityCategories
{
    NWCategory *cat1 = [[NWCategory alloc] init];
    cat1.id = [[NSNumber alloc] initWithInt:0];
    cat1.name = @"Short Term";
    
    NWCategory *cat2 = [[NWCategory alloc] init];
    cat2.id = [[NSNumber alloc] initWithInt:1];
    cat2.name = @"Long Term";
    
    return [[NSArray alloc] initWithObjects:cat1, cat2, nil];
}

@end
