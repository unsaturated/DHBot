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

#import "DHMSetSizePsCommand.h"

@implementation DHMSetSizePsCommand

+(NSString*) command { return DHM_PS_SET_SIZE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Set Server Size", @"Set Server Size - the command name itself");
        mCommandDesc = NSLocalizedString(@"Sets size of private server", @"Sets the size of the private server");
        mRunningText = NSLocalizedString(@"Setting server size...", @"In-progress text for setting the server size");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 3;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * ps : the name of the ps (get it from list_ps)
 * size : the new size you'd like for your PS, in MB between 300 and 4000
 */
-(NSArray*) acceptableParameters { return @[
                                            @"ps",
                                            @"size"]; }

-(BOOL) requiresGuid { return YES; }

@end
