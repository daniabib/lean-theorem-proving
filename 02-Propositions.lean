/- The expression And.intro h1 h2 builds a proof of p ∧ q using proofs 
h1 : p and h2 : q 
The order of operations is as follows: unary negation ¬ binds most strongly, then ∧, then ∨, then →, and finally ↔
-/

variable (p q : Prop)

--The example command states a theorem without naming it or storing it in the permanent context. Essentially, it just checks that the given term has the indicated type.
example (hp : p) (hq : q) : p ∧ q := And.intro hp hq

#check fun (hp : p) (hq : q) => And.intro hp hq

-- The expression And.left h creates a proof of p from a proof h : p ∧ q
example (h : p ∧ q) : p := And.left h
example (h : p ∧ q) : q := And.right h

-- We can now prove p ∧ q → q ∧ p with the following proof term.
example (h : p ∧ q) : q ∧ p  :=
  And.intro (And.right h) (And.left h)