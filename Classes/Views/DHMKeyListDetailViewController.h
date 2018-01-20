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
#import "DHMApiKeyModel.h"
#import "DHMKeyListTableViewController.h"

// TODO : This should inherit from DHMSingleCommandViewController
@interface DHMKeyListDetailViewController : UIViewController<NewApiKeyGenerator>

/**
 * Gets the resulting API key object or nil if not validated.
 */
@property (nonatomic) DHMApiKeyModel* keyToSave;

/**
 * Source controller requesting the new API key.
 */
@property (weak) id apiKeyReceiver;

@end
