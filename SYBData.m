//
//  SYBData.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBData.h"

@interface SYBData ()

@property  (nonatomic) NSMutableArray * projects;

@end

@implementation SYBData
{
//    NSMutableArray * projects;
}

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
        
        self.colors = @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]];
        
        /* for (nsstring * key in [dictionary allkeys])
            (
         
            )
         */
    }
    return self;
}

-(NSMutableArray *)projects
{
    if(_projects == nil)
    {
        _projects = [@[]mutableCopy];
    }
    return _projects;
}

-(void)addNewProject:(NSDictionary *)project
{
    [self.projects addObject:project];
    
    [self saveData];
}

-(NSArray *)allProjects
{
    return [self.projects copy];
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
    [self.characters setObject:@(number) forKey:character];
    
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
