//
//  NWAccount.h
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "NWConstants.h"

@interface NWHelper : NSObject

+ (NSNumber *)sumValues:(NSArray *)objects;

+ (NSString *)formatNumberAsMoney:(NSNumber *)val;

+ (void)getTotalAssetsInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^) (NSNumber *))onCompleteBlock;

+ (void)getTotalLiabilitiesInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^) (NSNumber *))onCompleteBlock;

+ (void)getTotalsForInAccount:(PFObject *)account forUser:(PFObject *)user withBlock:(void (^) (NSNumber *, NSNumber *))onCompleteBlock;

+ (void)getTotalsForInAccount:(PFObject *)account withBlock:(void (^) (NSNumber *, NSNumber *))onCompleteBlock;

@end
