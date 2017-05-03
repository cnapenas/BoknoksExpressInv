//
//  ThirdViewController.m
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/17/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import "ThirdViewController.h"
#import "CustomTableViewCell.h"

@interface ThirdViewController ()

@property (nonatomic,strong) NSArray * inventoryArray;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.foodItemsTableView.rowHeight = 45;
    self.foodItemsTableView.scrollEnabled = YES;
    self.foodItemsTableView.userInteractionEnabled = YES;
    self.foodItemsTableView.bounces = YES;
    self.foodItemsTableView.delegate = self;
    self.foodItemsTableView.dataSource = self;
}

- (void) viewDidAppear:(BOOL)animated
{
    self.inventoryArray = [Item MR_findAllSortedBy:@"dateAdded"
                                             ascending:YES];
    
    [self.foodItemsTableView reloadData];
}

- (IBAction)delete:(id)sender
{
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        int deleteLimit = 0;
        for(Item * foodItem in self.inventoryArray)
        {
            
            [foodItem MR_deleteEntityInContext:localContext];
            deleteLimit++;
            
            if (deleteLimit >= 10) {
                break;
            }
        }
        
    }];
    
    self.inventoryArray = [Item MR_findAllSortedBy:@"dateAdded"
                                         ascending:YES];
    
    [self.foodItemsTableView reloadData];
    
    
    
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
