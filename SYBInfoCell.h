//
//  SYBInfoCellCell.h
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBInfoCell : UITableViewCell

@property (nonatomic) UITextField * plotInfo;

@property (nonatomic) UITextView * complete;

@property (nonatomic) UIView * background;

@property (nonatomic) UIColor * color;

@property (nonatomic) UIView * sideTab;

@property (nonatomic) int height;

-(void)makeCell;

-(void)fullview;

@end
