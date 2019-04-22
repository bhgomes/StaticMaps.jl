"""
"""
module StaticMasks

import Base: |, &


export AbstractMask, MaskNone, MaskAll, AbstractArrayMask, OR, AND, OrderingMask, EQ, NEQ, LT, LEQ, GT, GEQ


"""
"""
abstract type AbstractMask end


"""
"""
struct MaskNone <: AbstractMask end


"""
"""
struct MaskAll <: AbstractMask end


"""
"""
abstract type AbstractArrayMask <: AbstractMask end


"""
"""
struct OR{A <: AbstractArraySelection, B <: AbstractArraySelection} <: AbstractArraySelection end
struct AND{A <: AbstractArraySelection, B <: AbstractArraySelection} <: AbstractArraySelection end


"""
"""
Base.:|(A::Type{AA}, B::Type{BB}) where {AA <: AbstractArraySelection, BB <: AbstractArraySelection} = OR{A, B}
Base.:&(A::Type{AA}, B::Type{BB}) where {AA <: AbstractArraySelection, BB <: AbstractArraySelection} = AND{A, B}


"""
"""
struct OrderingMask{CMP, V} <: AbstractArrayMask end


"""
"""
(::Type{<:OrderingMask{CMP, V}})(a::AbstractArray) where {CMP, V} = broadcast(CMP, a, V)


"""
"""
const EQ = OrderingMask{==}
const NEQ = OrderingMask{!=}
const LT = OrderingMask{<}
const LEQ = OrderingMask{<=}
const GT = OrderingMask{>}
const GEQ = OrderingMask{>=}


end # module StaticMasks
