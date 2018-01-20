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

#import "DHMCommandHistoryModel.h"
#import "DHMApi.h"

@implementation DHMCommandHistoryModel

+ (id)entryWithKey:(NSString *)key command:(NSString *)cmd date:(NSDate *)date
{
    DHMCommandHistoryModel* obj = [[DHMCommandHistoryModel alloc] init];
    obj.apiKey = [key copy];
    obj.command = [cmd copy];
    obj.date = [date copy];
    
    // Perform a quick command name look-up here as it's created
    DHMBaseCommand* bc = [[DHMApi sharedInstance] commandFromCommandName:obj.command];
    obj.commandName = [bc.commandName copy];
    
    return obj;
}

+ (void)saveApiHistoryLocally:(NSArray *)apiHistory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *modelDocPath = [documentsDirectory stringByAppendingPathComponent:DHM_HISTMODEL_STORE_NAME];
    
    // Set up the encoder and storage for the key model
    NSMutableData *historyModelData = [[NSMutableData alloc] init];
    NSKeyedArchiver *encoder =[[NSKeyedArchiver alloc] initForWritingWithMutableData:historyModelData];
    
    NSError *resultError = nil;
    
    // Archive our object
    UInt16 i = 0;
    for (DHMCommandHistoryModel* obj in apiHistory)
    {
        [encoder encodeObject:obj forKey:[NSString stringWithFormat:@"hist%d", i]];
        i++;
    }
    
    // Finish encoding and write to the DHM_HISTMODEL_STORE_NAME file
    [encoder finishEncoding];
    [historyModelData writeToFile:modelDocPath options:NSDataWritingFileProtectionComplete error:&resultError];
}

+ (NSArray *)loadApiHistoryLocally
{
    // Check to see if there is a gameState.dat file.  If there is then load the contents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Check to see if the DHM_HISTMODEL_STORE_NAME file exists and if so load the contents
    NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:DHM_HISTMODEL_STORE_NAME];
    NSData *histModelData = [[NSData alloc] initWithContentsOfFile:documentPath];
    
    if(histModelData)
    {
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:histModelData];
        
        NSMutableArray* wData = [NSMutableArray array];
        
        DHMCommandHistoryModel* histData = nil;
        UInt8 i = 0;
        do
        {
            histData = [decoder decodeObjectForKey:[NSString stringWithFormat:@"hist%d", i]];
            if(histData)
            {
                // TODO : This now seems redundant
                // Perform a quick command name look-up here as it's deserialized
                //DHMBaseCommand* cmd = [[DHMApi sharedInstance] commandFromCommandName:histData.command];
                //histData.commandName = [cmd.commandName copy];
                [wData addObject:histData];
            }
            
            i++;
        }
        while (histData != nil);
        
        
        // Finished decoding the objects
        [decoder finishDecoding];
        
        return [NSArray arrayWithArray:wData];
    }
    
    // The file doesn't exist
    return nil;
}

#pragma mark NSCoding Messages

-(id) initWithCoder:(NSCoder *)aDecoder
{
    NSString* k = (NSString*)[aDecoder decodeObjectForKey:DHM_HISTMODEL_API_KEY];
    NSString* c = (NSString*)[aDecoder decodeObjectForKey:DHM_HISTMODEL_CMD_KEY];
    NSDate* d = (NSDate*)[aDecoder decodeObjectForKey:DHM_HISTMODEL_DATE_KEY];
    
    return [DHMCommandHistoryModel entryWithKey:k command:c date:d];
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.apiKey forKey:DHM_HISTMODEL_API_KEY];
    [aCoder encodeObject:self.command forKey:DHM_HISTMODEL_CMD_KEY];
    [aCoder encodeObject:self.date forKey:DHM_HISTMODEL_DATE_KEY];
}

#pragma mark NSCopying

/**
 * Deep copy of the object. This can (and should) be called with
 * the convenience/alias message "copy".
 */
-(id) copyWithZone:(NSZone *)zone
{
    DHMCommandHistoryModel *cpy = [DHMCommandHistoryModel entryWithKey:self.apiKey
                                                               command:self.command
                                                                  date:self.date];
    
    return cpy;
}

@end
