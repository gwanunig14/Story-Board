//
//  SYBData.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBData.h"

@interface SYBData ()

@end

@implementation SYBData

+(SYBData *)mainData
{
    static dispatch_once_t create;
    static SYBData * singleton=nil;
    
    dispatch_once (&create, ^{
        singleton = [[SYBData alloc]init];
    });
    
    return singleton;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [self loadProjects];
        
        UIColor * red = [UIColor colorWithRed:255/255.0 green:4/255.0 blue:0/255.0 alpha:1];
        UIColor * raspberry = [UIColor colorWithRed:217/255.0 green:0/255.0 blue:70/255.0 alpha:1];
        UIColor * magenta = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:132/255.0 alpha:1];
        UIColor * pink = [UIColor colorWithRed:255/255.0 green:122/255.0 blue:175/255.0 alpha:1];
        UIColor * lightPink = [UIColor colorWithRed:255/255.0 green:178/255.0 blue:204/255.0 alpha:1];
        UIColor * orange = [UIColor colorWithRed:255/255.0 green:161/255.0 blue:62/255.0 alpha:1];
        UIColor * tangerine = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1];
        UIColor * peach = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:162/255.0 alpha:1];
        UIColor * sunglow = [UIColor colorWithRed:255/255.0 green:227/255.0 blue:96/255.0 alpha:1];
        UIColor * yellow = [UIColor colorWithRed:249/255.0 green:250/255.0 blue:0/255.0 alpha:1];
        UIColor * green = [UIColor colorWithRed:0/255.0 green:158/255.0 blue:59/255.0 alpha:1];
        UIColor * avocado = [UIColor colorWithRed:154/255.0 green:184/255.0 blue:49/255.0 alpha:1];
        UIColor * apple = [UIColor colorWithRed:137/255.0 green:216/255.0 blue:102/255.0 alpha:1];
        UIColor * lime = [UIColor colorWithRed:204/255.0 green:232/255.0 blue:45/255.0 alpha:1];
        UIColor * paleGreen = [UIColor colorWithRed:198/255.0 green:234/255.0 blue:166/255.0 alpha:1];
        UIColor * aqua = [UIColor colorWithRed:44/255.0 green:204/255.0 blue:201/255.0 alpha:1];
        UIColor * teal = [UIColor colorWithRed:0/255.0 green:143/255.0 blue:172/255.0 alpha:1];
        UIColor * turquoise = [UIColor colorWithRed:0/255.0 green:199/255.0 blue:213/255.0 alpha:1];
        UIColor * oceanBlue = [UIColor colorWithRed:93/255.0 green:176/255.0 blue:184/255.0 alpha:1];
        UIColor * sky = [UIColor colorWithRed:175/255.0 green:227/255.0 blue:250/255.0 alpha:1];
        UIColor * brightBlue = [UIColor colorWithRed:0/255.0 green:145/255.0 blue:210/255.0 alpha:1];
        UIColor * royalBlue = [UIColor colorWithRed:35/255.0 green:77/255.0 blue:169/255.0 alpha:1];
        UIColor * navy = [UIColor colorWithRed:0/255.0 green:67/255.0 blue:128/255.0 alpha:1];
        UIColor * violet = [UIColor colorWithRed:63/255.0 green:25/255.0 blue:148/255.0 alpha:1];
        UIColor * purple = [UIColor colorWithRed:182/255.0 green:32/255.0 blue:151/255.0 alpha:1];
        UIColor * ochre = [UIColor colorWithRed:219/255.0 green:162/255.0 blue:0/255.0 alpha:1];
        UIColor * sable = [UIColor colorWithRed:192/255.0 green:137/255.0 blue:112/255.0 alpha:1];
        UIColor * chocolate = [UIColor colorWithRed:108/255.0 green:50/255.0 blue:0/255.0 alpha:1];
        UIColor * lavender = [UIColor colorWithRed:188/255.0 green:174/255.0 blue:217/255.0 alpha:1];
        
        self.colors = @[red,
                        orange,
                        yellow,
                        green,
                        brightBlue,
                        purple,
                        chocolate,
                        raspberry,
                        tangerine,
                        peach,
                        avocado,
                        aqua,
                        magenta,
                        sunglow,
                        apple,
                        turquoise,
                        violet,
                        pink,
                        lime,
                        oceanBlue,
                        lavender,
                        paleGreen,
                        sable,
                        teal,
                        ochre,
                        sky,
                        navy,
                        lightPink,
                        royalBlue];
    }
    return self;
}

-(NSMutableDictionary *)projects
{
    if(_projects == nil)
    {
        _projects = [@{}mutableCopy];
    }
    return _projects;
}

-(void)addNewProject:(NSDictionary *)project atKey:(NSString *)key
{
    [self.projects setObject:project forKey:key];
    
    [self saveData];
}

-(NSMutableDictionary *)allProjects
{
    return self.projects;
}

-(NSString *)currentTitle
{
    return self.projects[self.selectedProject];
}

-(NSDictionary *)currentProject
{
    return self.projects[self.selectedProject];
}

-(NSDictionary *)currentChapter
{
    return self.chapters[self.selectedChapter];
}

-(void)addNewCharacter:(NSString *)character withNumber:(NSInteger)number
{
    [self.characters setObject:self.colors[number] forKey:character];
    
    [self saveData];
}

-(NSMutableDictionary *)characters
{
    return self.currentProject[@"characters"];
}

-(void)addNewChapter:(NSDictionary *)chapter
{
    [self.chapters addObject:chapter];
    
    [self saveData];
}

-(void)movePlotPoint:(NSArray *)plotPoint fromIndex:(NSInteger)from toIndex:(NSInteger)to
{
    [self.currentChapter[@"info"] removeObjectAtIndex:from];
    [self.currentChapter[@"info"] insertObject:plotPoint atIndex:to];
    
    [self saveData];
}

-(void)moveChapter:(NSArray *)chapter fromIndex:(NSInteger)from toIndex:(NSInteger)to
{
    [self.currentProject[@"projectInfo"] removeObjectAtIndex:from];
    [self.currentProject[@"projectInfo"] insertObject:chapter atIndex:to];
    
    [self saveData];
}

-(NSMutableArray *)chapters
{
    return self.currentProject[@"projectInfo"];
}

-(void)addNewPlotPoint:(NSDictionary *)plotPoint atIndex:(NSInteger)index
{
    NSMutableArray * chapter = self.chapters[index][@"info"];
    
    [chapter addObject:plotPoint];
    
    [self saveData];
}

-(void)saveData
{
    NSLog(@"saved");
    NSString * path = [self listArchivePath];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.projects];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

- (NSString *)listArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"writingProject.data"];
}

-(void)loadProjects
{
    NSLog(@"loaded");
    NSString * path = [self listArchivePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
       self.projects = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}

@end
