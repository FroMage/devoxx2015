import io.cayla.hibernate {
    list,
    delete,
    DbHandler,
    findById,
    update
}
import io.cayla.web {
    Response,
    ok,
    route,
    post,
    seeOther,
    notFound
}
import fr.devoxx2015.model {
    Todo
}
import fr.devoxx2015.view {
    lister
}
import io.cayla.web.asset {
    AssetHandler
}

route("/asset/*path")
shared class Asset(shared String path) extends AssetHandler("asset/``path``") {
}

route("/")
class MyHandler() extends DbHandler(){
    shared actual Response execute(){
        value todos = list<Todo>();
        return ok(lister(todos));
    }
}

post
route("/add")
shared class AddHandler() extends DbHandler(){
    shared actual Response execute(){
        assert(exists name = context.params["name"]?.first);
        value todo = Todo();
        todo.name = name;
        todo.save();
        return seeOther(MyHandler());
    }
}

post
route("/:id/delete")
shared class DeleteHandler(shared Integer id) extends DbHandler(){
    shared actual Response execute(){
        delete<Todo>(id);
        return seeOther(MyHandler());
    }
}

post
route("/:id/done")
shared class DoneHandler(shared Integer id) extends DbHandler(){
    shared actual Response execute(){
        value todo = findById<Todo>(id);
        if(exists todo){
            todo.done = !todo.done;
            todo.save();
            return seeOther(MyHandler());
        }else{
            return notFound();
        }
    }
}

post
route("/all-done")
shared class AllDoneHandler() extends DbHandler(){
    shared actual Response execute(){
        update<Todo>("SET done = true");
        return seeOther(MyHandler());
    }
}

post
route("/remove-done")
shared class RemoveDoneHandler() extends DbHandler(){
    shared actual Response execute(){
        delete<Todo>("WHERE done = true");
        return seeOther(MyHandler());
    }
}

post
route("/clear")
shared class ClearHandler() extends DbHandler(){
    shared actual Response execute(){
        delete<Todo>();
        return seeOther(MyHandler());
    }
}
