import io.cayla.web {
    Application,
    Config
}

shared void run() {
    Application(`package fr.devoxx2015.controller`, Config{port = 9001;}).run();
}