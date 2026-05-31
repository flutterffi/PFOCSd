#import "PFMVVMConsoleView.h"

@implementation PFMVVMConsoleView

- (void)renderViewModels:(NSArray<PFMVVMStudyTaskViewModel *> *)viewModels title:(NSString *)title {
    [self renderViewModels:viewModels title:title emptyMessage:nil];
}

- (void)renderViewModels:(NSArray<PFMVVMStudyTaskViewModel *> *)viewModels
                   title:(NSString *)title
            emptyMessage:(NSString *)emptyMessage {
    NSLog(@"[MVVM] %@", title);
    if (viewModels.count == 0 && emptyMessage.length > 0) {
        NSLog(@"%@", emptyMessage);
        return;
    }
    NSUInteger index = 0;
    for (PFMVVMStudyTaskViewModel *viewModel in viewModels) {
        NSLog(@"%lu. %@ | %@",
              (unsigned long)(index + 1),
              viewModel.titleText,
              viewModel.detailText);
        index += 1;
    }
}

@end
