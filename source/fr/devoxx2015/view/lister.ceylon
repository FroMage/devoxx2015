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
    INPUT
}
import fr.devoxx2015.model {
    Module
}
import fr.devoxx2015.controller {
    AddHandler
}

shared Template lister(List<Module> list) {
    return HTML{
      HEAD {
          TITLE {
             "List of modules"
          }
      },
      BODY {
           UL {
              for(mod in list.sort((Module x, Module y) => x.name.compare(y.name))) 
                LI { mod.name }
           },
           P {
               "Add a module ``AddHandler()``: ",
               FORM{
                   action = AddHandler().string;
                   method = "POST";
                   INPUT {
                       name = "name";
                       type = "text";
                   }
               }
           }
      }
    };
}