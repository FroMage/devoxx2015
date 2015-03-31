import org.hibernate {
    Session,
    SessionFactory
}
import demo.hibernate {
    createSessionFactory
}
import io.cayla.web {
    Handler,
    Response,
    RequestContext
}
shared abstract class DbHandler() extends Handler(){
    shared late Session session;
    shared late RequestContext context;
    shared actual Response invoke(RequestContext context){
        this.context = context;
        session = sessionFactory.openSession();
        session.transaction.begin();
        try{
            Response ret = execute();
            session.transaction.commit();
            return ret;
        }catch(Throwable t){
            session.transaction.rollback();
            throw t;
        }
    }
    shared formal Response execute();
}



variable SessionFactory sessionFactory = createSessionFactory("jdbc:postgresql://localhost/devoxx2015", 
    "devoxx2015", "devoxx2015", `package fr.devoxx2015.model`);
