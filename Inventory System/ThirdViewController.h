//
//  ThirdViewController.h
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/17/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView * foodItemsTableView;

- (IBAction)delete:(id)sender;

@end
