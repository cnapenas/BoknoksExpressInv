//
//  FirstViewController.h
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/13/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView * foodItemsTableView;
@property (nonatomic,weak) IBOutlet UIButton * filterButton;
@property (nonatomic,weak) IBOutlet UIDatePicker * datePicker;
@property (nonatomic,weak) IBOutlet UILabel * sumOfTotalSalesLabel;


- (IBAction)filterButtonClicked:(id)sender;
- (void) reloadTable;

@end

