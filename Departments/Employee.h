//
//  Employee.h
//  Departments
//
//  Created by Jacob Good on 9/1/08.
//  Copyright 2008 Jacob Good. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Department;

@interface Employee :  NSManagedObject
{
}

@property (retain) NSString *lastName;
@property (retain) NSString *firstName;
@property (retain) Department *department;
@property (readonly) NSString *fullName;

@end


