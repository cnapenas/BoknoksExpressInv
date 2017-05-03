//
//  Item+CoreDataProperties.h
//  
//
//  Created by Charisse Marie Napenas on 4/16/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Item+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest;

@property (nonatomic) int16_t currentSupply;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double price;
@property (nonatomic) int16_t totalSupply;
@property (nullable, nonatomic, copy) NSDate *dateAdded;

@end

NS_ASSUME_NONNULL_END
