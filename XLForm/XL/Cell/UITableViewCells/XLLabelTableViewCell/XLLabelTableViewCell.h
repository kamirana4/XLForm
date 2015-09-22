//
//  XLLabelTableViewCell.h
//  ALJ
//
//  Created by vlad gorbenko on 9/2/15.
//  Copyright (c) 2015 s4m. All rights reserved.
//

#import "FTXLBaseTableViewCell.h"

@interface XLLabelTableViewCell : FTXLBaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;

@end
