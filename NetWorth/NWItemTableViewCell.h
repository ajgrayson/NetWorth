//
//  NWLiabilityTableViewCell.h
//  NetWorth
//
//  Created by Johnathan Grayson on 24/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
