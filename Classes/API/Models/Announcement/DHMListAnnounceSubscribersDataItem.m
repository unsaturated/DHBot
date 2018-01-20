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

#import "DHMListAnnounceSubscribersDataItem.h"
#import "DHMErrorData.h"

@implementation DHMListAnnounceSubscribersDataItem

+(RKObjectMapping*) objectMappingForREST
{
    // All object mappings should include an error mapping
    RKObjectMapping *errorMapping = [DHMErrorData objectMappingForREST];
    
    // Top level mapping for a valid item
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DHMListAnnounceSubscribersDataItem class]];
    
    // The data property within the valid item
    RKObjectMapping *dataMapping = [RKObjectMapping mappingForClass:[DHMListAnnounceSubscribersDataItem class]];
    
    // From service        : Property on class
    // @IncomingIdentifier : @LocalIdentifier
    [dataMapping addAttributeMappingsFromDictionary:@{
                                                      @"email": @"email",
                                                      @"confirmed": @"confirmed",
                                                      @"subscribe_date": @"subscribeDate",
                                                      @"name": @"name",
                                                      @"num_bounces": @"numberBounces"
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
    RKObjectMapping *mapping = [DHMListAnnounceSubscribersDataItem objectMappingForREST];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

@synthesize email;
@synthesize confirmed;
@synthesize subscribeDate;
@synthesize name;
@synthesize numberBounces;

@end
