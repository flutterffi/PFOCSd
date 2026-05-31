#import <Foundation/Foundation.h>
#import "PFMVVMStudyTaskViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVVMConsoleView : NSObject
- (void)renderViewModels:(NSArray<PFMVVMStudyTaskViewModel *> *)viewModels title:(NSString *)title;
- (void)renderViewModels:(NSArray<PFMVVMStudyTaskViewModel *> *)viewModels
                   title:(NSString *)title
            emptyMessage:(nullable NSString *)emptyMessage;
@end

NS_ASSUME_NONNULL_END
