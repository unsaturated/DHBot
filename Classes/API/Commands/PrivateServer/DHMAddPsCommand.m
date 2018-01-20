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

#import "DHMAddPsCommand.h"

@implementation DHMAddPsCommand

+(NSString*) command { return DHM_PS_ADD; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add Server", @"Add Server - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a private server", @"Adds a private server");
        mRunningText = NSLocalizedString(@"Adding server...", @"In-progress text for adding a private server");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 4;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * account_id : what account you'd like to add this PS to (optional)
 * type       : either web or mysql
 * movedata   : if type is web, you must specify yes or no for
 *              whether you'd like to copy all your existing users to this new PS.
 */
-(NSArray*) acceptableParameters { return @[
                                            @"account_id",
                                            @"type",
                                            @"movedata"]; }

-(BOOL) requiresGuid { return YES; }

@end
