//
//  SYBViewAll.m
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBViewAll.h"
#import "SYBInfoCell.h"
#import "SYBData.h"

@interface SYBViewAll ()

@end

@implementation SYBViewAll
{
    NSArray * chapterPoints;
    NSMutableDictionary * allPoints;
    NSMutableArray * plotPoints;
    UITextView * plotPoint;
    float marker;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
        self.tableView.backgroundView = background;
        
        plotPoints = [@[]mutableCopy];
        allPoints = [@{}mutableCopy];
        marker = 0;
        
        self.tableView.separatorColor = [UIColor clearColor];
        
        UISwipeGestureRecognizer * rSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
        rSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rSwipe];
        
        [self.navigationItem setHidesBackButton:YES animated:YES];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = TOP_COLOR;
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[SYBData mainData].chapters count];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableArray * current = [@[]mutableCopy];
    [current addObject:plotPoints];
//    [allPoints insertObject:current atIndex:0];
    chapterPoints = [SYBData mainData].chapters[section][@"info"];
    NSString * heading = [SYBData mainData].chapters[section][@"heading"];
    return heading;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chapterPoints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYBInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSLog(@"%@",allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row]);
    
//    cell.complete = allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    cell.complete.backgroundColor = TEXTBOX_COLOR;
    
    UITextView * standin = allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    cell.complete.text = standin.text;
    cell.complete.layer.cornerRadius = 5;
    cell.height = standin.frame.size.height;
    NSString * character = [SYBData mainData].chapters[indexPath.section][@"info"][indexPath.row][@"character"];
    cell.color = [SYBData mainData].characters[character];
    cell.background.backgroundColor = TEXTBOX_COLOR;
    cell.backgroundColor = [UIColor clearColor];
    
    [cell makeCell];
    [cell fullview];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]] == 0)
    {
        allPoints[[NSString stringWithFormat:@"%d",(int)indexPath.section]] = [@[]mutableCopy];
    }

    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, 265, 0)];
    plotPoint.layer.cornerRadius = 5;
    plotPoint.text = [SYBData mainData].chapters[indexPath.section][@"info"][indexPath.row][@"plotpoint"];
    [plotPoint layoutIfNeeded];
    
    CGRect frame = plotPoint.frame;
    frame.size.height = plotPoint.contentSize.height + 20;
    
    plotPoint.frame = CGRectMake(10, 10, frame.size.width, frame.size.height - 20);
    plotPoint.editable = NO;
    plotPoint.backgroundColor = TEXTBOX_COLOR;
    [allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]] addObject:plotPoint];
    
//    [allPoints addObject:plotPoints];
    
//    [plotPoints insertObject:plotPoint atIndex:indexPath.row];
    
    return frame.size.height + 20;
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
