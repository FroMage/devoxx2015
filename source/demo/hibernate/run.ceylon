import ceylon.interop.java {
    javaClass,
    javaClassFromInstance,
    CeylonIterable
}
import org.hibernate.cfg {
    Configuration
}
import org.hibernate {
    SessionFactory,
    Session
}
import ceylon.language.meta.declaration {
    Package,
    ClassDeclaration
}
import ceylon.collection {
    ArrayList
}
import ceylon.language.meta.model {
    Class
}

shared SessionFactory createSessionFactory(String databaseUrl, String user, String password,
    Package modelPackage,
    String dialect = "org.hibernate.dialect.PostgreSQL9Dialect",
    String driverClass = "org.postgresql.Driver"){
    value cfg = Configuration()
            .setProperty("hibernate.dialect", dialect)
            .setProperty("hibernate.connection.driver_class", driverClass)
            .setProperty("hibernate.connection.url", databaseUrl)
            .setProperty("hibernate.connection.username", user)
            .setProperty("hibernate.connection.pool_size", "5")
            .setProperty("hibernate.hbm2ddl.auto", "update")
            .setProperty("hibernate.connection.password", password);
    for (klass in modelPackage.members<ClassDeclaration>()) {
        print("Installing model class ``klass``");
        if(klass.abstract){
            continue;
        }
        assert(is Object inst = klass.instantiate());
        cfg.addAnnotatedClass(javaClassFromInstance<Object>(inst));
    }
    return cfg.buildSessionFactory();
}

shared List<T> query<T>(Session s, String hql){
    value list = s.createQuery(hql).list();
    value ret = ArrayList<T>(list.size());
    for(elem in CeylonIterable(list)){
        assert(is T elem);
        ret.add(elem);
    }
    return ret;
}

shared List<T> list<T>(Session s){
    assert(is Class<T,[]> model = `T`);
    return query<T>(s, "from ``model.declaration.name``");
}