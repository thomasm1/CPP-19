// Lambda expressions
// C++ provides support for anonymous functions, also known as lambda expressions, with the following form:

/*
[capture](parameters) -> return_type { function_body }
The [capture] list supports the definition of closures. Such lambda expressions are defined in the standard as syntactic sugar for an unnamed function object. An example lambda function may be defined as follows:
*/

[](int x, int y) -> int { return x + y; }