# Css generation from common lisp
Backend css library that uses defstyle macro to compile forms to style-tags.

## Motivation
I needed a css library for my upcoming Htmx project and wanted to avoid integrating in to JS ecosystem such as Tailwind or any other possibly deprecating DSL for CSS generation.

## State
Early Alpha, subject to change.

## Example
Example of using defstyle macro that defines the style

``` common-lisp
(defstyle example-style
    (:display :flex :flex-direction :column :gap "5px"
     :max-width '(768
                  '(:flex-direction :row :gap "10px"))
     :min-width '(1500
                  '(:flex-direction :row :gap "15px")))) => (:class "generated-class-name")
```

```
(defun spinneret-ui-component ()
 `(:div ,@(example-style))`) => (:div :class "generated-class-name")
```

NOTE: Place `(output-style-tags)` on head of your root template to generate style-tags


## Available functions and macros
* defstyle - macro that takes style definitions, returns generated class-name and puts style forms to global variable
* purge - empties global variable
* output-style-tags - will output style tags based on defstyle macros
