//
//  SYBData.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBData.h"

@implementation SYBData
{
    NSMutableArray * projects;
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
        projects = [@[@{@"title": @"Gods and Men"},
                      @{@"title": @"SteamPunk",
                        @"characters":@[
                                    @"Bob",
                                    @"Jen"
                                ],
                        @"projectInfo":@[@{@"heading":@"chapter1",
                                           @"info":@[@"Jerry walks down the path.",
                                                     @"Carl moves into his new house.",
                                                     @"Alice moves away."]},
                                         @{@"heading":@"chapter2"},
                                         @{@"heading":@"chapter3"},
                                         @{@"heading":@"chapter4"}]}]
                    mutableCopy];
        
        self.colors = @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]];
        
        self.selectedProject = 1;
    }
    return self;
}

-(void)addNewProject:(NSMutableDictionary *)project
{
    [projects addObject:project];
}

-(NSArray *)allProjects
{
    return [projects copy];
}

-(NSDictionary *)currentProject
{
    
    return projects[self.selectedProject];
}

@end
