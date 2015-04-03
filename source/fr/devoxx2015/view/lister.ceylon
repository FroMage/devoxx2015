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
import fr.devoxx2015.model {
    Todo
}
import fr.devoxx2015.controller {
    AddHandler,
    DeleteHandler,
    Asset,
    DoneHandler,
    ClearHandler,
    AllDoneHandler,
    RemoveDoneHandler
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
                FORM{
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
                },
                FORM {
                    action = RemoveDoneHandler().string;
                    method = "POST";
                    BUTTON {
                        "Remove done tasks"
                    }
                }
            },
            UL {
                for(mod in list.sort((Todo x, Todo y) => x.name.compare(y.name))) 
                LI {
                    FORM {
                        action = DoneHandler(mod.id).string;
                        method = "POST";
                        BUTTON {
                            className = "action";
                            "✓"
                        }
                    },
                    SPAN {
                        className = mod.done then "done" else "";
                        mod.name
                    },
                    FORM {
                        action = DeleteHandler(mod.id).string;
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