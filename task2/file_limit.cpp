#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <thread>
#include <chrono>
#include <string>
#include <cstdio>

void deleteFiles(const std::vector<std::string>& fileNames) {
    for (const auto& fname : fileNames) {
        if (std::remove(fname.c_str()) == 0) {
            std::cout << "Deleted file: " << fname << std::endl;
        } else {
            std::perror(("Error deleting file: " + fname).c_str());
        }
    }
}

int main() {
    std::vector<std::ofstream> openFiles;
    std::vector<std::string> fileNames; 
    const int filesPerBatch = 1000;
    const int numberOfBatches = 100;

    for (int batch = 0; batch < numberOfBatches; ++batch) {
        for (int i = 0; i < filesPerBatch; ++i) {
            std::ostringstream filename;
            filename << "files_created/file_" << (batch * filesPerBatch + i) << ".txt";
            std::string fname = filename.str();
            std::ofstream ofs(fname);
            if (!ofs) {
                std::cerr << "Failed to open file: " << fname 
                          << " after opening " << openFiles.size() << " files. Deleting opened files and exiting..." << std::endl;

                std::this_thread::sleep_for(std::chrono::seconds(5));
                
                deleteFiles(fileNames);
                return 1;
            }
            ofs << "This is file " << (batch * filesPerBatch + i) << "\n";
            ofs.flush();
            openFiles.push_back(std::move(ofs));
            fileNames.push_back(fname);
        }
        std::cout << "Batch " << batch << ": Opened " << openFiles.size() 
                  << " files so far." << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
    
    std::cout << "Finished opening files. Press ENTER to delete all files and exit.";
    std::cin.get();
    
    deleteFiles(fileNames);
    
    return 0;
}
