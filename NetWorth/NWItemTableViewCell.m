//
//  NWLiabilityTableViewCell.m
//  NetWorth
//
//  Created by Johnathan Grayson on 24/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWItemTableViewCell.h"

@implementation NWItemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
