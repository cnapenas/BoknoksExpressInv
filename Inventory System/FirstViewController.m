//
//  FirstViewController.m
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/13/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import "FirstViewController.h"
#import "CustomTableViewCell.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()


@property (nonatomic,strong) NSArray * inventoryArray;
@property (nonatomic,strong) NSDate * dateSelected;
@property (nonatomic,assign) float sumOfTotalSales;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.foodItemsTableView.rowHeight = 45;
    self.foodItemsTableView.scrollEnabled = YES;
    self.foodItemsTableView.userInteractionEnabled = YES;
    self.foodItemsTableView.bounces = YES;
    self.foodItemsTableView.delegate = self;
    self.foodItemsTableView.dataSource = self;
    
    
    
    
}

- (void) reloadTable
{
    NSString *attributeName  = @"dateAdded";
    self.sumOfTotalSales = 0;
    
    
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
    
    NSPredicate *itemsWithDateFilter   = [NSPredicate predicateWithFormat:@"(%K >= %@) && (%K < %@)",
                                          attributeName, startDate,attributeName,endDate];
    
    
    self.inventoryArray = [Item MR_findAllWithPredicate:itemsWithDateFilter];
    
    
    if(self.inventoryArray == nil || self.inventoryArray.count <= 0)
    {
        [self createDefaultList];
        self.inventoryArray = [Item MR_findAllWithPredicate:itemsWithDateFilter];
        self.inventoryArray = [self.inventoryArray sortedArrayUsingDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES] ] ];
    }
    else
    {
        self.inventoryArray = [self.inventoryArray sortedArrayUsingDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES] ] ];
    }
    
    
    
    
   
    for (Item * itemInArray in self.inventoryArray)
    {
        self.sumOfTotalSales += ((itemInArray.totalSupply-itemInArray.currentSupply)*itemInArray.price);
    }
    
    [self.foodItemsTableView reloadData];
    self.sumOfTotalSalesLabel.text = [NSString stringWithFormat:@"Total Sales: %.2f ",self.sumOfTotalSales];
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [self reloadTable];
    
}


- (void) createDefaultList
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *attributeName  = @"dateAdded";
    NSString *attributeName2 = @"name";
    NSDate *oldDate = [NSDate date];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:oldDate];
    comps.hour   = 0;
    comps.minute = 0;
    comps.second = 1;
    NSDate *endDate = [calendar dateFromComponents:comps];
    NSDate *startDate = [endDate dateByAddingTimeInterval:-86400];
    
    
    NSLog(@"START DATE %@\n",startDate);
    NSLog(@"END DATE %@\n",endDate);
    
    for(NSString * itemName in appDelegate.itemList)
    {
        
        
       [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
           NSPredicate *itemWithDateFilter   = [NSPredicate predicateWithFormat:@"((%K >= %@) && (%K < %@)) && (%K  == %@) ",
                                                attributeName, startDate,attributeName,endDate,attributeName2,itemName];
           
           
           Item * testItem = [Item MR_findFirstWithPredicate:itemWithDateFilter inContext:localContext];
           
           if(testItem != nil)
           {
               // Do your work to be saved here
               Item *foodItem   = [Item MR_createEntityInContext:localContext];
               
               foodItem.name = testItem.name;
               foodItem.totalSupply = testItem.currentSupply;
               foodItem.currentSupply = testItem.currentSupply;
               foodItem.price = testItem.price;
               foodItem.dateAdded = [NSDate date];
               
               NSLog(@"date added %f",foodItem.dateAdded.timeIntervalSince1970);
           }
           else
           {
               Item *foodItem   = [Item MR_createEntityInContext:localContext];
               
               foodItem.name = itemName;
               foodItem.totalSupply = 0;
               foodItem.currentSupply = 0;
               foodItem.price = 0;
               foodItem.dateAdded = [NSDate date];
               
               NSLog(@"date added %f",foodItem.dateAdded.timeIntervalSince1970);
           }
           
           NSLog(@"You successfully saved your context.");
           NSLog(@"Database location: %@\n",[NSPersistentStore MR_urlForStoreName:[MagicalRecord defaultStoreName]]);
       }];
        
        
        
    }
}


#pragma mark - Action methods

- (IBAction)filterButtonClicked:(id)sender
{
    if(self.datePicker.hidden)
    {
        self.datePicker.hidden = false;
        self.foodItemsTableView.hidden = true;
        [self.filterButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        self.datePicker.hidden = true;
        self.foodItemsTableView.hidden = false;
        [self.filterButton setTitle:@"Filter By Date" forState:UIControlStateNormal];
        
        
        
        
        NSString *attributeName  = @"dateAdded";
        
        NSDate *oldDate = self.dateSelected;
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
        
        NSPredicate *itemsWithDateFilter   = [NSPredicate predicateWithFormat:@"(%K >= %@) AND (%K < %@)",
                                              attributeName, startDate,attributeName,endDate];
        
        
        
        
        self.inventoryArray = [Item MR_findAllWithPredicate:itemsWithDateFilter];

        self.inventoryArray = [self.inventoryArray sortedArrayUsingDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES] ] ];
        [self.foodItemsTableView reloadData];
        
    }
    
}

- (IBAction)datePickerChanged:(id)sender
{
    self.dateSelected = self.datePicker.date;
}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inventoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomTableViewCell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Item * foodItem = [self.inventoryArray objectAtIndex:indexPath.row];
    
    cell.itemName.text = [NSString stringWithFormat:@"%@",foodItem.name];
    cell.itemSupply.text = [NSString stringWithFormat:@"%d",foodItem.totalSupply];
    cell.itemRemaining.text = [NSString stringWithFormat:@"%d",foodItem.currentSupply];
    cell.pricePerItem.text = [NSString stringWithFormat:@"%.2f",foodItem.price];
    cell.totalSales.text = [NSString stringWithFormat:@"%.2f",(foodItem.totalSupply-foodItem.currentSupply)*foodItem.price];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    dvc.foodItem = [self.inventoryArray objectAtIndex:indexPath.row];
    [self presentViewController:dvc animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
