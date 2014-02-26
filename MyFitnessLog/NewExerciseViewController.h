//
//  NewExerciseViewController.h
//  MyFitnessLog
//
//  Created by Matheus Felipe on 20/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewExerciseViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *name;
@property(weak, nonatomic) IBOutlet UITextField *sets;
@property(weak, nonatomic) IBOutlet UITextField *reps;
@property(weak, nonatomic) IBOutlet UITextField *weight;
@property(weak, nonatomic) IBOutlet UISegmentedControl *unity;
@property(weak, nonatomic) IBOutlet UILabel *warningMessage;

@end
