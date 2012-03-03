//
//  FirstViewController.m
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController


@synthesize btnKana;
@synthesize btnShowBack;
@synthesize btnForget;
@synthesize btnRemember;
@synthesize tvMeaning;
@synthesize tvKanji;

@synthesize fetchedResultsController, managedObjectContext;

-(IBAction)showBack:(id)sendr {
    btnShowBack.hidden = YES;
    btnKana.hidden = NO;
    btnRemember.hidden = NO;
    btnForget.hidden = NO;
    tvMeaning.hidden = NO;
}

-(void)hideBack {
    btnShowBack.hidden = NO;
    btnKana.hidden = YES;
    btnRemember.hidden = YES;
    btnForget.hidden = YES;
    tvMeaning.hidden = YES;    
}

-(IBAction)remember:(id)sender {
    [self hideBack];
}

-(IBAction)forget:(id)sender {
    [self hideBack];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
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
