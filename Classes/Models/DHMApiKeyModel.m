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

#import "DHMApiKeyModel.h"
#import "DHMBaseCommand.h"

@implementation DHMApiKeyModel
{
    
}

#pragma mark Class Messages

+(id) entryWithKey:(NSString *)key description:(NSString*)desc commands:(NSArray*)cmds;
{
    DHMApiKeyModel* obj = [[DHMApiKeyModel alloc] init];
    obj.apiKey = [key copy];
    obj.description = [desc copy];
    obj.allowableCommands = [cmds copy];
    
    return obj;
}

+(void) saveApiKeysLocally:(NSArray *)apiKeys
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *modelDocPath = [documentsDirectory stringByAppendingPathComponent:DHM_KEYMODEL_STORE_NAME];
    
    // Set up the encoder and storage for the API key model
    NSMutableData *apiModelData = [[NSMutableData alloc] init];
    NSKeyedArchiver *encoder =[[NSKeyedArchiver alloc] initForWritingWithMutableData:apiModelData];
    
    NSError *resultError = nil;
    
    // Archive our object
    UInt8 i = 0;
    for (DHMApiKeyModel* obj in apiKeys)
    {
        [encoder encodeObject:obj forKey:[NSString stringWithFormat:@"api%d", i]];
        i++;
    }

    // Finish encoding and write to the DHM_KEYMODEL_STORE_NAME file
    [encoder finishEncoding];
    [apiModelData writeToFile:modelDocPath options:NSDataWritingFileProtectionComplete error:&resultError];
}

+(NSArray*) loadApiKeysLocally
{
    // Check to see if there is a gameState.dat file.  If there is then load the contents
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Check to see if the DHM_KEYMODEL_STORE_NAME file exists and if so load the contents
    NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:DHM_KEYMODEL_STORE_NAME];
    NSData *apiModelData = [[NSData alloc] initWithContentsOfFile:documentPath];
	
	if(apiModelData)
    {
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:apiModelData];
        
        NSMutableArray* wData = [NSMutableArray array];
        
        DHMApiKeyModel* apiKeyData = nil;
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

- (BOOL)hasCommand:(NSString *)name
{
    if(!self.allowableCommands)
    {
        return NO;
    }
    
    return [self.allowableCommands containsObject:name];
}

#pragma mark Properties

@synthesize apiKey;
@synthesize description;
@synthesize allowableCommands;

#pragma mark NSCoding Messages

-(id) initWithCoder:(NSCoder *)aDecoder
{
    NSString* k = (NSString*)[aDecoder decodeObjectForKey:DHM_KEYMODEL_API_KEY];
    NSString* d = (NSString*)[aDecoder decodeObjectForKey:DHM_KEYMODEL_DESC_KEY];
    NSArray* c = (NSArray*)[aDecoder decodeObjectForKey:DHM_KEYMODEL_CMDS_KEY];
    
    return [DHMApiKeyModel entryWithKey:k description:d commands:c];
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.apiKey forKey:DHM_KEYMODEL_API_KEY];
    [aCoder encodeObject:self.description forKey:DHM_KEYMODEL_DESC_KEY];
    [aCoder encodeObject:self.allowableCommands forKey:DHM_KEYMODEL_CMDS_KEY];
}

#pragma mark NSCopying

/**
 * Deep copy of the object. This can (and should) be called with 
 * the convenience/alias message "copy".
 */
-(id) copyWithZone:(NSZone *)zone
{
    DHMApiKeyModel *cpy = [DHMApiKeyModel
                           entryWithKey:self.apiKey
                           description:self.description
                           commands:self.allowableCommands];
    
    return cpy;
}

@end
