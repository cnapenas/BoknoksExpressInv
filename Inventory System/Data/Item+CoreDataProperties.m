//
//  Item+CoreDataProperties.m
//  
//
//  Created by Charisse Marie Napenas on 4/16/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Item+CoreDataProperties.h"

@implementation Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Item"];
}

@dynamic currentSupply;
@dynamic name;
@dynamic price;
@dynamic totalSupply;
@dynamic dateAdded;

@end
