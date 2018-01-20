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

#import "DHMBaseCommand.h"
#import "DHMApi.h"
#import "DHMCommandCategory.h"

@implementation DHMBaseCommand

+(id) commandWithInternalDataAndCategory:(DHMCommandCategory*)cat;
{
    return [[self alloc] initWithCategory:cat];
}

-(id) init
{
    if( (self = [super init]) )
    {
        mCommandName = @"";
        mCommandDesc = NSLocalizedString(@"No description provided", @"Default command description if none provided");
        mDisabledReason = NSLocalizedString(@"Not Supported", @"Short note that a feature is not yet ready");
        mRunningText = @"";
        mEnabled = NO;
        mRequiresUserSelection = NO;
        mCommandCategory = kNoCategory;
        mCommandCategoryEnumName = @"";
    }
    
    return self;
}

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    // Sanity check to ensure sub-class implements message
    NSException* ex = [NSException exceptionWithName:@"Invalid Command" reason:@"Base command class has no category" userInfo:nil];
    [ex raise];
    
    return nil;
}

+(NSString*) command
{
    // Sanity check to ensure sub-class implements message
    NSException* ex = [NSException exceptionWithName:@"Invalid Command" reason:@"Base command class does not have a command" userInfo:nil];
    [ex raise];
    
    return nil;
}

-(NSString*) command
{
    if(mCommand == nil)
    {
        mCommand = [[self class] command];
    }
    
    return mCommand;
}

-(void) setCommand:(NSString*)str
{
    return;
}

@synthesize commandName = mCommandName;

@synthesize commandDesc = mCommandDesc;

@synthesize commandCategory = mCommandCategoryEnumName;

@synthesize commandURL = mCommandUrl;

@synthesize category = mCommandCategory;

@synthesize pointCost = mPointCost;

@synthesize enabled = mEnabled;

@synthesize disabledReason = mDisabledReason;

@synthesize runningText = mRunningText;

-(BOOL) returnsArray { return NO; }

-(BOOL) returnsErrors { return NO; }

-(NSArray*) acceptableParameters { return nil; }

@synthesize hasParameters = mHasParameters;

-(BOOL) requiresGuid { return NO; }

@synthesize requiresUserSelection = mRequiresUserSelection;

-(NSString*) buildQueryString
{
    return [[DHMApi sharedInstance] buildQueryWithCommand:self];
}

-(NSString*) buildQueryStringWithKey:(NSString *)key
{
    return [[DHMApi sharedInstance] buildQueryWithCommand:self usingKey:key];
}

@synthesize parameterDictionary = paramDictionary;

-(void) setParameterKey:(NSString *)key withValue:(NSString *)value
{
    // Check for commands that aren't setup properly or don't accept parameters
    NSAssert(self.acceptableParameters != nil, @"The command has no list of acceptable parameters");
    
    // Check for invalid keys
    NSAssert([self.acceptableParameters containsObject:key], ([NSString stringWithFormat:@"%@ is not a valid key", key]));
    
    // Everything checks out so lazy instantiate the dictionary
    if(paramDictionary == nil)
        paramDictionary = [NSMutableDictionary dictionary];
    
    // ...and add the key-value pair
    [paramDictionary setObject:value forKey:key];
    
    mHasParameters = YES;
}

@end
