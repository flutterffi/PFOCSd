#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PFReminderDelegate <NSObject>
- (void)reminderDidFinishWithTitle:(NSString *)title;
@end

@interface PFReminder : NSObject
@property (nonatomic, weak, nullable) id<PFReminderDelegate> delegate;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithTitle:(NSString *)title;
- (void)start;
@end

NS_ASSUME_NONNULL_END
