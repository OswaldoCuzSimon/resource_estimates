# Operaciones en Neo4j
## Prerequisites
apoc-3.5.0.2-all.jar<br>
graph-algorithms-algo-3.5.3.3.jar

## Estructura del DataSet
|Nodos totales|Aristas totales|Diametro|max in deg|min in deg|max out deg|min out deg|Centralidad|Rango de Articulo|
|---|---|---|---|---|---|---|---|---|---|
|||   |   |   |   |   |   |   |   |

**Nodos totales**: Número de nodos en la gráfica<br>
**Aristas totales**: Número de aristas en la gráfica<br>
**Diametro**: Maxima distancia entre dos nodos<br>
**Grado de entrada Maximo (max in deg)**: Número maximo de flechas que apuntan a un nodo<br>
**Grado de entrada Minimo (min in deg)**: Número minimo de flechas que apuntan a un nodo<br>
**Grado de salida Maximo (max out deg)**: Número maximo de flechas que salen de un nodo<br>
**Grado de salida Minimo (min out deg)**: Número minimo de flechas que salen de un nodo<br>
**Centralidad**: Metrica para saber que nodo es mas critico, ser critico significa que si se elimina la gráfica se divide en dos o mas partes<br>
**Rango de Articulo**: Metrica para saber que nodo es mas influyente, ser influyente significa que los demas nodos lo refieren a el<br>
## Creación del Mapa de actividades
[Script de creación](create_graph.cypher)

## Consultas para obtener las caracteristicas de una gráfica

### Nodos Totales
~~~
MATCH (n:Task) RETURN count(n)
~~~
### Aristas totales
~~~
MATCH (n:Task)-[r]->(m:Task) RETURN count(*)
~~~

### Diametro
~~~
match (n)
where (n)-[:LINK]->() and not ()-[:LINK]->(n)
match p = (n)-[:LINK*1..]->(m)
return p, length(p) as L
order by L desc
limit 1
~~~
### Grado de entrada Maximo
max in deg
~~~
MATCH (a)-[:LINK]->(b)
RETURN b, COLLECT(a) as tasks
ORDER BY SIZE(tasks) DESC LIMIT 1
~~~
### Grado de entrada Minimo
min in deg
~~~
MATCH (a)-[:LINK]->(b)
RETURN b, COLLECT(a) as tasks
ORDER BY SIZE(tasks) ASC LIMIT 3
~~~
### Grado de salida Maximo
max out deg
~~~
MATCH (a)-[:LINK]->(b)
RETURN a, COLLECT(b) as tasks
ORDER BY SIZE(tasks) DESC LIMIT 1
~~~
### Grado de salida Minimo
min out deg
~~~
MATCH (a)-[:LINK]->(b)
RETURN a, COLLECT(b) as tasks
ORDER BY SIZE(tasks) ASC LIMIT 1
~~~

### Centralidad
Betweenness Centrality algorithm
~~~
CALL algo.betweenness.stream('Task','LINK',{direction:'out'})
YIELD nodeId, centrality

MATCH (task:Task) WHERE id(task) = nodeId

RETURN task.name AS task,centrality
ORDER BY centrality DESC;
~~~
~~~
CALL algo.betweenness('Task','LINK', {direction:'out',write:true, writeProperty:'centrality'})
YIELD nodes, minCentrality, maxCentrality, sumCentrality, loadMillis, computeMillis, writeMillis;
~~~

### Rango de articulo
~~~
CALL algo.articleRank.stream('Task', 'LINK', {iterations:20, dampingFactor:0.85})
YIELD nodeId, score
RETURN algo.getNodeById(nodeId).name AS task,score
ORDER BY score DESC
~~~
