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

#import "DHMApiKeyServiceModel.h"

@implementation DHMApiKeyServiceModel
{

}

#pragma mark Class Messages

+ (id)entryWithKey:(NSString *)key commandName:(NSString *)name token:(NSString *)token
{
    DHMApiKeyServiceModel* obj = [[DHMApiKeyServiceModel alloc] init];
    obj.apiKey = [key copy];
    obj.commandName = [name copy];
    obj.token = [token copy];
    
    return obj;
}

+(void) saveTokensLocally:(NSArray *)tokens
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *modelDocPath = [documentsDirectory stringByAppendingPathComponent:DHM_SERVICEMODEL_STORE_NAME];
    
    // Set up the encoder and storage for the API key model
    NSMutableData *apiModelData = [[NSMutableData alloc] init];
    NSKeyedArchiver *encoder =[[NSKeyedArchiver alloc] initForWritingWithMutableData:apiModelData];
    
    NSError *resultError = nil;
    
    // Archive our object
    UInt8 i = 0;
    for (DHMApiKeyServiceModel* obj in tokens)
    {
        [encoder encodeObject:obj forKey:[NSString stringWithFormat:@"api%d", i]];
        i++;
    }
    
    // Finish encoding and write to the DHM_KEYMODEL_STORE_NAME file
    [encoder finishEncoding];
    [apiModelData writeToFile:modelDocPath options:NSDataWritingFileProtectionComplete error:&resultError];
}

+(NSArray*) loadTokensLocally
{
    // Check to see if there is a gameState.dat file.  If there is then load the contents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Check to see if the DHM_KEYMODEL_STORE_NAME file exists and if so load the contents
    NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:DHM_SERVICEMODEL_STORE_NAME];
    NSData *apiModelData = [[NSData alloc] initWithContentsOfFile:documentPath];
    
    if(apiModelData)
    {
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:apiModelData];
        
        NSMutableArray* wData = [NSMutableArray array];
        
        DHMApiKeyServiceModel* apiKeyData = nil;
        UInt8 i = 0;
        do
        {
            apiKeyData = [decoder decodeObjectForKey:[NSString stringWithFormat:@"api%d", i]];
            if(apiKeyData)
                [wData addObject:apiKeyData];
            i++;
        }
        while (apiKeyData != nil);
        
        
        // Finished decoding the objects
        [decoder finishDecoding];
        
        return [NSArray arrayWithArray:wData];
    }
    
    // The file doesn't exist
    return nil;
}

#pragma mark Properties

@synthesize apiKey;
@synthesize commandName;
@synthesize token;

#pragma mark NSCoding Messages

-(id) initWithCoder:(NSCoder *)aDecoder
{
    NSString* k = (NSString*)[aDecoder decodeObjectForKey:DHM_SERVICEMODEL_API_KEY];
    NSString* n = (NSString*)[aDecoder decodeObjectForKey:DHM_SERVICEMODEL_NAME_KEY];
    NSString* t = (NSString*)[aDecoder decodeObjectForKey:DHM_SERVICEMODEL_TOKEN_KEY];
    
    return [DHMApiKeyServiceModel entryWithKey:k commandName:n token:t];
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.apiKey forKey:DHM_SERVICEMODEL_API_KEY];
    [aCoder encodeObject:self.commandName forKey:DHM_SERVICEMODEL_NAME_KEY];
    [aCoder encodeObject:self.token forKey:DHM_SERVICEMODEL_TOKEN_KEY];
}

#pragma mark NSCopying

/**
 * Deep copy of the object. This can (and should) be called with
 * the convenience/alias message "copy".
 */
-(id) copyWithZone:(NSZone *)zone
{
    DHMApiKeyServiceModel *cpy = [DHMApiKeyServiceModel
                                  entryWithKey:self.apiKey
                                  commandName:self.commandName
                                  token:self.token];
    
    return cpy;
}



@end