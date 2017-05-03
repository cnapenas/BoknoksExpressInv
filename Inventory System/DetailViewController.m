//
//  DetailViewController.m
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/14/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemName.text = self.foodItem.name;
    self.totalSupplyField.text = [NSString stringWithFormat:@"%d",self.foodItem.totalSupply];
    self.currentSupplyField.text = [NSString stringWithFormat:@"%d",self.foodItem.currentSupply];
    self.itemPriceField.text = [NSString stringWithFormat:@"%.2f",self.foodItem.price];
    self.totalSoldLabelValue.text = [NSString stringWithFormat:@"%.2f",(self.foodItem.totalSupply-self.foodItem.currentSupply) *  self.foodItem.price];
    
}

#pragma mark - Action Methods

- (IBAction) doneButtonClicked:(id) sender
{
    
    NSString *attributeName  = @"dateAdded";
    NSString *attributeName2 = @"name";
    NSDate *oldDate = [NSDate date];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:oldDate];
    comps.hour   = 0;
    comps.minute = 0;
    comps.second = 1;
    NSDate *startDate = [calendar dateFromComponents:comps];
    NSDate *endDate = [startDate dateByAddingTimeInterval:86400];
    
    NSLog(@"START DATE %@\n",startDate);
    NSLog(@"END DATE %@\n",endDate);
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        NSPredicate *itemWithDateFilter   = [NSPredicate predicateWithFormat:@"((%K >= %@) && (%K < %@)) && (%K  == %@) ",
                                             attributeName, startDate,attributeName,endDate,attributeName2,self.foodItem.name];
        
        
        Item * food = [Item MR_findFirstWithPredicate:itemWithDateFilter inContext:localContext];
        
        
        
        food.currentSupply = self.currentSupplyField.text.intValue;
        food.totalSupply = self.totalSupplyField.text.intValue;
        food.price = self.itemPriceField.text.floatValue;
    }];
    
    NSLog(@"You successfully saved your context.");
    NSLog(@"Database location: %@\n",[NSPersistentStore MR_urlForStoreName:[MagicalRecord defaultStoreName]]);
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
