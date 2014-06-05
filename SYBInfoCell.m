//
//  SYBInfoCellCell.m
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBInfoCell.h"
#import "SYBData.h"

@implementation SYBInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.plotInfo = [[UITextView alloc]init];
    }
    return self;
}

-(void)makeCell
{
    self.plotInfo.backgroundColor = [SYBData mainData].colors[self.colorNumber];
    
    [self addSubview:self.plotInfo];
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
