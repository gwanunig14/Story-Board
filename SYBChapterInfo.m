//
//  SYBChapterInfo.m
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChapterInfo.h"

#import "SYBNewPlotPoint.h"

#import "SYBInfoCell.h"

#import "SYBSettingsMenu.h"

#import "SYBSettingsButton.h"

#import "SYBData.h"

@interface SYBChapterInfo ()<SYBSettingsDelegate>

@end

@implementation SYBChapterInfo
{
    SYBInfoCell * cell;
    
    SYBSettingsButton * settingsButtonView;
    
    UITextView * postIt;
    
    UIButton * postItSide;
    
    NSArray * bulletPoints;
    
    UITextView * plotPoint;
    
    UITextView * next;
    
    UIButton * nextSide;
    
    NSMutableArray * characters;
    
    SYBNewPlotPoint * plotWindow;
    
    SYBSettingsMenu * settingsVC;
    
    UIButton * cellButton;
    
    CGRect frame;
    
    UISwipeGestureRecognizer * uSwipe;
    
    UISwipeGestureRecognizer * lSwipe;
    
    UISwipeGestureRecognizer * dSwipe;
    
    int edit;
    
    int X;
    
    int mover;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        characters = [@[] mutableCopy];
        
        plotWindow = [[SYBNewPlotPoint alloc]init];
        
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
        self.tableView.backgroundView = background;
        settingsVC.delegate = self;
        
//        self.tableView.editing = YES;
        
//        bulletPoints = [SYBData mainData].currentChapter[@"info"];
        
        self.tableView.separatorColor = [UIColor clearColor];
        
        settingsButtonView = [[SYBSettingsButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [settingsButtonView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:settingsButtonView];
        self.navigationItem.leftBarButtonItem = settingsButton;
        
        settingsVC = [[SYBSettingsMenu alloc] initWithNibName:nil bundle:nil];
        
        settingsVC.delegate = self;
        
        mover = 220;
        X = -mover;
        
        settingsVC.view.frame = CGRectMake(X, 44, mover, SCREEN_HEIGHT);
        
        self.tableView.rowHeight = 78;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
//    [characters removeAllObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIButton * plot = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [plot setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [plot addTarget:self action:@selector(newPlotWindow) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * createNewPlotPoint = [[UIBarButtonItem alloc]initWithCustomView:plot];
    createNewPlotPoint.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = createNewPlotPoint;
    self.editButtonItem.tintColor = BACKGROUND_COLOR;
    self.navigationItem.rightBarButtonItems = @[createNewPlotPoint, self.editButtonItem];
    
    UISwipeGestureRecognizer * rSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
    rSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rSwipe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    bulletPoints = [SYBData mainData].currentChapter[@"info"];
    return [bulletPoints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.plotInfo.text = bulletPoints[indexPath.row][@"plotpoint"];
    
    NSString * character = bulletPoints[indexPath.row][@"character"];
    cell.color = [SYBData mainData].characters[character];
    cell.background.backgroundColor = TEXTBOX_COLOR;
    cellButton.backgroundColor = [UIColor clearColor];
    
    [cell makeCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    [characters addObject:character];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    edit = (int)indexPath.row;
    
    [self makeThePostIt];
    
    next.frame = CGRectMake(-280, (SCREEN_HEIGHT/2)-(frame.size.height/2), 275, frame.size.height+20);
    
    nextSide.frame = CGRectMake(SCREEN_WIDTH+60, (SCREEN_HEIGHT/2)-(frame.size.height/2), 50, next.frame.size.height);
    
    UIImageView * i = [[UIImageView alloc]initWithFrame:CGRectMake(10, (nextSide.frame.size.height/2) -10, 20, 20)];
    i.image = [UIImage imageNamed:@"info"];
    [nextSide addSubview:i];
    
    [self.navigationController.view addSubview:next];
    [self.navigationController.view addSubview:nextSide];
    
    [UIView animateWithDuration:0.5 animations:^{
        next.frame = CGRectMake(-10, (SCREEN_HEIGHT/2)-(frame.size.height/2), 275, frame.size.height+20);
        nextSide.frame = CGRectMake(SCREEN_WIDTH-40, (SCREEN_HEIGHT/2)-(frame.size.height/2), 50, next.frame.size.height);
        self.tableView.alpha = 0.2;
    } completion:^(BOOL finished) {
        postIt = next;
        postItSide = nextSide;
    }];
    
    cellButton = [[UIButton alloc]initWithFrame:CGRectMake(postItSide.frame.origin.x, postItSide.frame.origin.y, postItSide.frame.size.width, postIt.frame.size.height)];
    [cellButton addTarget:self action:@selector(editText) forControlEvents:UIControlEventTouchUpInside];
    
    [postItSide addSubview:cellButton];
}

-(void)shoo
{
    [UIView animateWithDuration:0.5 animations:^{
        postIt.frame = CGRectMake(-280, (SCREEN_HEIGHT/2)-(frame.size.height/2), 275, frame.size.height+20);
        postItSide.frame = CGRectMake(SCREEN_WIDTH+60, (SCREEN_HEIGHT/2)-(frame.size.height/2), 50, next.frame.size.height);
        self.tableView.alpha = 1;
    } completion:^(BOOL finished) {
        [postIt removeFromSuperview];
        [postItSide removeFromSuperview];
        self.tableView.scrollEnabled = YES;
        self.tableView.allowsSelection = YES;
    }];
}

-(void)scroll:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"%d",edit);
    NSLog(@"%lu",(unsigned long)[characters count]);
    
    switch (gesture.direction) {
        case 4: //up
        {
            if (edit < [bulletPoints count] - 1) {
                
                edit = edit + 1;
                
                [self makeThePostIt];
                
                next.frame = CGRectMake(-10, SCREEN_HEIGHT, 275, frame.size.height+20);
                
                nextSide.frame = CGRectMake(SCREEN_WIDTH-40, SCREEN_HEIGHT, 50, next.frame.size.height);
                
                UIImageView * i = [[UIImageView alloc]initWithFrame:CGRectMake(10, (nextSide.frame.size.height/2) -10, 20, 20)];
                i.image = [UIImage imageNamed:@"info"];
                [nextSide addSubview:i];
                
                [self.navigationController.view addSubview:next];
                [self.navigationController.view addSubview:nextSide];
                
                [UIView animateWithDuration:0.5 animations:^{
                    postIt.frame = CGRectMake(-10, -(frame.size.height + 20), 275, frame.size.height+20);
                    postItSide.frame = CGRectMake(SCREEN_WIDTH-40, -(frame.size.height + 20), 50, next.frame.size.height);
                    next.frame = CGRectMake(-10, (SCREEN_HEIGHT/2)-(frame.size.height/2), 275, frame.size.height+20);
                    nextSide.frame = CGRectMake(SCREEN_WIDTH-40, (SCREEN_HEIGHT/2)-(frame.size.height/2), 50, next.frame.size.height);
                } completion:^(BOOL finished) {
                    [postIt removeFromSuperview];
                    [postItSide removeFromSuperview];
                    postIt = next;
                    postItSide = nextSide;
                }];
            }
        }
            break;
            
        case 8: //down
        {
            if (edit >0) {
                edit = edit - 1;
                
                [self makeThePostIt];
                
                next.frame = CGRectMake(-10, -(frame.size.height + 20), 275, frame.size.height+20);
                nextSide.frame = CGRectMake(SCREEN_WIDTH-40, -frame.size.height, 50, next.frame.size.height);
                
                UIImageView * i = [[UIImageView alloc]initWithFrame:CGRectMake(10, (nextSide.frame.size.height/2) -10, 20, 20)];
                i.image = [UIImage imageNamed:@"info"];
                [nextSide addSubview:i];
                
                [self.navigationController.view addSubview:next];
                [self.navigationController.view addSubview:nextSide];
                
                [UIView animateWithDuration:0.5 animations:^{
                    postIt.frame = CGRectMake(-10, SCREEN_HEIGHT, 275, frame.size.height+15);
                    postItSide.frame = CGRectMake(SCREEN_WIDTH-40, SCREEN_HEIGHT, 50, next.frame.size.height);
                    next.frame = CGRectMake(-10, (SCREEN_HEIGHT/2)-(frame.size.height/2), 275, frame.size.height+20);
                    nextSide.frame = CGRectMake(SCREEN_WIDTH-40, (SCREEN_HEIGHT/2)-(frame.size.height/2), 50, next.frame.size.height);
                } completion:^(BOOL finished) {
                    [postIt removeFromSuperview];
                    [postItSide removeFromSuperview];
                    postIt = next;
                    postItSide = nextSide;
                }];
            }
        }
            break;
            
        default:
            break;
    }
    
    cellButton = [[UIButton alloc]initWithFrame:CGRectMake(postItSide.frame.origin.x, postItSide.frame.origin.y, postItSide.frame.size.width, postIt.frame.size.height)];
    [cellButton addTarget:self action:@selector(editText) forControlEvents:UIControlEventTouchUpInside];
    
    [postItSide addSubview:cellButton];
}

-(void)makeThePostIt
{
    NSString * editText = bulletPoints[edit][@"plotpoint"];
    
    next = [[UITextView alloc]initWithFrame:CGRectMake(-280, 100, 20, 200)];
    next.text = editText;
    next.editable = NO;
    next.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    next.layer.cornerRadius = 5;
    frame = next.frame;
    next.textColor = BACKGROUND_COLOR;
    next.backgroundColor = TEXTBOX_COLOR;
    next.textContainerInset = UIEdgeInsetsMake(10, 20, 10, 10);
    
    self.tableView.scrollEnabled = NO;
    self.tableView.editing = NO;
    self.tableView.allowsSelection = NO;
    
    nextSide = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH+60, 12, 50, frame.size.height)];
    nextSide.backgroundColor = [SYBData mainData].characters[characters[edit]];
    nextSide.layer.cornerRadius = 5;
    [nextSide addTarget:self action:@selector(editText) forControlEvents:UIControlEventTouchUpInside];
    
    lSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(shoo)];
    lSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [next addGestureRecognizer:lSwipe];
    
    dSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scroll:)];
    dSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [nextSide addGestureRecognizer:dSwipe];
    
    uSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scroll:)];
    uSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [nextSide addGestureRecognizer:uSwipe];
}

-(void)editText
{
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    nc.navigationBarHidden = YES;
    
    plotWindow.chapterAssignment = [SYBData mainData].selectedChapter;
    plotWindow.characterAssignment = bulletPoints[edit][@"character"];
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        plotWindow.storyThought.text = postIt.text;
        plotWindow.editNumber = edit;
        [plotWindow buttonLabels];
        [self shoo];
    }];
}

-(void)newPlotWindow
{
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    nc.navigationBarHidden = YES;
    [self.navigationController presentViewController:nc animated:YES completion:^{
        plotWindow.chapterAssignment = [SYBData mainData].selectedChapter;
        [plotWindow buttonLabels];
        [self.tableView removeFromSuperview];
    }];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Detemine if it's in editing mode
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SYBData mainData].currentChapter[@"info"] removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [[SYBData mainData] saveData];
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[SYBData mainData] movePlotPoint:bulletPoints[fromIndexPath.row] fromIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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

-(void)dismissed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushViewController:(UIViewController *)view
{
    [self openSettings];
    [self.navigationController pushViewController:view animated:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
