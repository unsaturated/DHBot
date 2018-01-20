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

#import "DHMListImagesPsCommand.h"

@implementation DHMListImagesPsCommand

+(NSString*) command { return DHM_PS_LIST_IMAGES; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"VM Images", @"VM Images - the command name itself");
        mCommandDesc = NSLocalizedString(@"Lists VM image types", @"Lists virtual machine (VM) image types");
        mRunningText = NSLocalizedString(@"Getting VM images...", @"In-progress text for getting the virtual machine (VM) images");
        mEnabled = NO;
        mRequiresUserSelection = NO;
        mPointCost = 1;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

@end
