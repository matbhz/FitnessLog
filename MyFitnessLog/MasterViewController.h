//
//  MasterViewController.h
//  MyFitnessLog
//
//  Created by Matheus Felipe on 18/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Exercise;
@class TrainingLog;

@interface MasterViewController : UITableViewController

@property(strong, nonatomic) NSString *path;

- (void)save;

@end
