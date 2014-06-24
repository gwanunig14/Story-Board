//
//  SYBNav.m
//  Story Board
//
//  Created by T.J. Mercer on 6/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNav.h"

@interface SYBNav ()

@end

@implementation SYBNav

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:87/255.0 green:87/255.0 blue:88/255.0 alpha:1]];
        
        self.navigationBar.translucent = NO;
        
    }
    return self;
}

-(void)titleWithText:(NSString *)text
{
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2) - 100, 2, 200, 40)];
    title.text = text;
    title.textColor = BACKGROUND_COLOR;
    title.textAlignment = NSTextAlignmentCenter;
    title.adjustsFontSizeToFitWidth = YES;
    [self.navigationBar addSubview:title];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
