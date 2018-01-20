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

#pragma once

/**
 * Defines the command categories.
 */
typedef enum CommandCategory : NSUInteger
{
    kNoCategory,
    kAPICategory,
    kAccountCategory,
    kUserCategory,
    kDomainCategory,
    kAnnouncementCategory,
    kMySQLCategory,
    kMailCategory,
    kDNSCategory,
    kRewardsCategory,
    kPrivateServerCategory,
    kServiceCategory,
    kJabberCategory
} CommandCategory;


#pragma mark API Commands
// ========================================================================
#define DHM_API_LIST_ACCESS      @"api-list_accessible_cmds"
#define DHM_API_LIST_KEYS        @"api-list_keys"

#pragma mark Account Commands
// ========================================================================
#define DHM_ACCT_GET_USAGE         @"account-domain_usage"
#define DHM_ACCT_LIST_KEYS         @"account-list_keys"
#define DHM_ACCT_GET_STATUS        @"account-status"
#define DHM_ACCT_GET_USER_USE      @"account-user_usage"

#pragma mark User Commands
// ========================================================================
#define DHM_USER_LIST        @"user-list_users_no_pw"
#define DHM_USER_ADD         @"user-add_user"
#define DHM_USER_REMOVE      @"user-remove_user"

#pragma mark Domain Commands
// ========================================================================
#define DHM_DOM_LIST_HOSTED      @"domain-list_domains"
#define DHM_DOM_LIST_REG         @"domain-list_registrations"
#define DHM_DOM_REG_AVAIL        @"domain-registration_available"

#pragma mark Announcement List Commands
// ========================================================================
#define DHM_LISTSRV_LIST               @"announcement_list-list_lists"
#define DHM_LISTSRV_USER_LIST          @"announcement_list-list_subscribers"
#define DHM_LISTSRV_ADD_PERSON         @"announcement_list-add_subscriber"
#define DHM_LISTSRV_REMOVE_PERSON      @"announcement_list-remove_subscriber"
#define DHM_LISTSRV_POST_MSG           @"announcement_list-post_announcement"

#pragma mark MySQL Commands
// ========================================================================
#define DHM_SQL_LIST_DBS         @"mysql-list_dbs"
#define DHM_SQL_LIST_HOSTS       @"mysql-list_hostnames"
#define DHM_SQL_ADD_HOST         @"mysql-add_hostname"
#define DHM_SQL_REMOVE_HOST      @"mysql-remove_hostname"
#define DHM_SQL_LIST_USERS       @"mysql-list_users"
#define DHM_SQL_ADD_USER         @"mysql-add_user"
#define DHM_SQL_REMOVE_USER      @"mysql-remove_user"

#pragma mark Mail Commands
// ========================================================================
#define DHM_MAIL_LIST_FILTERS       @"mail-list_filters"
#define DHM_MAIL_ADD_FILTER         @"mail-add_filter"
#define DHM_MAIL_REMOVE_FILTER      @"mail-remove_filter"

#pragma mark DNS Commands
// ========================================================================
#define DHM_DNS_LIST_RECS       @"dns-list_records"
#define DHM_DNS_ADD_REC         @"dns-add_record"
#define DHM_DNS_REMOVE_REC      @"dns-remove_record"

#pragma mark Rewards Commands
// ========================================================================
#define DHM_REW_ADD_CODE           @"rewards-add_promo_code"
#define DHM_REW_REMOVE_CODE        @"rewards-remove_promo_code"
#define DHM_REW_ENABLE_CODE        @"rewards-enable_promo_code"
#define DHM_REW_DISABLE_CODE       @"rewards-disable_promo_code"
#define DHM_REW_LIST_CODES         @"rewards-list_promo_codes"
#define DHM_REW_CODE_DETAIL        @"rewards-promo_details"
#define DHM_REW_REF_SUMMARY        @"rewards-referral_summary"
#define DHM_REW_REF_LOG            @"rewards-referral_log"

#pragma mark Private Server Commands
// ========================================================================
#define DHM_PS_ADD                 @"dreamhost_ps-add_ps"
#define DHM_PS_REMOVE              @"dreamhost_ps-remove_ps"
#define DHM_PS_LIST_PENDING        @"dreamhost_ps-list_pending_ps"
#define DHM_PS_REMOVE_PENDING      @"dreamhost_ps-remove_pending_ps"
#define DHM_PS_LIST                @"dreamhost_ps-list_ps"
#define DHM_PS_LIST_SETTINGS       @"dreamhost_ps-list_settings"
#define DHM_PS_SET_SETTINGS        @"dreamhost_ps-set_settings"
#define DHM_PS_LIST_SIZE_HIST      @"dreamhost_ps-list_size_history"
#define DHM_PS_SET_SIZE            @"dreamhost_ps-set_size"
#define DHM_PS_LIST_REBOOTS        @"dreamhost_ps-list_reboot_history"
#define DHM_PS_REBOOT              @"dreamhost_ps-reboot"
#define DHM_PS_LIST_USAGE          @"dreamhost_ps-list_usage"
#define DHM_PS_LIST_IMAGES         @"dreamhost_ps-list_images"

#pragma mark Services Commands
// ========================================================================
#define DHM_SERVICE_PROG        @"services-progress"
#define DHM_SERVICE_FLVENC      @"services-flvencoder"

#pragma mark Jabber Commands
// ========================================================================
#define DHM_JAB_LIST_USERS         @"jabber-list_users"
#define DHM_JAB_LIST_USERS_NOPASS  @"jabber-list_users_no_pw"
#define DHM_JAB_LIST_DOMAINS       @"jabber-list_valid_domains"
#define DHM_JAB_ADD_USER           @"jabber-add_user"
#define DHM_JAB_REMOVE_USER        @"jabber-remove_user"
#define DHM_JAB_REACTIVATE_USER    @"jabber-reactivate_user"
#define DHM_JAB_DEACTIVATE_USER    @"jabber-deactivate_user"

