---
title: Functional Red-Black Tree Implementation
date: 2023-12-16
tags:
 - OCaml
 - Functional Datastruct
 - Balanced Tree
## summary:  
mathjax: true
---

## Binary Search Tree

Binary search tree, also called an ordered or sorted binary tree, is a
rooted binary tree data structure with the key of each internal node
being greater than all the keys in the respective node's left subtree
and less than the ones in its right subtree.

Here is the implemention in OCaml:

``` ml
module BstSet = struct
  type 'a t = Leaf | Node of 'a * 'a t * 'a t

  let empty = Leaf

  let rec size = function
    | Leaf -> 0
    | Node (_, left, right) -> 1 + size left + size right
  ;;

  let rec add x = function
    | Leaf -> Node (x, Leaf, Leaf)
    | Node (v, l, r) when v > x -> Node (v, add x l, r)
    | Node (v, l, r) when v < x -> Node (v, l, add x r)
    | t -> t
  ;;

  let rec mem x = function
    | Leaf -> false
    | Node (v, l, _) when v > x -> mem x l
    | Node (v, _, r) when v < x -> mem x r
    | _ -> true
  ;;

  let rec remove_union lt = function
    | Leaf -> lt
    | Node (v, l, r) -> Node (v, remove_union lt l, r)
  ;;

  let rec remove x = function
    | Leaf -> failwith "tree doesn't contain the element to be removed"
    | Node (v, l, r) when v > x -> Node (v, remove x l, r)
    | Node (v, l, r) when v < x -> Node (v, l, remove x r)
    | Node (_, l, r) -> remove_union l r
  ;;

  let update x x' t = t |> remove x |> add x'
end
```

When remove a node in BST, we can union the subtree of removal node to
the most left Leaf node in the right subtree.

<figure>
<p><img src="https://github.com/epochess/epochess.github.io/assets/61822407/6e3209ca-e595-4c52-b93e-c02b98440946" style="width:90.0%" /></p>
</figure>

We can get the key's ordering before delete node `del`:
$$ {a} > L > {b} >  del  > Y > {c} > … > R > {d} $$


After delete the node, we union the subtree $L$ to the left subnode of
$Y$, and the ordering is still unchanged.

The time complexity of above operations is $O(h)$, which $h$ is height
of the tree. In most case, tree have good shape that all non-leaf node
have 2 children node, so these operations are logarithmic because of
$h = \log(n + 1)$. But in the worest case, all nodes of the tree are
right children of the parent node, so that the time complexity is
degenerated $O(n)$.

## Red-Black Tree

Red-Black Tree is a simple balanced tree data structure, which means it
can keep balanced with good shape so that the operations are
logarithmic.

In RBT, every node have color red or black, the RI make tree balanced.
1.  *Local Invariant:* there are no two adjacnet red node in any path.
2.  *Global Invariant:* the number of black node in every path from root
    to leaf is equal.

The ADT operations are same as BST : insertion, deletion.

#### Insertion (Okaskaki's algorithm)

When we insert elements into the tree, if we set the color black, we may
violate global invariants, and if we set it red, we may violate local
invariants. The algorithm that we can solve this problem to maintain the
RI is *Okasaki's Algorithm*.

That algorithm set the inserted node color red in insertion to ensure
the global invariant, but it will violate the local invariant, and the
shape of tree are four cases.

<figure>
<p><img src="https://github.com/epochess/epochess.github.io/assets/61822407/4e8309b6-addd-446e-ae3a-54ba77b10153" style="width:100.0%" /></p>
</figure>

Okasaki's algorihtm told us of above cases trees can be converted to be
a same tree which have perfect shape.

<figure>
<p><img src="https://github.com/epochess/epochess.github.io/assets/61822407/062f3284-8fe4-4b7a-b0ff-d8ddc2140577" style="width:30.0%" /></p>
</figure>

We can conclude the ordering of these trees:
$${a} < X < {b} < Y < {c} < Z < {d}$$

Here is the implementation in OCaml:

``` ml
module RBTree = struct
  type color =
    | Red
    | Black

  type 'a tree =
    | Leaf
    | Node of (color * 'a * 'a tree * 'a tree)

  let empty = Leaf

  let rec mem x = function
    | Leaf -> false
    | Node (_, v, l, _) when v > x -> mem x l
    | Node (_, v, _, r) when v < x -> mem x r
    | _ -> true
  ;;

  let balance = function
    | Black, z, Node (Red, y, Node (Red, x, a, b), c), d
    | Black, z, Node (Red, x, a, Node (Red, y, b, c)), d
    | Black, x, a, Node (Red, z, Node (Red, y, b, c), d)
    | Black, x, a, Node (Red, y, b, Node (Red, z, c, d)) ->
      Node (Red, y, Node (Black, x, a, b), Node (Black, z, c, d))
    | a, b, c, d -> Node (a, b, c, d)
  ;;

  let rec insert_aux x = function
    | Leaf -> Node (Red, x, Leaf, Leaf)
    | Node (c, v, l, r) when c > x -> balance (c, v, insert_aux x l, r)
    | Node (c, v, l, r) when c < x -> balance (c, v, l, insert_aux x r)
    | node -> node
  ;;

  let insert x t =
    match insert_aux x t with
    | Leaf -> failwith "error"
    | Node (_, v, l, r) -> Node (Black, v, l, r)
  ;;
end
```

