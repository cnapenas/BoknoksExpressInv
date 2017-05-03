//
//  AddViewController.h
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/14/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton * doneButton;
@property (nonatomic,weak) IBOutlet UILabel * itemNameLabel;
@property (nonatomic,weak) IBOutlet UILabel * totalSupplyLabel;
@property (nonatomic,weak) IBOutlet UILabel * itemPriceLabel;
@property (nonatomic,weak) IBOutlet UITextField * itemNameField;
@property (nonatomic,weak) IBOutlet UITextField * totalSupplyField;
@property (nonatomic,weak) IBOutlet UITextField * itemPriceField;

- (IBAction) doneButtonClicked:(id) sender;

@end
