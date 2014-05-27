//
//  SYBViewController.m
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNewListItem.h"

@interface SYBNewListItem ()

@end

@implementation SYBNewListItem
{
    UITextField * newListItem;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        newListItem = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 40)];
        [self.view addSubview:newListItem];
        
        UIButton * addItem = [[UIButton alloc]initWithFrame:CGRectMake(120, 10, 40, 40)];
        addItem.layer.cornerRadius = 20;
        [self.view addSubview:addItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
