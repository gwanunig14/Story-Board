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

#import "SYBSettingsButton.h"

#import "SYBSettingsMenu.h"

@interface SYBChapterView ()

@end

@implementation SYBChapterView
{
    NSArray * allChapters;
    
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
        
        allChapters = [SYBData mainData].currentProject[@"projectInfo"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * createNewPlotPoint = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newPlotWindow)];
    createNewPlotPoint.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = createNewPlotPoint;
    
    settingsButtonView = [[SYBSettingsButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsButtonView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    settingsButtonView.tintColor = [UIColor blueColor];
    settingsButtonView.toggledTintColor = [UIColor redColor];
    //    photoEditor.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:settingsButtonView];
    self.navigationItem.leftBarButtonItem = settingsButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allChapters count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel * chapterName = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, self.view.frame.size.width -12, 20)];
    
    chapterName.text = allChapters[indexPath.row][@"heading"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell addSubview:chapterName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    chosenBlock = [[SYBChapterInfo alloc]init];
    
    [SYBData mainData].selectedChapter = (int)indexPath.row;
    
    [self.navigationController pushViewController:chosenBlock animated:YES];
}

-(void)newPlotWindow
{
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];
}

-(void)openSettings
{
    NSLog(@"button pressing");
    [settingsButtonView toggle];
    
    // ? is an if/else shortcut for true/false statements
    int X = [settingsButtonView isToggled] ? SCREEN_WIDTH - 52 : 0;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.navigationController.view.frame = CGRectMake(X, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        if ([settingsButtonView isToggled])
        {
            [settingsVC.view removeFromSuperview];
        }
    }];
    
    if ([settingsButtonView isToggled])
    {
        settingsVC = [[SYBSettingsMenu alloc] initWithNibName:nil bundle:nil];
        
        settingsVC.view.frame = CGRectMake(52-SCREEN_WIDTH, 0, SCREEN_WIDTH - 50, SCREEN_HEIGHT);
        [self.navigationController.view addSubview:settingsVC.view];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
