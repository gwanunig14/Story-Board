//
//  SYBData.h
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYBData : NSObject

+(SYBData *)mainData;

-(void)addNewProject:(NSMutableDictionary *)project;
-(NSArray *)allProjects;
-(NSDictionary *)currentProject;

@property (nonatomic) int selectedProject;
// selectedChapter

@property (nonatomic) NSArray * colors;

// - method to return selected project
// - method to return selected chapter

@end
