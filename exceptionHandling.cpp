/*
Exception handling is used to communicate the existence of a runtime problem or error from where it was detected to where the issue can be handled.[60] It permits this to be done in a uniform manner and separately from the main code, while detecting all errors.[61] Should an error occur, an exception is thrown (raised), which is then caught by the nearest suitable exception handler. The exception causes the current scope to be exited, and also each outer scope (propagation) until a suitable handler is found, calling in turn the destructors of any objects in these exited scopes.[62] At the same time, an exception is presented as an object carrying the data about the detected problem.[63]

Note that many C++ "styles" like Google's,[64] forbid usage of exceptions in C++ programs.

The exception-causing code is placed inside a try block. The exceptions are handled in separate catch blocks (the handlers); each try block can have multiple exception handlers, as it is visible in the example below.[65]
*/
#include <iostream>
#include <vector>
#include <stdexcept>

int main() {
    try {
        std::vector<int> vec{3, 4, 3, 1};
        int i{vec.at(4)}; // Throws an exception, std::out_of_range (indexing for vec is from 0-3 not 1-4)
    }
    // An exception handler, catches std::out_of_range, which is thrown by vec.at(4)
    catch (std::out_of_range &e) {
        std::cerr << "Accessing a non-existent element: " << e.what() << '\n';
    }
    // To catch any other standard library exceptions (they derive from std::exception)
    catch (std::exception &e) {
        std::cerr << "Exception thrown: " << e.what() << '\n';
    }
    // Catch any unrecognised exceptions (i.e. those which don't derive from std::exception)
    catch (...) {
        std::cerr << "Some fatal error\n";
    }
}