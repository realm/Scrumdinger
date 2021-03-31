# Scrumdinger – How to migrate Apple's SwiftUI tutorial app to Realm

The purpose of this repo is to show how the Scrumdinger app fom [Apple's SwiftUI tutorial](https://developer.apple.com/tutorials/app-dev-training) can be extended to use Realm to store the application data.

The [`main` branch](https://github.com/ClusterDB/Scrumdinger) is the app as it appears in tutorial.

The [`realm` branch](https://github.com/ClusterDB/Scrumdinger/tree/realm) contains a modified version of the Scrumdinger app that persists the application data in Realm.

You can view the [diff between the `main` and `realm` branches](https://github.com/ClusterDB/Scrumdinger/compare/realm) to see the (very few) changes that were needed to make the app run on Realm.