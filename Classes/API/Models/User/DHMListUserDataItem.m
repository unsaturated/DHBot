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

#import "DHMListUserDataItem.h"
#import "DHMErrorData.h"

@implementation DHMListUserDataItem

+(RKObjectMapping*) objectMappingForREST
{
    // All object mappings should include an error mapping
    RKObjectMapping *errorMapping = [DHMErrorData objectMappingForREST];
    
    // Top level mapping for a valid item
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DHMListUserDataItem class]];
    
    // The data property within the valid item
    RKObjectMapping *dataMapping = [RKObjectMapping mappingForClass:[DHMListUserDataItem class]];
    
    // From service        : Property on class
    // @IncomingIdentifier : @LocalIdentifier
    [dataMapping addAttributeMappingsFromDictionary:@{
     @"account_id": @"accountID",
     @"quota_mb": @"diskQuotaMB",
     @"disk_used_mb": @"diskUsedMB",
     @"username": @"user"
     }];
    
    [mapping addAttributeMappingsFromArray:@[@"result", @"reason"]];
    [dataMapping addAttributeMappingsFromArray:@[ @"gecos", @"home", @"shell", @"type"]];
    
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
    RKObjectMapping *mapping = [DHMListUserDataItem objectMappingForREST];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

@synthesize accountID;
@synthesize user;
@synthesize type;
@synthesize shell;
@synthesize home;
@synthesize diskUsedMB;
@synthesize diskQuotaMB;
@synthesize gecos;

- (NSString *)diskUsedMBWithQuota:(BOOL)showQuota
{
    // Don't calculate if the data is uninitialized
    if(!self.diskQuotaMB || !self.diskUsedMB)
        return @"";
    
    // First determine if a quota is even present (non-zero)
    BOOL hasQuota = (diskQuotaMB.floatValue > 0.0);
    
    // Convert the MB values to bytes for the converter
    long long used = self.diskUsedMB.floatValue * 1000000;
    long long quota = self.diskQuotaMB.floatValue * 1000000;
 
    if(showQuota && hasQuota)
    {
        // Show the quota since it's present and requested
        return [NSString stringWithFormat:@"%@ / %@",
                [NSByteCountFormatter stringFromByteCount:used countStyle:NSByteCountFormatterCountStyleFile],
                [NSByteCountFormatter stringFromByteCount:quota countStyle:NSByteCountFormatterCountStyleFile]];
    }
    else
    {
        // Just show the disk usage
        return [NSByteCountFormatter stringFromByteCount:used countStyle:NSByteCountFormatterCountStyleFile];
    }
    
    // Fallback in case nothing works
    return @"";
}


@end
