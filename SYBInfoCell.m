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
{
    UIImageView * i;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.complete = [[UITextView alloc]init];
        
        
        self.height = 54;
        
        self.background = [[UIView alloc]initWithFrame:CGRectMake(-10, 12, 275, self.height)];
        self.background.backgroundColor = [UIColor clearColor];
        self.background.layer.cornerRadius = 5;
        [self addSubview:self.background];
        
        self.plotInfo = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, 255, 54)];
        self.plotInfo.backgroundColor = [UIColor clearColor];
        self.plotInfo.enabled = NO;
        
        self.sideTab = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 12, 50, self.height)];
        self.sideTab.layer.cornerRadius = 5;
        [self.contentView addSubview:self.sideTab];
        
        i = [[UIImageView alloc]initWithFrame:CGRectMake(10, (self.sideTab.frame.size.height/2) -10, 20, 20)];
        i.image = [UIImage imageNamed:@"info"];
        [self.sideTab addSubview:i];
        
        self.plotInfo.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        [self.plotInfo textRectForBounds:CGRectMake(40, 12, 275, 10)];
        self.plotInfo.layer.cornerRadius = 5;
        self.plotInfo.textColor = BACKGROUND_COLOR;
        [self.background addSubview:self.plotInfo];
        
        [self.background addSubview:self.complete];
    }
    return self;
}

-(void)makeCell
{
    self.sideTab.backgroundColor = self.color;
}

-(void)fullview
{
    self.background.frame = CGRectMake(-10, 12, 275, self.height+20);
    self.sideTab.frame = CGRectMake(SCREEN_WIDTH-40, 12, 50, self.height+20);
    self.complete.frame = CGRectMake(20, 0, 255, self.height);
    i.frame = CGRectMake(10, (self.sideTab.frame.size.height/2) -10, 20, 20);
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
