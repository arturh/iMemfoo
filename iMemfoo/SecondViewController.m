//
//  SecondViewController.m
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

@synthesize
    lbCardsLeft,
    lbCardsLearned,
    lbDueTomorrow;

@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Stats", @"Stats");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    lbCardsLeft.text = [NSString stringWithFormat:@"%d / %d",
                            [self cardsLeft], [self cardsTotal]];
    lbCardsLearned.text = [NSString stringWithFormat:@"%d", [self cardsLearned]];
    lbDueTomorrow.text = [NSString stringWithFormat:@"%d", [self cardsDueTomorrow]];
}

-(NSUInteger)cardsLeft
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"introduced == nil"];
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    return [managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

-(NSUInteger)cardsTotal
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    return [managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

-(NSUInteger)cardsLearned
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"correct > 0"];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    return [managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

-(NSUInteger)cardsDueTomorrow
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"due < %@",
                              [[NSDate date] dateByAddingTimeInterval:24*60*60]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    return [managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
