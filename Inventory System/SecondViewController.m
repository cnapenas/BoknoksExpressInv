//
//  SecondViewController.m
//  Inventory System
//
//  Created by Charisse Marie Napenas on 4/13/17.
//  Copyright © 2017 Charisse Marie Napenas. All rights reserved.
//

#import "SecondViewController.h"
#import "AddViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addItem:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AddViewController *avc = [storyboard instantiateViewControllerWithIdentifier:@"addView"];
    [self presentViewController:avc animated:YES completion:^{
        
    }];
    
    
}


@end
