#import <Foundation/Foundation.h>

@protocol PFReminderDelegate <NSObject>
- (void)reminderDidFinish:(NSString *)message;
@end

@interface PFReminder : NSObject
@property (nonatomic, weak) id<PFReminderDelegate> delegate;
- (void)start;
@end

@implementation PFReminder

- (void)start {
    [self.delegate reminderDidFinish:@"delegation callback finished"];
}

@end

@interface PFReminderLogger : NSObject <PFReminderDelegate>
@end

@implementation PFReminderLogger

- (void)reminderDidFinish:(NSString *)message {
    NSLog(@"%@", message);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PFReminder *reminder = [[PFReminder alloc] init];
        PFReminderLogger *logger = [[PFReminderLogger alloc] init];
        reminder.delegate = logger;
        [reminder start];
    }
    return 0;
}
