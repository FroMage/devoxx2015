//import fr.devoxx2015.controller {
//    AddHandler,
//    Asset,
//    DoneHandler,
//    AllDoneHandler,
//    ClearHandler,
//    RemoveDoneHandler,
//    DeleteHandler,
//    ChildrenHandler,
//    IndexHandler
//}
//import fr.devoxx2015.model {
//    Todo
//}
//
//import io.cayla.web.template {
//    Template,
//    HTML,
//    HEAD,
//    BODY,
//    TITLE,
//    UL,
//    LI,
//    P,
//    FORM,
//    INPUT,
//    BUTTON,
//    LINK,
//    H1,
//    SPAN,
//    DIV,
//    WhenNode,
//    A,
//    IfNode,
//    IfExistsNode,
//    Br
//}
//
//shared Template lister(List<Todo> list, Todo? parent = null) {
//    return HTML{
//        HEAD {
//            LINK {
//                rel = "stylesheet";
//                href = Asset("main.css").string;
//            },
//            TITLE {
//                "List of todos"
//            }
//        },
//        BODY {
//            H1 {
//                "The greatest todo list evar!"
//            },
//            SPAN {
//                IfExistsNode {
//                    element = parent;
//                    function onTrue (Todo parent) =>
//                    {
//                        A {
//                            href = IndexHandler().string;
//                            "Top tasks"
//                        },
//                        for (p in parent.chain) 
//                        A {
//                            href = ChildrenHandler(p.id).string;
//                            p.name
//                        }
//                    }.interpose(" > ");
//                }
//            },
//            P {
//                "Add a todo: ",
//                FORM {
//                    action = AddHandler(parent?.id).string;
//                    method = "POST";
//                    INPUT {
//                        name = "name";
//                        type = "text";
//                    }
//                }
//            },
//            DIV {
//                FORM {
//                    action = ClearHandler(parent?.id).string;
//                    method = "POST";
//                    BUTTON {
//                        "Clear"
//                    }
//                },
//                FORM {
//                    action = AllDoneHandler(parent?.id).string;
//                    method = "POST";
//                    BUTTON {
//                        "Mark all done"
//                    }
//                }
//                ,
//                FORM {
//                    action = RemoveDoneHandler(parent?.id).string;
//                    method = "POST";
//                    BUTTON {
//                        "Remove done tasks"
//                    }
//                }
//            },
//            UL {
//                for(todo in list.sort((Todo x, Todo y) => x.name.compare(y.name))) 
//                LI {
//                    FORM {
//                        action = DoneHandler(todo.id).string;
//                        method = "POST";
//                        BUTTON {
//                            className = "action";
//                            "✓"
//                        }
//                    },
//                    SPAN {
//                        className = todo.done then "done" else "";
//                        A {
//                            href = ChildrenHandler(todo.id).string;
//                            todo.name
//                        }
//                    },
//                    FORM {
//                        action = DeleteHandler(todo.id).string;
//                        method = "POST";
//                        BUTTON {
//                            className = "action";
//                            "✗"
//                        }
//                    }
//                }
//            }
//        }
//    };
//}