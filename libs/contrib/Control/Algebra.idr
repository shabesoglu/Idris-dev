module Control.Algebra

import Data.Heap

-- XXX: change?
infixl 6 <->
infixl 6 <.>
infixl 5 <#>

||| Sets equipped with a single binary operation that is associative, along with
||| a neutral element for that binary operation and inverses for all elements.
||| Must satisfy the following laws:
||| + Associativity of `<+>`:
|||     forall a b c, a <+> (b <+> c) == (a <+> b) <+> c
||| + Neutral for `<+>`:
|||     forall a,     a <+> neutral   == a
|||     forall a,     neutral <+> a   == a
||| + Inverse for `<+>`:
|||     forall a,     a <+> inverse a == neutral
|||     forall a,     inverse a <+> a == neutral
class Monoid a => Group a where
  inverse : a -> a

(<->) : Group a => a -> a -> a
(<->) left right = left <+> (inverse right)

||| Sets equipped with a single binary operation that is associative and
||| commutative, along with a neutral element for that binary operation and
||| inverses for all elements. Must satisfy the following laws:
|||
||| + Associativity of `<+>`:
|||     forall a b c, a <+> (b <+> c) == (a <+> b) <+> c
||| + Commutativity of `<+>`:
|||     forall a b,   a <+> b         == b <+> a
||| + Neutral for `<+>`:
|||     forall a,     a <+> neutral   == a
|||     forall a,     neutral <+> a   == a
||| + Inverse for `<+>`:
|||     forall a,     a <+> inverse a == neutral
|||     forall a,     inverse a <+> a == neutral
class Group a => AbelianGroup a where { }


||| Sets equipped with two binary operations, one associative and commutative
||| supplied with a neutral element, and the other associative, with
||| distributivity laws relating the two operations.  Must satisfy the following
||| laws:
|||
||| + Associativity of `<+>`:
|||     forall a b c, a <+> (b <+> c) == (a <+> b) <+> c
||| + Commutativity of `<+>`:
|||     forall a b,   a <+> b         == b <+> a
||| + Neutral for `<+>`:
|||     forall a,     a <+> neutral   == a
|||     forall a,     neutral <+> a   == a
||| + Inverse for `<+>`:
|||     forall a,     a <+> inverse a == neutral
|||     forall a,     inverse a <+> a == neutral
||| + Associativity of `<.>`:
|||     forall a b c, a <.> (b <.> c) == (a <.> b) <.> c
||| + Distributivity of `<.>` and `<->`:
|||     forall a b c, a <.> (b <+> c) == (a <.> b) <+> (a <.> c)
|||     forall a b c, (a <+> b) <.> c == (a <.> c) <+> (b <.> c)
class AbelianGroup a => Ring a where
  (<.>) : a -> a -> a


||| Sets equipped with two binary operations, one associative and commutative
||| supplied with a neutral element, and the other associative supplied with a
||| neutral element, with distributivity laws relating the two operations.  Must
||| satisfy the following laws:
|||
||| +  Associativity of `<+>`:
|||     forall a b c, a <+> (b <+> c) == (a <+> b) <+> c
||| + Commutativity of `<+>`:
|||     forall a b,   a <+> b         == b <+> a
||| + Neutral for `<+>`:
|||     forall a,     a <+> neutral   == a
|||     forall a,     neutral <+> a   == a
||| + Inverse for `<+>`:
|||     forall a,     a <+> inverse a == neutral
|||     forall a,     inverse a <+> a == neutral
||| + Associativity of `<.>`:
|||     forall a b c, a <.> (b <.> c) == (a <.> b) <.> c
||| + Neutral for `<.>`:
|||     forall a,     a <.> unity     == a
|||     forall a,     unity <.> a     == a
||| + Distributivity of `<.>` and `<->`:
|||     forall a b c, a <.> (b <+> c) == (a <.> b) <+> (a <.> c)
|||     forall a b c, (a <+> b) <.> c == (a <.> c) <+> (b <.> c)
class Ring a => RingWithUnity a where
  unity : a


||| Sets equipped with a binary operation that is commutative, associative and
||| idempotent.  Must satisfy the following laws:
|||
||| + Associativity of join:
|||     forall a b c, join a (join b c) == join (join a b) c
||| + Commutativity of join:
|||     forall a b,   join a b          == join b a
||| + Idempotency of join:
|||     forall a,     join a a          == a
|||
||| Join semilattices capture the notion of sets with a "least upper bound".
class JoinSemilattice a where
  join : a -> a -> a

instance JoinSemilattice Nat where
  join = maximum

instance Ord a => JoinSemilattice (MaxiphobicHeap a) where
  join = merge

||| Sets equipped with a binary operation that is commutative, associative and
||| idempotent.  Must satisfy the following laws:
|||
||| + Associativity of meet:
|||     forall a b c, meet a (meet b c) == meet (meet a b) c
||| + Commutativity of meet:
|||     forall a b,   meet a b          == meet b a
||| + Idempotency of meet:
|||     forall a,     meet a a          == a
|||
||| Meet semilattices capture the notion of sets with a "greatest lower bound".
class MeetSemilattice a where
  meet : a -> a -> a

instance MeetSemilattice Nat where
  meet = minimum


||| Sets equipped with a binary operation that is commutative, associative and
||| idempotent and supplied with a unitary element.  Must satisfy the following
||| laws:
|||
||| + Associativity of join:
|||     forall a b c, join a (join b c) == join (join a b) c
||| + Commutativity of join:
|||     forall a b,   join a b          == join b a
||| + Idempotency of join:
|||     forall a,     join a a          == a
||| + Bottom (Unitary Element):
|||     forall a,     join a bottom     == a
|||
|||  Join semilattices capture the notion of sets with a "least upper bound"
|||  equipped with a "bottom" element.
class JoinSemilattice a => BoundedJoinSemilattice a where
  bottom  : a


instance BoundedJoinSemilattice Nat where
  bottom = Z


||| Sets equipped with a binary operation that is commutative, associative and
||| idempotent and supplied with a unitary element.  Must satisfy the following
||| laws:
|||
||| + Associativity of meet:
|||     forall a b c, meet a (meet b c) == meet (meet a b) c
||| + Commutativity of meet:
|||     forall a b,   meet a b          == meet b a
||| + Idempotency of meet:
|||     forall a,     meet a a          == a
||| +  Top (Unitary Element):
|||     forall a,     meet a top        == a
|||
||| Meet semilattices capture the notion of sets with a "greatest lower bound"
||| equipped with a "top" element.
class MeetSemilattice a => BoundedMeetSemilattice a where
  top : a



||| Sets equipped with two binary operations that are both commutative,
||| associative and idempotent, along with absorbtion laws for relating the two
||| binary operations.  Must satisfy the following:
|||
||| + Associativity of meet and join:
|||     forall a b c, meet a (meet b c) == meet (meet a b) c
|||     forall a b c, join a (join b c) == join (join a b) c
||| + Commutativity of meet and join:
|||     forall a b,   meet a b          == meet b a
|||     forall a b,   join a b          == join b a
||| + Idempotency of meet and join:
|||     forall a,     meet a a          == a
|||     forall a,     join a a          == a
||| + Absorbtion laws for meet and join:
|||     forall a b,   meet a (join a b) == a
|||     forall a b,   join a (meet a b) == a
class (JoinSemilattice a, MeetSemilattice a) => Lattice a where { }


instance Lattice Nat where { }

||| Sets equipped with two binary operations that are both commutative,
||| associative and idempotent and supplied with neutral elements, along with
||| absorbtion laws for relating the two binary operations.  Must satisfy the
||| following:
|||
||| + Associativity of meet and join:
|||     forall a b c, meet a (meet b c) == meet (meet a b) c
|||     forall a b c, join a (join b c) == join (join a b) c
||| +  Commutativity of meet and join:
|||     forall a b,   meet a b          == meet b a
|||     forall a b,   join a b          == join b a
||| + Idempotency of meet and join:
|||     forall a,     meet a a          == a
|||     forall a,     join a a          == a
||| + Absorbtion laws for meet and join:
|||     forall a b,   meet a (join a b) == a
|||     forall a b,   join a (meet a b) == a
||| + Neutral for meet and join:
|||     forall a,     meet a top        == top
|||     forall a,     join a bottom     == bottom
class (BoundedJoinSemilattice a, BoundedMeetSemilattice a) => BoundedLattice a where { }


--   Fields.
||| Sets equipped with two binary operations, both associative and commutative
||| supplied with a neutral element, with
||| distributivity laws relating the two operations.  Must satisfy the following
||| laws:
|||
||| + Associativity of `<+>`:
|||     forall a b c, a <+> (b <+> c) == (a <+> b) <+> c
||| + Commutativity of `<+>`:
|||     forall a b,   a <+> b         == b <+> a
||| + Neutral for `<+>`:
|||     forall a,     a <+> neutral   == a
|||     forall a,     neutral <+> a   == a
||| + Inverse for `<+>`:
|||     forall a,     a <+> inverse a == neutral
|||     forall a,     inverse a <+> a == neutral
||| + Associativity of `<.>`:
|||     forall a b c, a <.> (b <.> c) == (a <.> b) <.> c
||| + Unity for `<.>`:
|||     forall a,     a <.> unity     == a
|||     forall a,     unity <.> a     == a
||| + InverseM of `<.>`:
|||     forall a,     a <.> inverseM a == unity
|||     forall a,     inverseM a <.> a == unity
||| + Distributivity of `<.>` and `<->`:
|||     forall a b c, a <.> (b <+> c) == (a <.> b) <+> (a <.> c)
|||     forall a b c, (a <+> b) <.> c == (a <.> c) <+> (b <.> c)
class RingWithUnity a => Field a where
  inverseM : a -> a


||| A module over a ring is an additive abelian group of 'vectors' endowed with a
||| scale operation multiplying vectors by ring elements, and distributivity laws
||| relating the scale operation to both ring addition and module addition.
||| Must satisfy the following laws:
|||
||| + Compatibility of scalar multiplication with ring multiplication:
|||     forall a b v,  a <#> (b <#> v) = (a <.> b) <#> v
||| + Ring unity is the identity element of scalar multiplication:
|||     forall v,      unity <#> v = v
||| + Distributivity of `<#>` and `<+>`:
|||     forall a v w,  a <#> (v <+> w) == (a <#> v) <+> (a <#> w)
|||     forall a b v,  (a <+> b) <#> v == (a <#> v) <+> (b <#> v)
class (RingWithUnity a, AbelianGroup b) => Module a b where
  (<#>) : a -> b -> b


||| A vector space is a module over a ring that is also a field
class (Field a, Module a b) => VectorSpace a b where {}


-- XXX todo:
--   Structures where "abs" make sense.
--   Euclidean domains, etc.
--   Where to put fromInteger and fromRational?
