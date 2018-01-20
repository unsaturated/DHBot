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

#import <UIKit/UIKit.h>

@protocol NewApiKeyReceiver <NSObject>

@required
/**
 * Object that will use the generated API key, and perform some activity with it.
 */
-(void) setupForNewApiKey;

@end

/**
 * Defines the objects that will generate a new API key.
 */
@protocol NewApiKeyGenerator <NSObject>

@required
/**
 * Object that will receive the generated key upon completion.
 */
@property (weak) id apiKeyReceiver;

@end

@interface DHMKeyListTableViewController : UITableViewController<NewApiKeyReceiver>

/**
 * Gets or sets the array of API keys.
 */
@property (strong, nonatomic) NSMutableArray* keys;

/**
 Gets or sets whether the API keys should only be partially displayed.
 */
@property (readwrite, nonatomic) BOOL partialDisplayApiKeys;

@end
