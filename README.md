# ZemogaSocialApp
Technical test

### Create an app that lists all messages and their details from JSONPlaceholder.
App Requirements:
1. Load the posts​ from the JSON API and populate the sidebar.
2. The first 20 posts should have a blue dot indicator.
3. Remove the blue dot indicator once the related post is read.
4. Once a post is touched, its related content is shown in the main content area.
5. The related content also displays the user information.
6. Add a button in the navigation. It adds the current post to favorites.
7. Each cell should have the functionality to swipe and delete the post.
8. Add a button to the footer that removes all posts.
9. Add a button to navigation that reloads all posts.
10. Add a segmented control to filter posts (All / Favorites)
11. Favorite posts should have a star indicator.

Optional Requirements:
1. Cache all posts (You could use Core Data (iOS), Realm or what you consider is the best
tool to handle persistency).
2. Add animations when the user deletes each/all posts.
3. Show a list of comments related to each post. It should be located in the main content
area.
4. Add unit testing as you consider it.

## Requirements
- iOS 13+
- Xcode 11.4+
- Swift 5
- SwiftUI

## Instructions
- Run Pod install
- Open ZemogaSocialApp.xcworkspace

## Comments
Based on the Clean Swift architecture, to separate responsabilities to its corresponding file. 
There are groups to separate layers of the app, network, models, scenes and extensions.

## Third Party Pods
- RealmSwift: For persistence of the information.
- ActivityView: Loading view when a service is loading.

# Credits

Luis Alejandro Ramirez Suarez
