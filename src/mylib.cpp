#include "mylib.h"
#include <iostream>

void hello() {
    std::cout << "Hello from my-lib!" << std::endl;
}

const char* get_version() {
    return "1.0.0";
}
