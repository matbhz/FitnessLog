//
//  ExercisesListViewController.m
//  MyFitnessLog
//
//  Created by Matheus Felipe on 18/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import "ExercisesListViewController.h"
#import "TrainingLog.h"
#import "NewExerciseViewController.h"
#import "Exercise.h"
#import "MasterViewController.h"
#import "ExerciseDetailViewController.h"

@interface ExercisesListViewController () {
    NSMutableArray *_exercises;
}
- (void)configureView;
@end

@implementation ExercisesListViewController

#pragma mark - Managing the detail item

- (void)setTrainingLogs:(id)newTrainingLogs {
    if (_trainingLogs != newTrainingLogs) {
        _trainingLogs = newTrainingLogs;
        // Extract exercises list from the TrainingLog (newTrainingLogs) into _trainingLogs
        _exercises = _trainingLogs.excercises;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.trainingLogs) {
        // Set the title as the creation date of the current TrainingLog for reference
        self.trainingLogDateLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"recordCreatedAt", nil), _trainingLogs.date];
        // Add right navigation number to add exercises
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewExerciseModal)];
        self.navigationItem.rightBarButtonItem = addButton;
        self.navigationItem.title = self.trainingLogs.name;
    }
}

- (void)insertNewExerciseModal {
    // Get the storyboard, so we can access the views designed through the XCode interface
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Add an ID for this controller in the story board, then retrieve it programmatically
    NewExerciseViewController *newExerciseViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewExerciseViewController"];
    // Create a CANCEL and DONE button for the Navigation bar
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneCreatingNewObject)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCreatingNewObject)];
    newExerciseViewController.navigationItem.rightBarButtonItem = doneButton;
    newExerciseViewController.navigationItem.leftBarButtonItem = cancelButton;
    newExerciseViewController.navigationItem.title = NSLocalizedString(@"newExercise", nil);
    // Add a navigation controller so we have the navigation bar control buttons on the top of the display
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newExerciseViewController];
    // Finally, presents (not push!) the Navigation Controller
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)doneCreatingNewObject {

    NewExerciseViewController *newExerciseViewController = (NewExerciseViewController *) self.presentedViewController.childViewControllers[0];

    NSString *name = newExerciseViewController.name.text;
    NSString *sets = newExerciseViewController.sets.text;
    NSString *reps = newExerciseViewController.reps.text;
    NSString *weight = newExerciseViewController.weight.text;
    NSString *unity = newExerciseViewController.unity.selectedSegmentIndex == 0 ? @"kg" : NSLocalizedString(@"plates", nil);

    if ([name isEqualToString:@""] || [sets isEqualToString:@""] || [reps isEqualToString:@""]
            || [weight isEqualToString:@""] || [unity isEqualToString:@""]) {
        newExerciseViewController.warningMessage.hidden = FALSE;
    } else {
        if (!_exercises) {
            _exercises = [[NSMutableArray alloc] init];
        }

        Exercise *exercise = [[Exercise alloc] initWithName:name sets:sets reps:reps weight:weight unity:unity];
        // Add Exercise to the TableView
        [_exercises insertObject:exercise atIndex:0];
        self.trainingLogs.excercises = _exercises;
        MasterViewController *masterViewController = self.navigationController.viewControllers[0];
        [masterViewController save];

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)cancelCreatingNewObject {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _exercises.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Exercise *exercise = _exercises[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@x%@)", exercise.name, exercise.sets, exercise.reps];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_exercises removeObjectAtIndex:indexPath.row];

        self.trainingLogs.excercises = _exercises;

        MasterViewController *masterViewController = self.navigationController.viewControllers[0];
        [masterViewController save];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showExerciseDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Exercise *object = _exercises[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
