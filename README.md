# LoadingView

This is a simple loading view built in swift that can be added and removed from a UIViewController to indicate when loading is occuring.

## Usage
1. To add the ```LoadingView```, first the ```UIView``` or ```UIViewController``` should inherit from the ```LoadingViewProtocol```
2. Then, as suggested by Xcode the required stubs should be added to your UIViewController:
> let loadingView: LoadingView = LoadingView()
3. Finally, you can access the functionality ```startLoading()``` and ```stopLoading()```
