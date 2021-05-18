# LoadingView

This is a simple loading view built in swift that can be added and removed from a UIViewController to indicate when loading is occuring.

## Usage
To add the `LoadingView`, the view first needs to be added as a class property

> let loadingView = LoadingView()

Next, the `startLoading()` method can be called to make the view appear

> loadingView.startLoading()

Finally, when you want the view to disappear, the `stopLoading()` method can be called

> loadingView.stopLoading()
