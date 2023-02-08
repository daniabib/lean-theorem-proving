def α : Type := Nat
def β : Type := Bool
def F : Type → Type := List
def G : Type → Type → Type := Prod

#check α
#check F α
#check F Nat
#check G α
#check G α β 

#check Type     -- Type 1
#check Type 1   -- Type 2
#check Type 2   -- Type 3
#check Type 3   -- Type 4
#check Type 4   -- Type 5

/-
Lean's underlying foundation has an infinite hierarchy of types.
Think of Type 0 as a universe of "small" or "ordinary" types. Type 1 is then a larger universe of types, which contains Type 0 as an element, and Type 2 is an even larger universe of types, which contains Type 1 as an element
-/

#check List
#check Prod

/-
To define polymorphic constants, Lean allows you to declare universe variables explicitly using the universe command
-/

universe u 

def H (α : Type u) : Type u := Prod α α 

#check H 

-- Function Abstraction and Evaluation

#check fun (x : Nat) => x + 5
#check λ (x : Nat) => x + 5 -- λ and fun mean the same thing
#check fun x : Nat => x + 5

#eval (λ x : Nat => x + 5) 3

def f (n : Nat) := toString n
def g (s : String) : Bool := s.length > 0
#check f
#check g

#eval f 3
#eval g "3"
#eval g (f 3)

#check fun x : Nat => x  -- Identity
#check fun x : Nat => true
#check fun x : Nat => g (f x)
#check fun x => g (f x)

def f' (n : Nat) : String := toString n
#check f'


-- DEFINITIONS
def double (x : Nat) : Nat :=
  x + x

def square (x : Nat) : Nat :=
  x * x

def doTwice (f : Nat → Nat) (x : Nat) : Nat :=
  f (f x)

#eval doTwice double 3

def compose (α β γ : Type) (g: β → γ) (f : α → β) (x : α) : γ :=
  g (f x)

#eval compose Nat Nat Nat double square 3


-- LOCAL DEFINITIONS
#check let y := 2 + 2; y * y   -- Nat
#eval  let y := 2 + 2; y * y   -- 16

def twice_double (x : Nat) : Nat :=
  let y := x + x; y * y

#eval twice_double 2

#check let y := 2 + 2; let z := y + y; z * z   -- Nat
#eval  let y := 2 + 2; let z := y + y; z * z   -- 64

-- Without ; and with linebreak
def t (x : Nat) : Nat :=
  let y := x + x
  y * y


-- VARAIBLES AND SECTIONS
variable (α β γ : Type)
variable (g : β → γ) (f : α → β)
variable (x : α)

def compose' := g (f x)

#print compose

-- 'section' limit the scope of a variable
section useful
  variable (α β γ : Type)
  variable (g : β → γ) (f : α → β)
  variable (x : α)

  def compose'' := g (f x)
end useful

-- #eval compose'' -- error


-- NAMESPACES
namespace Foo
  def a : Nat := 5
  def f' (x : Nat) : Nat := x + 7

  def fa : Nat := f' a
  def ffa : Nat := f' (f' a)

  #check a
  #check f'
  #check fa
  #check ffa
  #check Foo.fa
end Foo

-- #check a  -- error
-- #check f  -- error
#check Foo.a
#check Foo.f'
#check Foo.fa
#check Foo.ffa

open Foo

#check a
#check f
#check fa
#check Foo.fa

-- Lean groups definitions and theorems involving lists into a namespace List
#check List.nil
#check List.cons
#check List.map

open List

#check nil
#check cons
#check map

-- namespaces organize data and sections declare variables for insertion in definitions


-- What makes dependent type theory dependent?
-- The short explanation is that types can depend on parameters.
def cons' (α : Type) (a : α) (as : List α) : List α :=
  List.cons a as

#check cons' Bool
#check cons' Nat
#check cons

#check @List.cons

-- IMPLICIT ARGUMENTS
-- {} specify implicit arguments - we don't have to pass the Type as a first argument
def ident {α : Type u} (x : α) := x

#check ident
#check ident 1
#check ident "hello"

