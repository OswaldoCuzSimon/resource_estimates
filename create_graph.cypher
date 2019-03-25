CREATE (zero:Task{name: "start"})
CREATE (crud_obj:Task{name: "CRUD obj"})
CREATE (crud_usr:Task{name: "CRUD usr"})
CREATE (crud_obj_ui:Task{name: "CRUD obj UI"})
CREATE (crud_usr_ui:Task{name: "CRUD usr UI"})

CREATE (perm_groups:Task{name: "perm and groups"})
CREATE (init_load:Task{name: "init load"})
CREATE (perm_groups_ui:Task{name: "perm groups UI"})

CREATE (login:Task{name: "Login"})
CREATE (finance_report:Task{name: "Finance report"})
CREATE (flows:Task{name: "Flows"})
CREATE (test:Task{name: "Test"})

CREATE (crud_obj)-[:LINK {cost:7}]->(zero)
CREATE (crud_usr)-[:LINK {cost:5}]->(zero)
CREATE (crud_obj_ui)-[:LINK {cost:7}]->(zero)
CREATE (crud_usr_ui)-[:LINK {cost:5}]->(zero)

CREATE (perm_groups)-[:LINK {cost:3}]->(crud_obj)
CREATE (perm_groups)-[:LINK {cost:3}]->(crud_usr)
CREATE (init_load)-[:LINK {cost:3}]->(crud_obj)
CREATE (perm_groups_ui)-[:LINK {cost:3}]->(crud_obj_ui)
CREATE (perm_groups_ui)-[:LINK {cost:3}]->(crud_usr_ui)


CREATE (login)-[:LINK {cost:3}]->(perm_groups)
CREATE (test)-[:LINK {cost:1}]->(init_load)
CREATE (test)-[:LINK {cost:1}]->(login)
CREATE (flows)-[:LINK {cost:5}]->(perm_groups_ui)

CREATE (flows)-[:LINK {cost:5}]->(perm_groups)
CREATE (finance_report)-[:LINK {cost:5}]->(perm_groups)
CREATE (finance_report)-[:LINK {cost:3}]->(flows)
CREATE (test)-[:LINK {cost:1}]->(finance_report)
