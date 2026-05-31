#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFExercise : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger estimatedMinutes;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy, nullable) NSString *notes;

+ (nullable instancetype)exerciseFromDictionary:(NSDictionary<NSString *, id> *)dictionary
                                          error:(NSError **)error;
- (NSString *)summary;
@end

NS_ASSUME_NONNULL_END
