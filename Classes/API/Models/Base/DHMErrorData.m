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

#import "DHMErrorData.h"
#import "DHMListUserDataItem.h"

@implementation DHMErrorData

+(RKObjectMapping*) objectMappingForREST
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DHMErrorData class]];
    
    // If source and destination key path are the same, we can simply add a string to the array
    [mapping addAttributeMappingsFromArray:@[ @"reason", @"data", @"result" ]];
    
    return mapping;
}

+(RKResponseDescriptor*) responseDescriptorForREST
{
    RKObjectMapping *mapping = [DHMErrorData objectMappingForREST];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

-(NSString*) errorResult
{
    return self.result;
}

-(NSString*) errorReason
{
    return self.reason;
}

-(NSString*) errorData
{
    return [NSString stringWithFormat:@"%@",self.data[0]];
}

@end
