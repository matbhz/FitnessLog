//
//  ExerciseDetailViewController.m
//  MyFitnessLog
//
//  Created by Matheus Felipe on 20/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "Exercise.h"

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _detailItem.name;
    self.setsLabel.text = _detailItem.sets;
    self.repsLabel.text = _detailItem.reps;
    self.weightAndUnity.text = [NSString stringWithFormat:@"%@ %@", _detailItem.weight, _detailItem.unity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
