import fr.devoxx2015.controller {
    AddHandler,
    Asset,
    DoneHandler,
    AllDoneHandler,
    ClearHandler,
    RemoveDoneHandler,
    DeleteHandler
}
import fr.devoxx2015.model {
    Todo
}

import io.cayla.web.template {
    Template,
    HTML,
    HEAD,
    BODY,
    TITLE,
    UL,
    LI,
    P,
    FORM,
    INPUT,
    BUTTON,
    LINK,
    H1,
    SPAN,
    DIV
}

shared Template lister(List<Todo> list) {
    return HTML{
        HEAD {
            LINK {
                rel = "stylesheet";
                href = Asset("main.css").string;
            },
            TITLE {
                "List of todos"
            }
        },
        BODY {
            H1 {
                "The greatest todo list evar!"
            },
            P {
                "Add a todo: ",
                FORM {
                    action = AddHandler().string;
                    method = "POST";
                    INPUT {
                        name = "name";
                        type = "text";
                    }
                }
            },
            DIV {
                FORM {
                    action = ClearHandler().string;
                    method = "POST";
                    BUTTON {
                        "Clear"
                    }
                },
                FORM {
                    action = AllDoneHandler().string;
                    method = "POST";
                    BUTTON {
                        "Mark all done"
                    }
                }
                ,
                FORM {
                    action = RemoveDoneHandler().string;
                    method = "POST";
                    BUTTON {
                        "Remove done tasks"
                    }
                }
            },
            UL {
                for(todo in list.sort((Todo x, Todo y) => x.name.compare(y.name))) 
                LI {
                    FORM {
                        action = DoneHandler(todo.id).string;
                        method = "POST";
                        BUTTON {
                            className = "action";
                            "✓"
                        }
                    },
                    SPAN {
                        className = todo.done then "done" else "";
                        todo.name
                    },
                    FORM {
                        action = DeleteHandler(todo.id).string;
                        method = "POST";
                        BUTTON {
                            className = "action";
                            "✗"
                        }
                    }
                }
            }
        }
    };
}