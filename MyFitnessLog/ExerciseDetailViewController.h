//
//  ExerciseDetailViewController.h
//  MyFitnessLog
//
//  Created by Matheus Felipe on 20/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Exercise;

@interface ExerciseDetailViewController : UIViewController

@property(strong, nonatomic) Exercise *detailItem;

@property(weak, nonatomic) IBOutlet UILabel *setsLabel;
@property(weak, nonatomic) IBOutlet UILabel *repsLabel;
@property(weak, nonatomic) IBOutlet UILabel *weightAndUnity;

@end
