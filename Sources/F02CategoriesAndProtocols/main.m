#import <Foundation/Foundation.h>
#import "NSString+PFStudyFormatting.h"
#import "PFReminder.h"

@interface PFReminderLogger : NSObject <PFReminderDelegate>
@end

@implementation PFReminderLogger

- (void)reminderDidFinishWithTitle:(NSString *)title {
    NSLog(@"reminder finished -> %@", [title pf_titleCaseLabel]);
}

@end

int main(void) {
    @autoreleasepool {
        PFReminder *reminder = [[PFReminder alloc] initWithTitle:@"protocol and category practice"];
        PFReminderLogger *logger = [[PFReminderLogger alloc] init];
        reminder.delegate = logger;
        [reminder start];
    }
    return 0;
}
