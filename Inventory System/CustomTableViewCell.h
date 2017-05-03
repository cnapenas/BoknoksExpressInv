//
//  CustomTableViewCell.h
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/13/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel * itemName;
@property (nonatomic,weak) IBOutlet UILabel * itemSupply;
@property (nonatomic,weak) IBOutlet UILabel * pricePerItem;
@property (nonatomic,weak) IBOutlet UILabel * totalSales;
@property (nonatomic,weak) IBOutlet UILabel * itemRemaining;

@end
