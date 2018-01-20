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

#import "DHMListSizeHistoryPsCommand.h"

@implementation DHMListSizeHistoryPsCommand

+(NSString*) command { return DHM_PS_LIST_SIZE_HIST; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Size History", @"Size History - the command name itself");
        mCommandDesc = NSLocalizedString(@"Lists the private server size history", @"Lists the private server size history");
        mRunningText = NSLocalizedString(@"Getting size history...", @"In-progress text for getting the server size history");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 1;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

/**
 * Returns the valid parameters.
 *
 * ps : the name of the ps (get it from list_ps)
 */
-(NSArray*) acceptableParameters { return @[@"ps"]; }

-(BOOL) requiresGuid { return NO; }

@end
