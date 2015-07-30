# JAXibView
Super class to create reusable views from a .xib


## Way to use it:

* Create a `.xib` file, example `CustomView`
* Create a NSObject with the same name, `CustomView.h` and `CustomView.m`
* Set the `CustomView.h` super class as `JAXibView`
* In the `.xib` file set the `File's Owner` Class like the class extending JAXibView
* Now you can use it from Interface Builder and from code.
