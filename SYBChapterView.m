//
//  SYBChapterView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChapterView.h"

#import "SYBChapterInfo.h"

#import "SYBNewPlotPoint.h"

#import "SYBData.h"

#import "SYBNewProjectView.h"

#import "SYBSettingsButton.h"

#import "SYBSettingsMenu.h"

#import "SYBInfoCell.h"

@interface SYBChapterView () <SYBSettingsDelegate>

@end

@implementation SYBChapterView
{
    NSArray * allChapters;
    
    int X;
    
    int mover;
    
    SYBInfoCell * cell;
    
    SYBNewProjectView * new;
    
    SYBChapterInfo * chosenBlock;
    
    SYBNewPlotPoint * plotWindow;
    
    SYBSettingsButton * settingsButtonView;
    SYBSettingsMenu * settingsVC;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        plotWindow = [[SYBNewPlotPoint alloc]init];
        
        new = [[SYBNewProjectView alloc]init];
        
        allChapters = [SYBData mainData].currentProject[@"projectInfo"];
        
        NSLog(@"A");
        
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
        [self.view insertSubview:background atIndex:0];
        
        self.tableView.rowHeight = 78;
        self.tableView.separatorColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * plot = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [plot setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [plot addTarget:self action:@selector(newPlotWindow) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * createNewPlotPoint = [[UIBarButtonItem alloc]initWithCustomView:plot];
    createNewPlotPoint.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = createNewPlotPoint;
    self.editButtonItem.tintColor = BACKGROUND_COLOR;
    
    settingsButtonView = [[SYBSettingsButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsButtonView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:settingsButtonView];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    settingsVC = [[SYBSettingsMenu alloc] initWithNibName:nil bundle:nil];
    
    settingsVC.delegate = self;
    
    mover = 220;
    X = -mover;
    
    settingsVC.view.frame = CGRectMake(X, 44, mover, SCREEN_HEIGHT);
    
    self.navigationItem.rightBarButtonItems = @[createNewPlotPoint, self.editButtonItem];
}

-(void)viewDidAppear:(BOOL)animated
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
    
    UILabel * chapterName = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 20)];
    UIView * back = [[UIView alloc]initWithFrame:CGRectMake(-10, 12, 275, chapterName.frame.size.height+34)];
    back.layer.cornerRadius = 5;
    back.backgroundColor = TEXTBOX_COLOR;
    chapterName.backgroundColor = TEXTBOX_COLOR;
    //    projectName.textAlignment = NSTextAlignmentCenter;
    chapterName.text = allChapters[indexPath.row][@"heading"];
    chapterName.textColor = BACKGROUND_COLOR;
    
    if (cell == nil) cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [back addSubview:chapterName];
    [cell addSubview:back];
    cell.height = back.frame.size.height;
    cell.color = TEXTBOX_COLOR;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell makeCell];
    
    cell.backgroundColor =[UIColor clearColor];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    chosenBlock = [[SYBChapterInfo alloc]init];
    [SYBData mainData].selectedChapter = (int)indexPath.row;
    
    plotWindow.chapterAssignment = indexPath.row;

    [self.navigationController pushViewController:chosenBlock animated:YES];
}

-(void)newPlotWindow
{
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    nc.navigationBarHidden = YES;
    [self.navigationController presentViewController:nc animated:YES completion:^{
        [plotWindow buttonLabels];
    }];
}

-(void)openSettings
{
    [settingsButtonView toggle];
    
    X = [settingsButtonView isToggled] ? 0 : -mover;
    
    if (X == 0)
    {
        [self.navigationController.view addSubview:settingsVC.view];
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        settingsVC.view.frame = CGRectMake(X, 44, mover, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        if (X == mover)
        {
            [settingsVC.view removeFromSuperview];
        }
    }];
    
}

-(void)pushViewController:(UIViewController *)view
{
    [self openSettings];
    [self.navigationController pushViewController:view animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Delete the row from the data source
    [[SYBData mainData].currentProject[@"projectInfo"] removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[SYBData mainData] moveChapter:[SYBData mainData].chapters[fromIndexPath.row] fromIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
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
