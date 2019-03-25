Create Vertix
~~~
CREATE (sample)
CREATE (node1),(node2)
~~~
Create vertix with label
~~~
CREATE (node:label)
~~~
CREATE (Dhawan:person:player)

Delete all
~~~
MATCH (n) DETACH DELETE n
~~~
~~~
CREATE (CRUD_obj:Task{name: "CRUD obj"})
~~~
Create vertix and return it
~~~
CREATE (CRUD_obj:Task{name: "CRUD obj"}) RETURN Node
~~~
## Creating Relationships
create two Vertix

## install Graph Algorithms Library

https://neo4j.com/developer/graph-algorithms/#_graph_algorithms_library

### Shortest Path
~~~
MATCH (start:Task{name:"Test"}), (end:Task{name:"start"})
CALL algo.shortestPath.stream(start, end, "time")
YIELD nodeId, cost
MATCH (other:Task) WHERE id(other) = nodeId
RETURN other.name AS name, cost
~~~
