/**
 * DH Bot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *  
 * DH Bot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with DH Bot. If not, see 
 * https://github.com/unsaturated/DHBot/blob/master/LICENSE.
 */

#import "DHMListMySqlUsersDataItem.h"
#import "DHMErrorData.h"

@implementation DHMListMySqlUsersDataItem

+(RKObjectMapping*) objectMappingForREST
{
    // All object mappings should include an error mapping
    RKObjectMapping *errorMapping = [DHMErrorData objectMappingForREST];
    
    // Top level mapping for a valid item
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DHMListMySqlUsersDataItem class]];
    
    // The data property within the valid item
    RKObjectMapping *dataMapping = [RKObjectMapping mappingForClass:[DHMListMySqlUsersDataItem class]];
    
    // From service        : Property on class
    // @IncomingIdentifier : @LocalIdentifier
    [dataMapping addAttributeMappingsFromDictionary:@{
                                                      @"account_id": @"accountId",
                                                      @"db": @"database",
                                                      @"description": @"description",
                                                      @"home": @"home",
                                                      @"username": @"username",
                                                      @"host": @"host",
                                                      @"alter_priv" : @"canAlter",
                                                      @"select_priv": @"canSelect",
                                                      @"insert_priv": @"canInsert",
                                                      @"update_priv": @"canUpdate",
                                                      @"delete_priv": @"canDelete",
                                                      @"create_priv": @"canCreate",
                                                      @"drop_priv": @"canDrop",
                                                      @"index_priv": @"canIndex"
                                                      }];
    
    [mapping addAttributeMappingsFromArray:@[@"result", @"reason"]];
    
    // Add the data mapping explicitly to the "data" path
    [mapping addRelationshipMappingWithSourceKeyPath:@"data" mapping:dataMapping];
    
    // Create a dynamic mapping so mapping accommodates error conditions
    RKDynamicMapping *dynMapping = [RKDynamicMapping new];
    [dynMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"result" expectedValue:@"success" objectMapping:mapping]];
    [dynMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"result" expectedValue:@"error" objectMapping:errorMapping]];
    
    return (RKObjectMapping*)dynMapping;
}

+(RKResponseDescriptor*) responseDescriptorForREST
{
    RKObjectMapping *mapping = [DHMListMySqlUsersDataItem objectMappingForREST];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

@synthesize accountId;
@synthesize database;
@synthesize home;
@synthesize username;
@synthesize host;
@synthesize canSelect;
@synthesize canInsert;
@synthesize canUpdate;
@synthesize canDelete;
@synthesize canCreate;
@synthesize canDrop;
@synthesize canIndex;
@synthesize canAlter;

@end
