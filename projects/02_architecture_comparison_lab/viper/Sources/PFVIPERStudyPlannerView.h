#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PFVIPERStudyPlannerView <NSObject>
- (void)displayLines:(NSArray<NSString *> *)lines title:(NSString *)title;
- (void)displayActionMessage:(NSString *)message;
- (void)displayMessage:(NSString *)message title:(NSString *)title;
@end

@interface PFVIPERConsoleView : NSObject <PFVIPERStudyPlannerView>
@end

NS_ASSUME_NONNULL_END
