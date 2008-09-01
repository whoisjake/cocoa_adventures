//
//  Department.h
//  Departments
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Employee;

@interface Department :  NSManagedObject
{
}

@property (retain) NSString *deptName;
@property (retain) NSSet *employees;
@property (retain) Employee *manager;

@end

@interface Department (CoreDataGeneratedAccessors)
- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)value;
- (void)removeEmployees:(NSSet *)value;

@end

