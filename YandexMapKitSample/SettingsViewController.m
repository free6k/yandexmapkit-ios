/*
 * SettingsViewController.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011 YANDEX
 * 
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@property(nonatomic, retain) IBOutlet UITextField *keyTextField;

@end

@implementation SettingsViewController

@synthesize keyTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    self.keyTextField = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.keyTextField.text = [Settings sharedSettings].apiKey;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.keyTextField = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.keyTextField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)onSaveTapped:(id)sender {
    [Settings sharedSettings].apiKey = self.keyTextField.text;
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onCancelTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
