#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PFMVPStudyPlannerView <NSObject>
- (void)displayLines:(NSArray<NSString *> *)lines title:(NSString *)title;
- (void)displaySavedPath:(nullable NSString *)path;
@end

@interface PFMVPConsoleView : NSObject <PFMVPStudyPlannerView>
@end

NS_ASSUME_NONNULL_END
