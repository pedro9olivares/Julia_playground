
# We create an undirected, adjacency list graph with generic vertices
Base.@kwdef struct Graph{T}
    vertices::Vector{T}
    adjacency_list::Dict{T, Vector{T}}
end

# To preserve the structure of the graph, let's add methods for adding vertices and edges
function add_vertex!(graph::Graph{T}, vertex::T) where T
    if vertex in graph.vertices
        println("Vertex $vertex already exists in the graph.")
    else
        push!(graph.vertices, vertex)
        graph.adjacency_list[vertex] = Vector{T}()
    end
end

function add_edge!(graph::Graph{T}, from::T, to::T) where T
    if !(from in graph.vertices)
        println("Vertex $from does not exist in the graph.")
    elseif !(to in graph.vertices)
        println("Vertex $to does not exist in the graph.")
    else
        push!(graph.adjacency_list[from], to)
        push!(graph.adjacency_list[to], from)
    end
end

# Now, lets add our BFS and DFS
function bfs(graph::Graph{T}, start::T) where T
    visited = Set{T}()
    queue = [start]

    while !isempty(queue)
        node = popfirst!(queue)
        if !(node in visited)
            println("Visited node: ", node)
            push!(visited, node)
            for neighbor in graph.adjacency_list[node]
                if !(neighbor in visited)
                    push!(queue, neighbor)
                end
            end
        end
    end
end

function dfs(graph::Graph{T}, start::T) where T
    visited = Set{T}()
    dfs(graph, start, visited)
end

function dfs(graph::Graph{T}, node::T, visited::Set{T}) where T
    if !(node in visited)
        println("Visited node: ", node)
        push!(visited, node)
        for neighbor in graph.adjacency_list[node]
            dfs(graph, neighbor, visited)
        end
    end
end

# Testing out our Graph
graph1 = Graph(vertices=[1, 2, 3], adjacency_list=Dict(1 => [2], 2 => [1, 3], 3 => [2]))
println(graph1) 

add_vertex!(graph1, 9720)
add_edge!(graph1, 9720, 1)
println(graph1)

# Testing our searches
graph2 = Graph(vertices=[1, 2, 3, 4, 5, 6, 7], 
                adjacency_list=Dict(1 => [2, 3, 5, 6], 
                                    2 => [1, 4, 5, 6], 
                                    3 => [1, 7],
                                    4 => [2],
                                    5 => [1, 2],
                                    6 => [1, 2, 7],
                                    7 => [3, 6]))
println("\nBFS:")
bfs(graph2, 1)

println("\nDFS:")
dfs(graph2, 1)





