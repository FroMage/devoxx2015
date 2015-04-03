import io.cayla.hibernate {
    Entity
}

import javax.persistence {
    entity
}

entity
shared class Todo() extends Entity() {
    shared variable late String name;
    shared variable Boolean done = false;
}
