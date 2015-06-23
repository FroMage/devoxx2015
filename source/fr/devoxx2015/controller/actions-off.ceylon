//import io.cayla.hibernate {
//    list,
//    delete,
//    DbHandler,
//    findById,
//    update
//}
//import io.cayla.web {
//    Response,
//    ok,
//    route,
//    post,
//    seeOther,
//    notFound
//}
//import fr.devoxx2015.model {
//    Todo
//}
//import fr.devoxx2015.view {
//    lister
//}
//import io.cayla.web.asset {
//    AssetHandler
//}
//import ceylon.interop.java {
//    CeylonList
//}
//
//route("/asset/*path")
//shared class Asset(shared String path) extends AssetHandler("asset/``path``") {
//}
//
//route("/")
//shared class IndexHandler() extends DbHandler(){
//    shared actual Response execute(){
//        value todos = list<Todo>("WHERE parent IS NULL");
//        return ok(lister(todos));
//    }
//}
//
//Response view(Integer? parentId) {
//    if(exists parentId){
//        return seeOther(ChildrenHandler(parentId));
//    }else{
//        return seeOther(IndexHandler());
//    }
//}
//
//post
//route("/add")
//shared class AddHandler(shared Integer? parentId = null) extends DbHandler(){
//    shared actual Response execute(){
//        if(exists name = context.params["name"]?.first){
//            value todo = Todo();
//            if(exists parentId){
//                value parent = findById<Todo>(parentId);
//                if(exists parent){
//                    todo.parent = parent;
//                }else{
//                    return notFound();
//                }
//            }
//            todo.name = name;
//            todo.save();
//            return view(parentId);
//        }else{
//            return notFound();
//        }
//    }
//}
//
//post
//route("/:id/done")
//shared class DoneHandler(shared Integer id) extends DbHandler(){
//    shared actual Response execute(){
//        value todo = findById<Todo>(id);
//        if(exists todo){
//            todo.done = !todo.done;
//            todo.save();
//            return view(todo.parent?.id);
//        }else{
//            return notFound();
//        }
//    }
//}
//
//route("/:id/children")
//shared class ChildrenHandler(shared Integer id) extends DbHandler(){
//    shared actual Response execute(){
//        value todo = findById<Todo>(id);
//        if(exists todo){
//            //print("yup: ``list``");
//            return ok(lister(CeylonList(todo.children), todo));
//        }else{
//            return notFound();
//        }
//    }
//}
//
//post
//route("/:id/delete")
//shared class DeleteHandler(shared Integer id) extends DbHandler(){
//    shared actual Response execute(){
//        value todo = findById<Todo>(id);
//        if(exists todo){
//            todo.delete();
//            return view(todo.parent?.id);
//        }else{
//            return notFound();
//        }
//    }
//}
//
//post
//route("/all-done")
//shared class AllDoneHandler(shared Integer? parentId) extends DbHandler(){
//    shared actual Response execute(){
//        if(exists parentId){
//            value todo = findById<Todo>(parentId);
//            if(exists todo){
//                update<Todo>("SET done = true WHERE parent = :parent", {"parent" -> todo});
//            }else{
//                return notFound();
//            }
//        }else{
//            update<Todo>("SET done = true WHERE parent IS NULL");
//        }
//        return view(parentId);
//    }
//}
//
//post
//route("/remove-done")
//shared class RemoveDoneHandler(shared Integer? parentId) extends DbHandler(){
//    shared actual Response execute(){
//        if(exists parentId){
//            value todo = findById<Todo>(parentId);
//            if(exists todo){
//                delete<Todo>("WHERE done = true AND parent = :parent", {"parent" -> todo});
//            }else{
//                return notFound();
//            }
//        }else{
//            delete<Todo>("WHERE done = true AND parent IS NULL");
//        }
//        return view(parentId);
//    }
//}
//
//post
//route("/clear")
//shared class ClearHandler(shared Integer? parentId) extends DbHandler(){
//    shared actual Response execute(){
//        if(exists parentId){
//            value todo = findById<Todo>(parentId);
//            if(exists todo){
//                delete<Todo>("WHERE parent = :parent", {"parent" -> todo});
//            }else{
//                return notFound();
//            }
//        }else{
//            delete<Todo>("WHERE parent IS NULL");
//        }
//        return view(parentId);
//    }
//}
