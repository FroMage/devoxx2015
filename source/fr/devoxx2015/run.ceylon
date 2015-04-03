import io.cayla.web {
    Application,
    Config
}
import io.cayla.hibernate {
    setupDatabase
}
import ceylon.openshift {
    openshift
}

shared void run() {
    if(openshift.running){
        String url = openshift.postgres.jdbcUrl;
        print("Connecting to postgres at ``url``");
        setupDatabase(url, openshift.postgres.user, openshift.postgres.password, `package fr.devoxx2015.model`);
    }else{
        setupDatabase("jdbc:postgresql://localhost/devoxx2015", 
            "devoxx2015", "devoxx2015", `package fr.devoxx2015.model`);
    }
    Config conf;
    if(openshift.running){
        conf = Config{
            hostName = openshift.ip; 
            port = openshift.port;
            externalHostName = openshift.dns; 
            externalPort = 80;
            applicationPath = openshift.repository;
        };
    }else{
        conf = Config{port = 9001;};
    }
    Application(`package fr.devoxx2015.controller`, conf).start();
    print("Started on port ``conf.port``");
    process.readLine();
    print("Got something1");
    process.readLine();
    print("Got something2");
}