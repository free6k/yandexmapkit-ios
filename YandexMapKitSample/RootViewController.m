/*
 * RootViewController.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011 YANDEX
 * 
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "RootViewController.h"
#import "Sample.h"
#import "SettingsViewController.h"

@interface RootViewController ()

- (void)configureTableView;
- (void)configureTableViewCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)readSamples;
- (Sample *)sampleAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, copy) NSArray * samples;

@end


@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)onSettingsTapped:(id)sender {
    SettingsViewController *vc = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:vc animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self readSamples];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SampleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self configureTableViewCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Sample * sample = [self sampleAtIndexPath:indexPath];
    Class viewControllerClass = NSClassFromString(sample.viewControllerClassName);
    
    UIViewController * viewController = [[viewControllerClass alloc] init];
    viewController.title = sample.title;

    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

#pragma mark - Helpers

- (void)configureTableViewCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Sample * sample = [self sampleAtIndexPath:indexPath];
    cell.textLabel.text = sample.title;
    cell.detailTextLabel.text = sample.subtitle;
    cell.detailTextLabel.numberOfLines = 3;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)configureTableView {
    self.tableView.rowHeight = 80.0f;
}

- (void)readSamples {
    NSMutableArray * tempArray = [[NSMutableArray alloc] initWithCapacity:5];
    NSString * samplesDictionaryPath = [[NSBundle mainBundle] pathForResource:@"SamplesList" ofType:@"plist"];
    NSDictionary * samplesDictionary = [[NSDictionary alloc] initWithContentsOfFile:samplesDictionaryPath];
    
    for (NSDictionary * sampleDictionary in [samplesDictionary objectForKey:@"Samples"]) {
        Sample * sample = [Sample sampleWithDictionary:sampleDictionary];
        [tempArray addObject:sample];
    }
    
    self.samples = [NSArray arrayWithArray:tempArray];
    
    [tempArray release];
    [samplesDictionary release];
}

- (Sample *)sampleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.samples objectAtIndex:indexPath.row];
}


#pragma mark - Properties

@synthesize samples;

#pragma mark - Memory Management

- (void)dealloc {
    self.samples = nil;
    
    [super dealloc];
}

@end
