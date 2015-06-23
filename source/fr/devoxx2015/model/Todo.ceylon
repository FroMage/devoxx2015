import io.cayla.hibernate {
    Entity
}

import javax.persistence {
    entity, oneToMany, manyToOne,
    transient
}
import java.util { JList = List, JArrayList = ArrayList }

entity
shared class Todo() extends Entity() {
    shared variable late String name;
    shared variable Boolean done = false;
    
    manyToOne
    shared variable Todo? parent = null;

    oneToMany{mappedBy = "parent";}
    shared variable JList<Todo> children = JArrayList<Todo>();
    
    transient
    shared {Todo*} parents {
        if(exists p = parent){
            return {p, *p.parents};
        }
        return {};
    }
    transient
    shared {Todo+} chain {
        return [this, *parents].reversed;
    }
}
