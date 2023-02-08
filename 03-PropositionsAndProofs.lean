variable {p q r s: Prop}
#check And p q
#check Or (And p q) r
#check p → r

theorem t1' : p → q → p := 
fun hp : p => 
fun hq : q => 
show p from hp

#print t1'

theorem t1 (p q : Prop)(hp: p) (hq : q) : p := hp

axiom hp : p

axiom unsound : False
-- Everything follows from false (principle of explosion)
theorem ex : 1 = 0 :=
  False.elim unsound

#check t1 p q
#check t1 (r → p) (p → q)

variable (h : r → s) 
#check t1 (r → s) (s → r) h

theorem t2 (h₁ : q → r) (h₂ : p → q) : p → r :=
  fun h₃ : p =>
  show r from h₁ (h₂ h₃)  




