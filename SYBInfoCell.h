//
//  SYBInfoCellCell.h
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBInfoCell : UITableViewCell

@property (nonatomic) UITextView * plotInfo;

@property (nonatomic) UIColor * color;

@property (nonatomic) UIButton * button;

-(void)makeCell;

@end
