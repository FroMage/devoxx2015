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
        // when we start using the web console, we have no PG running
        if(openshift.postgres.running){
            String url = openshift.postgres.jdbcUrl;
            print("Connecting to postgres at ``url``");
            setupDatabase(url, openshift.postgres.user, openshift.postgres.password, `package fr.devoxx2015.model`);
        }else{
            print("Not setting up DB: none running yet (your app will not work)");
        }
    }else{
        setupDatabase("jdbc:postgresql://localhost/devoxx2015", 
            "devoxx2015", "devoxx2015", `package fr.devoxx2015.model`);
    }
    Config conf;
    if(openshift.running){
        conf = Config{
            hostName = openshift.ceylon.ip; 
            port = openshift.ceylon.port;
            externalHostName = openshift.dns; 
            externalPort = 80;
            applicationPath = openshift.repository;
        };
    }else{
        conf = Config{port = 9001;};
    }
    Application(`package fr.devoxx2015.controller`, conf).runBlocking();
}