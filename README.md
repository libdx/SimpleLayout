## Simple Layout

Simple Layout is tiny DSL for Auto Layout.

It gives ability to describe layout constraints
in a form of linear equation directly in swift code.

Layout constraint can be represented by linear equation:
```
attribute1 == multiplier × attribute2 + constant
```

With Simple Layout you can write such kind of linear equation directly in swift code:
``` swift
let constraint = Constraint(view: view1).width == Constraint(view: view2).height * 1.15 + 10
```

alternative way:
``` swift
let constraint = constraint(view1, view2) { $0.width == $1.height * 2 + 20 }
```

