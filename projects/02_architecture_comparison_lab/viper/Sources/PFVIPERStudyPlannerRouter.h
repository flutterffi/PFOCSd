#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFVIPERStudyPlannerRouter : NSObject
- (NSString *)titleForInitialList;
- (NSString *)titleForFilteredListWithTag:(NSString *)tag;
- (NSString *)messageForSavedPath:(nullable NSString *)path;
- (NSString *)messageForReloadResult:(BOOL)success;
@end

NS_ASSUME_NONNULL_END
