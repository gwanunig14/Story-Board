//
//  SYBAllCharacter.m
//  Story Board
//
//  Created by T.J. Mercer on 6/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBAllCharacter.h"
#import "SYBInfoCell.h"
#import "SYBData.h"


@interface SYBAllCharacter ()

@end

@implementation SYBAllCharacter

{
    NSMutableArray * chapterPoints;
    NSMutableArray * plotPoints;
    UITextView * plotPoint;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        plotPoints = [@[]mutableCopy];
        chapterPoints = [@[]mutableCopy];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSDictionary * one in [SYBData mainData].currentProject[@"projectInfo"])
    {
        NSLog(@"change 1 %@",[SYBData mainData].currentProject[@"projectInfo"]);
        for (NSMutableDictionary * two in one[@"info"])
        {
            NSString * name = [two objectForKey:@"character"];
            NSLog(@"change 2 %@",name);
            NSLog(@"change 3 %@",self.character);
            if ([name isEqualToString:self.character])
            {
                [chapterPoints addObject:two];
                NSLog(@"change 4 %@",chapterPoints);
            };
        };
    };
    
    UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.image = [UIImage imageNamed:@"background"];
    self.tableView.backgroundView = background;
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    UISwipeGestureRecognizer * rSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
    rSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rSwipe];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"rows %lu",(unsigned long)[chapterPoints count]);
    return [chapterPoints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYBInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    //    cell.complete = allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    cell.complete.backgroundColor = TEXTBOX_COLOR;
    
    UITextView * standin = plotPoints[indexPath.row];
    cell.complete.text = standin.text;
    cell.complete.layer.cornerRadius = 5;
    cell.height = standin.frame.size.height-20;
    NSLog(@"cell %f",standin.frame.size.height);
    NSString * character = chapterPoints[indexPath.row][@"character"];
    cell.color = [SYBData mainData].characters[character];
    cell.background.backgroundColor = TEXTBOX_COLOR;
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell makeCell];
    [cell fullview];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, SCREEN_WIDTH - 45, 0)];
    
    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, 265, 0)];
    plotPoint.layer.cornerRadius = 5;
    plotPoint.text = chapterPoints[indexPath.row][@"plotpoint"];
    [plotPoint layoutIfNeeded];
    
    CGRect frame = plotPoint.frame;
    frame.size.height = plotPoint.contentSize.height + 20;
    
    plotPoint.frame = CGRectMake(10, 10, frame.size.width, frame.size.height - 20);
    plotPoint.editable = NO;
    plotPoint.backgroundColor = TEXTBOX_COLOR;
    
    [plotPoints addObject:plotPoint];
    
    NSLog(@"frame %f",frame.size.height);
    
    return frame.size.height;
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
