//
//  SYBViewController.h
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYBNewListItemDelegate;

@interface SYBNewListItem : UIViewController

@property (nonatomic,assign) id<SYBNewListItemDelegate> delegate;

@end

@protocol SYBNewListItemDelegate <NSObject>

-(void)updateSingletonArrayWithLabel:(NSString *)object;

@end
