//
//  KSCalendarViewController.m
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"

#import "KSCalendarViewController.h"
#import "KSCalendarView.h"


static NSString *const kKeychainItemName = @"Akvamarin";
static NSString *const kClientID         = @"543091447100-tq0hk9k42t07d2udfgvsqhoftlo7bi5q.apps.googleusercontent.com";

@interface KSCalendarViewController ()
@property (nonatomic, readonly) KSCalendarView *rootView;

@property (nonatomic, strong) GTLServiceCalendar *service;
@property (nonatomic, strong) UITextView *output;

@end

@implementation KSCalendarViewController

@dynamic rootView;

@synthesize service = _service;
@synthesize output  = _output;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSCalendarView);

#pragma mark -
#pragma mark View LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Private Methods

// When the view loads, create necessary subviews, and initialize the Google Calendar API service.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a UITextView to display output.
    self.output = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.output.editable = false;
    self.output.contentInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
    self.output.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.output];
    
    // Initialize the Google Calendar API service & load existing credentials from the keychain if available.
    self.service = [[GTLServiceCalendar alloc] init];
    self.service.authorizer =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientID
                                                      clientSecret:nil];
}

// When the view appears, ensure that the Google Calendar API service is authorized, and perform API calls.
- (void)viewDidAppear:(BOOL)animated {
    if (!self.service.authorizer.canAuthorize) {
        // Not yet authorized, request authorization by pushing the login UI onto the UI stack.
        [self presentViewController:[self createAuthController] animated:YES completion:nil];
        
    } else {
        [self fetchEvents];
    }
}

// Construct a query and get a list of upcoming events from the user calendar. Display the
// start dates and event summaries in the UITextView.
- (void)fetchEvents {
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsListWithCalendarId:@"primary"];
    query.maxResults = 10;
    query.timeMin = [GTLDateTime dateTimeWithDate:[NSDate date]
                                         timeZone:[NSTimeZone localTimeZone]];;
    query.singleEvents = YES;
    query.orderBy = kGTLCalendarOrderByStartTime;
    
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}

- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    if (error == nil) {
        NSMutableString *eventString = [[NSMutableString alloc] init];
        if (events.items.count > 0) {
            [eventString appendString:@"Upcoming 10 events:\n"];
            for (GTLCalendarEvent *event in events) {
                GTLDateTime *start = event.start.dateTime ?: event.start.date;
                NSString *startString =
                [NSDateFormatter localizedStringFromDate:[start date]
                                               dateStyle:NSDateFormatterShortStyle
                                               timeStyle:NSDateFormatterShortStyle];
                [eventString appendFormat:@"%@ - %@\n", startString, event.summary];
            }
        } else {
            [eventString appendString:@"No upcoming events found."];
        }
        self.output.text = eventString;
    } else {
        [self showAlert:@"Error" message:error.localizedDescription];
    }
}



// Creates the auth controller for authorizing access to Google Calendar API.
- (GTMOAuth2ViewControllerTouch *)createAuthController {
    GTMOAuth2ViewControllerTouch *authController;
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    NSArray *scopes = [NSArray arrayWithObjects:kGTLAuthScopeCalendarReadonly, nil];
    authController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:[scopes componentsJoinedByString:@" "]
                      clientID:kClientID
                      clientSecret:nil
                      keychainItemName:kKeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and update the Google Calendar API
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
    if (error != nil) {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        self.service.authorizer = nil;
    }
    else {
        self.service.authorizer = authResult;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
     {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end

