#include <fstream>
#include <iostream>
#include <thread>
#include <chrono>

int main() {
    std::ofstream outFile("files_created/test.txt", std::ios::out);
    if (!outFile) {
        std::cerr << "Failed to open test.txt" << std::endl;
        return 1;
    }
    
    for (int i = 0; i < 1000; ++i) {
        outFile << "Line " << i << "\n" << std::flush;
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
    
    return 0;
}
