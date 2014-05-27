//
//  SYBNewPlotPoint.m
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNewPlotPoint.h"
#import "syb"
#import "SYBData.h"

@interface SYBNewPlotPoint () <UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation SYBNewPlotPoint
{
    NSArray * test1;
    NSArray * test2;
    NSArray * test3;
    
    UIView * background;
    UITextView * storyThought;
    
    UIButton * selectChapter;
    UIButton * selectCharacter;
    UIButton * newChapterButton;
    UIButton * newCharacterButton;
    UIButton * chosen;
    
    UIPickerView * listPick;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        test1 = @[@"Joey",
                 @"Trent",
                 @"Mary"];
        test2 = @[@"Chapter1",
                  @"Chapter2",
                  @"Chapter3"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:background];
    
    storyThought = [[UITextView alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, 300)];
    storyThought.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:storyThought];
    
    newChapterButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-162, 40, 40)];
    newChapterButton.layer.cornerRadius = newChapterButton.frame.size.height/2;
    newChapterButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:newChapterButton];
    
    selectChapter = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-162, SCREEN_WIDTH - 90, 40)];
    selectChapter.backgroundColor = [UIColor blueColor];
    [selectChapter addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectChapter];
    
    newCharacterButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-112, 40, 40)];
    newCharacterButton.layer.cornerRadius = newCharacterButton.frame.size.height/2;
    newCharacterButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:newCharacterButton];
    
    selectCharacter = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-112, SCREEN_WIDTH-90, 40)];
    selectCharacter.backgroundColor = [UIColor blueColor];
    [selectCharacter addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectCharacter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openList:(UIButton *)sender
{
    if (sender == selectChapter) {
        test3 = test2;
    }else{
        test3 = test1;
    }
    
    listPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-162, SCREEN_WIDTH - SCREEN_WIDTH, 162)];
    listPick.backgroundColor = [UIColor redColor];
    listPick.delegate = self;
    chosen = sender;
    [self.view addSubview:listPick];
}

-(void)addItem:(UIButton *)sender
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [listPick removeFromSuperview];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [chosen setTitle:[NSString stringWithFormat:@"%@",test3[row]] forState:UIControlStateNormal];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return test3[row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [test3 count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {return 1;}

- (BOOL)automaticallyAdjustsScrollViewInsets { return NO; }


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
