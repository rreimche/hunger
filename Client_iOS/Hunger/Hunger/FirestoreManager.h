//
//  FirestoreManager.h
//  Hunger
//
//  This class is a wrapper for Firebase Firestore that is needed
//  because at current time it is impossible to use the latestest
//  versions of 'FirebaseFirestoreSwift' (an extension to 'Firebase/Firestore'
//  cocoapod) cocoapod and 'GeoFire' cocoapod together due to
//  incompatible dependencies.
//
//  Created by Roman Reimche on 25.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

#ifndef FirestoreManager_h
#define FirestoreManager_h

@import Firebase;

@class FirestoreManager;

@interface FirestoreManager: NSObject

- (instancetype)init;

- (void)updateDocument:(NSDictionary<NSString *, id> *)document withDocumentPath:(NSString *)docPath atCollectionPath:(NSString *)colPath;

// Every document in Firestore is a dictionary String to something else
// These dictionaries are saved at document path. So we have the following structure:
// collection > document > data dictionary
// This method returns the data dictionary
// Returns an empty dictionary in case of error.
- (NSDictionary<NSString *, id> *)readDocumentWithDocumentPath:(NSString *)docPath atCollectionPath:(NSString *)colPath;

// This method returns a dictionary of [document path : data dictionary]
// Returns an empty dictionary in case of error.
- (NSDictionary<NSString *, id> *)readDocumentsAtCollectionPath:(NSString *)path;

// This method returns a dictionary of [document path : data dictionary]
// Returns an empty dictionary in case of error.
- (NSDictionary<NSString *, id> *)readDocumentsAtCollectionPath:(NSString *)path onlyFirst:(int)limit orderedBy:(NSString *)orderBy;

@end

#endif /* FirestoreManager_h */
