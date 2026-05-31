#import "PFMVCStudyTask.h"

NSString *PFMVCStudyTaskStateLabel(PFMVCStudyTaskState state) {
    switch (state) {
        case PFMVCStudyTaskStateTodo:
            return @"todo";
        case PFMVCStudyTaskStateBlocked:
            return @"blocked";
        case PFMVCStudyTaskStateDone:
            return @"done";
    }
}

@implementation PFMVCStudyTask

- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
                     priority:(NSInteger)priority
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFMVCStudyTaskState)state {
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
        @"state": PFMVCStudyTaskStateLabel(self.state)
    };
}

@end
