//
//  AppDelegate.m
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "CardUITableViewController.h"

#import "Card.h"

@implementation AppDelegate



@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

//Explicitly write Core Data accessors
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent:@"iMemfoo.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(BOOL) checkIfExistDatabase
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:entity];    
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request
                                                                 error:&error];
    
    return count > 0;
}

-(void)populateDatabase
{
    NSLog(@"Entered populateDatabase");
    
    NSString *path = [[NSBundle mainBundle]
                            pathForResource:@"jlptn5"
                            ofType:@"tsv"];
    NSString *jlptn5 = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [jlptn5 componentsSeparatedByString: @"\r\n"];
    // If splitting consumes too much RAM, try with NSScanner
    int i = 0;
    for (NSString *line in lines) {
        NSLog(@"inserting: %d", i);
        i += 1;
        @try {
            NSArray *line_components = [line componentsSeparatedByString: @"\t"];
            
            NSNumber *cardId = [NSNumber numberWithInt:i];
            NSString *kanji = [line_components objectAtIndex:0];
            NSString *kana = [line_components objectAtIndex:1];
            NSString *meaning = [line_components objectAtIndex:2];
            NSString *audio = [line_components objectAtIndex:3];
            
            Card *newCard= [NSEntityDescription insertNewObjectForEntityForName:@"Card"
                                                         inManagedObjectContext:self.managedObjectContext];
            newCard.cardId = cardId;
            newCard.kanji = kanji;
            newCard.kana = kana;
            newCard.meaning = meaning;
            newCard.audio = audio;
            newCard.correct = [NSNumber numberWithInt:0];
        }
        @catch (NSException *e) {
            if ([e.name isEqualToString: NSRangeException])
                NSLog(@"NSRangeException  at line %d", i);
            else
                @throw;
        }

    }
    NSError *error = nil;
    [managedObjectContext save:&error];
    NSLog(@"populateDatabase done");
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (![self checkIfExistDatabase]) {
        NSLog(@"NO DATABASE");
        [self populateDatabase];
    } else {
        NSLog(@"databaseExists!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    FirstViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    viewController1.managedObjectContext = managedObjectContext;
    
    SecondViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    viewController2.managedObjectContext = managedObjectContext;
    
    CardUITableViewController *viewController3 = [[CardUITableViewController alloc] initWithNibName:@"CardUITableViewController" bundle:nil];
    viewController3.managedObjectContext = managedObjectContext;
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, nil];
    
    [self.window addSubview:[viewController3 view]];
    
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
