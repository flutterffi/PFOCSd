#import "PFMVVMStudyTask.h"

NSString *PFMVVMStudyTaskStateLabel(PFMVVMStudyTaskState state) {
    switch (state) {
        case PFMVVMStudyTaskStateTodo:
            return @"todo";
        case PFMVVMStudyTaskStateBlocked:
            return @"blocked";
        case PFMVVMStudyTaskStateDone:
            return @"done";
    }
}

@implementation PFMVVMStudyTask

- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
                     priority:(NSInteger)priority
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFMVVMStudyTaskState)state {
    self = [super init];
    if (self) {
        _title = [title copy];
        _notes = [notes copy];
        _tags = [tags copy];
        _priority = priority;
        _estimatedMinutes = estimatedMinutes;
        _state = state;
    }
    return self;
}

- (NSDictionary<NSString *, id> *)dictionaryRepresentation {
    return @{
        @"title": self.title,
        @"notes": self.notes,
        @"tags": self.tags,
        @"priority": @(self.priority),
        @"estimatedMinutes": @(self.estimatedMinutes),
        @"state": PFMVVMStudyTaskStateLabel(self.state)
    };
}

@end
