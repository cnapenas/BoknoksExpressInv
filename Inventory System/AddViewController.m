//
//  AddViewController.m
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/14/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) doneButtonClicked:(id) sender
{
    // Get the local context
    
    
    
    // Create a new Person in the current thread context
    
    
    if(self.itemNameField.text !=  nil && ![self.itemNameField.text isEqualToString:@""])
    {
        
        
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
            
            // Do your work to be saved here
            Item *foodItem   = [Item MR_createEntityInContext:localContext];
            
            foodItem.name = [self.itemNameField.text lowercaseString];
            foodItem.currentSupply = [self.totalSupplyField.text intValue];
            foodItem.totalSupply = [self.totalSupplyField.text intValue];
            foodItem.price = [self.itemPriceField.text doubleValue];
            foodItem.dateAdded = [NSDate date];
            
            
            NSLog(@"date added %f",foodItem.dateAdded.timeIntervalSince1970);
        }];
        
        NSLog(@"You successfully saved your context.");
        NSLog(@"Database location: %@\n",[NSPersistentStore MR_urlForStoreName:[MagicalRecord defaultStoreName]]);
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.itemList addObject:[self.itemNameField.text lowercaseString]];
        
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [(UITabBarController *) appDelegate.window.rootViewController setSelectedIndex: 0];
        }];
        
        
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
