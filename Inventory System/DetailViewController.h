//
//  DetailViewController.h
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/14/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton * doneButton;
@property (nonatomic,weak) IBOutlet UILabel * itemName;
@property (nonatomic,weak) IBOutlet UILabel * totalSupplyLabel;
@property (nonatomic,weak) IBOutlet UILabel * currentSupplyLabel;
@property (nonatomic,weak) IBOutlet UILabel * itemPriceLabel;
@property (nonatomic,weak) IBOutlet UILabel * totalSoldLabel;
@property (nonatomic,weak) IBOutlet UILabel * totalSoldLabelValue;
@property (nonatomic,weak) IBOutlet UITextField * totalSupplyField;
@property (nonatomic,weak) IBOutlet UITextField * currentSupplyField;
@property (nonatomic,weak) IBOutlet UITextField * itemPriceField;
@property (nonatomic,strong) Item * foodItem;


- (IBAction) doneButtonClicked:(id) sender;
@end
