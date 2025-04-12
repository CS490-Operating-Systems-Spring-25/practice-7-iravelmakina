#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <string>
#include <thread>
#include <chrono>
#include <cstdio>

int main() {
    std::vector<std::ofstream> openFiles;
    std::vector<std::string> fileNames;
    const int numFiles = 100;

    for (int i = 0; i < numFiles; ++i) {
        std::ostringstream filename;
        filename << "files_created/file_" << i << ".txt";
        std::string fileStr = filename.str();
        
        std::ofstream ofs(fileStr);
        if (!ofs) {
            std::cerr << "Failed to open " << fileStr << std::endl;
            break;
        }
        
        ofs << "This is file " << i << "\n";
        ofs.flush();
        openFiles.push_back(std::move(ofs));
        fileNames.push_back(fileStr);
        
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    std::cout << "Opened " << openFiles.size() << " files." << std::endl;
    std::cout << "Press ENTER to delete all files and exit.";
    std::cin.get();

    for (const auto& filename : fileNames) {
        if (std::remove(filename.c_str()) == 0) {
            std::cout << "Deleted file: " << filename << std::endl;
        } else {
            std::perror(("Error deleting file: " + filename).c_str());
        }
    }

    return 0;
}
