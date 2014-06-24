//
//  SYBCharacterList.m
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBCharacterList.h"
#import "SYBChangeName.h"
#import "SYBAllCharacter.h"
#import "SYBInfoCell.h"
#import "SYBData.h"

@interface SYBCharacterList ()

@end

@implementation SYBCharacterList
{
    NSDictionary * allCharacters;
    SYBInfoCell * cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        allCharacters = [SYBData mainData].currentProject[@"characters"];
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[SYBData mainData].characters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.plotInfo.text = [[SYBData mainData].characters allKeys][indexPath.row];;
    
    NSString * character = [[SYBData mainData].characters allKeys][indexPath.row];
    cell.color = [SYBData mainData].characters[character];
    cell.background.backgroundColor = TEXTBOX_COLOR;
    
    [cell makeCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editOrNot == 1) {
        SYBChangeName * newName = [[SYBChangeName alloc]init];
        newName.function = 3;
        newName.oldTitle = [allCharacters allKeys][indexPath.row];
        [self.navigationController pushViewController:newName animated:YES];
    } else {
        SYBAllCharacter * viewAC = [[SYBAllCharacter alloc]init];
        viewAC.character = [allCharacters allKeys][indexPath.row];
        [self.navigationController pushViewController:viewAC animated:YES];
    }
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
