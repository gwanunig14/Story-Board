//
//  SYBChapterView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChapterList.h"

#import "SYBChangeName.h"

#import "SYBInfoCell.h"

#import "SYBData.h"

@interface SYBChapterList ()

@end

@implementation SYBChapterList
{
    NSArray * allChapters;
    SYBInfoCell * cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        NSLog(@"1");
        allChapters = [SYBData mainData].currentProject[@"projectInfo"];
        NSLog(@"1");
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSLog(@"1");
        background.image = [UIImage imageNamed:@"background"];
        NSLog(@"1");
        [self.view insertSubview:background atIndex:0];
        
        self.tableView.rowHeight = 78;
        self.tableView.separatorColor = [UIColor clearColor];
        [self.view insertSubview:background atIndex:0];
        
        UISwipeGestureRecognizer * rSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
        rSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rSwipe];
        
        [self.navigationItem setHidesBackButton:YES animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2) - 100, 2, 200, 40)];
    NSLog(@"1");
    title.text = [SYBData mainData].currentTitle;
    NSLog(@"1");
    title.textAlignment = NSTextAlignmentCenter;
    NSLog(@"1");
//    title.adjustsFontSizeToFitWidth = YES;
    NSLog(@"1");
    [self.navigationController.navigationBar addSubview:title];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SYBData mainData].chapters count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.plotInfo.text = allChapters[indexPath.row][@"heading"];
    
    cell.color = TEXTBOX_COLOR;
    cell.background.backgroundColor = TEXTBOX_COLOR;
    
    [cell makeCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYBChangeName * newName = [[SYBChangeName alloc]init];
    newName.function = 2;
    newName.index = (int)indexPath.row;
    newName.oldTitle = allChapters[indexPath.row][@"heading"];
    [self.navigationController pushViewController:newName animated:YES];
}

-(void)dismissed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
