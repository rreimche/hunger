//
//  FirestoreManager.m
//  Hunger
//
//  Created by Roman Reimche on 25.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirestoreManager.h"

@implementation FirestoreManager

FIRFirestore *db;


- (instancetype)init {
    
    db = [FIRFirestore firestore];
    
    return self;
}

- (void)updateDocument:(NSDictionary<NSString *, id> *)document withDocumentPath:(NSString *)docPath  atCollectionPath:(NSString *)path {
//    __block FIRDocumentReference *ref =
//        [[db collectionWithPath:path] addDocumentWithData:document completion:^(NSError * _Nullable error) {
//          if (error != nil) {
//            NSLog(@"Error adding document: %@", error);
//          } else {
//            NSLog(@"Document added with ID: %@", ref.documentID);
//          }
//        }];
    
    
    [[[db collectionWithPath:path] documentWithPath: docPath] setData:document completion:^(NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"Error adding document: %@", error);
      } else {
        NSLog(@"Document successfully written!");
      }
    }];
    
}

// Every document is a pair of String and something else
- (NSDictionary<NSString *, id> *)readDocumentWithDocumentPath:(NSString *)docPath atCollectionPath:(NSString *)colPath; {
    
    __block NSDictionary<NSString *, id> * result = @{};
    
    FIRDocumentReference *docRef =
        [[db collectionWithPath:colPath] documentWithPath:docPath];
    
    // TODO somehow get data out of result, because it seems that the method returns before the block starts.
    [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
      if (snapshot.exists) {
        // Document data may be nil if the document exists but has no keys or values.
        NSLog(@"Document data: %@", snapshot.data);
        result = snapshot.data;
          
      } else {
        NSLog(@"Document does not exist");
      }
    }];
    
    return result;
}

- (NSDictionary<NSString *, id> *)readDocumentsAtCollectionPath:(NSString *)path {
    
    __block NSDictionary<NSString *, id> * result = @{};
    
    [[db collectionWithPath:path]
    getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot,
                                 NSError * _Nullable error) {
      if (error != nil) {
          NSLog(@"Error getting documents: %@", error);
      } else {
          NSLog(@"Documents read at %@:", path);
          for (FIRDocumentSnapshot *document in snapshot.documents) {
              NSLog(@"%@ => %@", document.documentID, document.data);
              result = document.data;
          }
      }
    }];
    
    return result;
}

- (NSDictionary<NSString *, id> *)readDocumentsAtCollectionPath:(NSString *)path onlyFirst:(int)limit orderedBy:(NSString *)orderedBy{
    
    __block NSDictionary<NSString *, id> * result = @{};
    
    [[[[db collectionWithPath:path] queryOrderedByField:orderedBy descending:YES] queryLimitedTo:limit]
    getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
      if (error != nil) {
        NSLog(@"Error getting documents: %@", error);
      } else {
        for (FIRDocumentSnapshot *document in snapshot.documents) {
          NSLog(@"%@ => %@", document.documentID, document.data);
            result = document.data;
        }
      }
    }];
    
    return result;
}

@end

