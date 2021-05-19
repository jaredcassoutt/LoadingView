# LoadingView

This is a simple loading view built in swift that can be added and removed from a UIViewController to indicate when loading is occuring.

## Usage
To add the view to a UIViewController and start the animation, the `startLoading()` method should be called.

> LoadingView().startLoading()

When you want the view to disappear, the `stopLoading()` method can be called

> loadingView.stopLoading()
