//
//  ExercisesListViewController.h
//  MyFitnessLog
//
//  Created by Matheus Felipe on 18/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrainingLog;

@interface ExercisesListViewController : UITableViewController

@property(strong, nonatomic) TrainingLog *detailItem;
@property(weak, nonatomic) IBOutlet UILabel *trainingLogDateLabel;

@end
