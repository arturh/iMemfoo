//
//  FirstViewController.m
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController


@synthesize audioPlayer;

@synthesize fetchedResultsController, 
            managedObjectContext;

@synthesize btnKana,
            btnShowBack,
            btnForget,
            btnRemember,
            tvMeaning,
            tvKanji;

@synthesize currentCard;


-(IBAction)playAudio:(id)sender
{
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:currentCard.audio
                      ofType:@"mp3"];
    path = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], currentCard.audio];
    NSLog(@"Rpath: %@", [[NSBundle mainBundle] resourcePath]);
    NSLog(@"audio: %@", self.currentCard.audio);
    NSLog(@"path: %@", path);
    if (path == nil) {
        NSLog(@"path is nil");
        return;
    }
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: path];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                              error: nil];
    [self.audioPlayer play];
}

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
    const NSTimeInterval correct_interval[] = {
        30, 60, 90, 150, 300,
        12*60*60, 24*60*60, 2*24*60*60, 3*24*60*60, 5*24*60*60, 8*24*60*60, 14*24*60*60,
        21*24*60*60, 30*24*60*60, 45*24*60*60, 60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60, 
         60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60, 
         60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,
         60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60, 
         60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60,  60*24*60*60};
    
    NSLog(@"I remember");

    NSTimeInterval time_interval = correct_interval[ [self.currentCard.correct intValue] ];
    self.currentCard.due = [[NSDate date] dateByAddingTimeInterval:time_interval];
    self.currentCard.correct =
        [NSNumber numberWithInt:[self.currentCard.correct intValue] + 1];
    
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
    [self hideBack];
    [self loadNextCard];
}

-(IBAction)forget:(id)sender {
    self.currentCard.correct = [NSNumber numberWithInt:0];
    self.currentCard.due = [[NSDate date] dateByAddingTimeInterval:30];
    
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
    [self hideBack];
    [self loadNextCard];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Test", @"Test");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(NSArray *)cardsDue
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"due"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(due <= %@) AND (introduced != nil)", [NSDate date]];
    
    [fetchRequest setPredicate:predicate];
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    return fetchedObjects;
}

-(NSArray *)cardsNotIntroduced
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cardId"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(introduced == nil)"];
    
    [fetchRequest setPredicate:predicate];
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    return fetchedObjects;
}

-(void)loadNextCard
{
    NSArray *due = [self cardsDue];
    NSArray *notIntroduced = [self cardsNotIntroduced];
    
    if ([due count] > 0) {
        self.currentCard = [due objectAtIndex:0];
    } else {
        self.currentCard = [notIntroduced objectAtIndex:0];
    }
    self.currentCard.introduced = [NSDate date];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    
    tvKanji.text = self.currentCard.kanji;
    [btnKana setTitle:self.currentCard.kana forState:UIControlStateNormal];
    tvMeaning.text = self.currentCard.meaning;

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadNextCard];
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
