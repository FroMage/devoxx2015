import demo.hibernate {
    list
}
import io.cayla.web {
    Response,
    ok,
    route,
    Handler,
    post,
    status
}
import fr.devoxx2015.controller.impl {
    DbHandler
}
import fr.devoxx2015.model {
    Module
}
import fr.devoxx2015.view {
    lister
}

route("/")
class MyHandler() extends DbHandler(){
    shared actual Response execute(){
        value modules = list<Module>(session);
        print("list: ``MyHandler()``");
        print("add: ``AddHandler()``");
        return ok(lister(modules));
    }
}

post
route("/add")
shared class AddHandler() extends DbHandler(){
    shared actual Response execute(){
        assert(exists name = context.request.params.get("name")?.first);
        value mod = Module();
        mod.name = name;
        session.persist(mod);
        value indexUrl = MyHandler().string;
        print("New module: ``name```, moving you to ``indexUrl``");
        return status{
            status = 201;
            "Location" -> indexUrl
        };
    }
}
