//
//  SYBNavigator.h
//  Story Board
//
//  Created by T.J. Mercer on 6/2/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYBNavigatorDelegate;

@interface SYBNavigator : UINavigationController

//@property (nonatomic,assign) id<SYBNavigatorDelegate> delegate;

//-(void)listViewAndDeleteOld:(UIViewController *)old;
//
//-(void)newViewAndDeleteOld:(UIViewController *)old;

@end

@protocol SYBNavigatorDelegate <NSObject>

-(void)pushViewController:(UIViewController *)view;

@end
