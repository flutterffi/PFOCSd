#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFVIPERStudyPlannerRouter : NSObject
- (NSString *)titleForInitialList;
- (NSString *)titleForFilteredListWithTag:(NSString *)tag;
- (NSString *)titleForFilteredListWithTag:(nullable NSString *)tag state:(nullable NSNumber *)state;
- (NSString *)emptyMessageForTag:(nullable NSString *)tag state:(nullable NSNumber *)state;
- (NSString *)messageForSavedPath:(nullable NSString *)path;
- (NSString *)messageForReloadResult:(BOOL)success;
@end

NS_ASSUME_NONNULL_END
