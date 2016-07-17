//
//  KSCalendarConstants.h
//  Akvamarin
//
//  Created by KulikovS on 14.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#ifndef KSCalendarConstants_h
#define KSCalendarConstants_h

static NSString * const kKSStudioBusyKey        = @"Фотостудия забронирована";

static NSString * const kKSDateFormatKey        = @"yyyy-MM-dd'T'HH:mm:ssZZZZZZ";
static NSString * const kKSStartDateTimeKey     = @"start.dateTime";
static NSString * const kKSEndDateTimeKey       = @"end.dateTime";
static NSString * const kKSItemsKey             = @"items";
static NSString * const kKSHTTPMethod           = @"GET";
static NSString * const kKSCalendarId           = @"ubvnm5gta74qgg9vrfclv99nl4@group.calendar.google.com";
static NSString * const kKSApiKey               = @"AIzaSyDtYcy1F9oeUXwjREGM5YnlndEGn0d_luM";
static NSString * const kKSTitleFormat          = @"c %d:%d до %d:%d %@";
static NSString * const kKSCalendarUrlFormat    = @"https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,end,summary,status)";

#endif /* KSCalendarConstants_h */
