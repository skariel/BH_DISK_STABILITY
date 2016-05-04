type BlockPos <: Block
    pos::Array{Float32, 2}
end

function ZeroBlockPos(n)
    return BlockPos(
        zeros(Float32, (3, n))
    )
end

function ReadBlockPos(filename)
    open(filename, "r") do f
        GotoBlock!(f, "POS")
        sz = read(f, Int32)
        n = div(sz,3*sizeof(Float32))
        bp = ZeroBlockPos(n)
        read!(f, bp.pos)
        @assert read(f, Int32) == sz
        return bp
    end
end

function AppendBlockPos(filename, bp::BlockPos)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "POS ".data)
        write(f, "POS ".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bp.pos)))
        write(f, bp.pos)
        write(f, Int32(sizeof(bp.pos)))
    end
end


type BlockVel <: Block
    vel::Array{Float32, 2}
end

function ZeroBlockVel(n)
    return BlockVel(
        zeros(Float32, (3, n))
    )
end

function AppendBlockVel(filename, bv::BlockVel)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "VEL ".data)
        write(f, "VEL ".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bv.vel)))
        write(f, bv.vel)
        write(f, Int32(sizeof(bv.vel)))
    end
end


function ReadBlockVel(filename)
    open(filename, "r") do f
        GotoBlock!(f, "VEL")
        sz = read(f, Int32)
        n = div(sz,3*sizeof(Float32))
        bv = ZeroBlockVel(n)
        read!(f, bv.vel)
        @assert read(f, Int32) == sz
        return bv
    end
end



type BlockID <: Block
    id::Array{UInt32, 1}
end

function ZeroBlockID(n)
    return BlockID(
        zeros(UInt32, n)
    )
end

function ReadBlockID(filename)
    open(filename, "r") do f
        GotoBlock!(f, "ID")
        sz = read(f, Int32)
        n = div(sz,sizeof(UInt32))
        bid = ZeroBlockID(n)
        read!(f, bid.id)
        @assert read(f, Int32) == sz
        return bid
    end
end

function AppendBlockID(filename, bid::BlockID)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "ID  ".data)
        write(f, "ID  ".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bid.id)))
        write(f, bid.id)
        write(f, Int32(sizeof(bid.id)))
    end
end



type BlockMass <: Block
    mass::Array{Float32, 1}
end

function ZeroBlockMass(n)
    return BlockMass(
        zeros(Float32, n)
    )
end

function ReadBlockMass(filename)
    open(filename, "r") do f
        GotoBlock!(f, "MASS")
        sz = read(f, Int32)
        n = div(sz,sizeof(Float32))
        bm = ZeroBlockMass(n)
        read!(f, bm.mass)
        @assert read(f, Int32) == sz
        return bm
    end
end

function AppendBlockMass(filename, bm::BlockMass)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "MASS".data)
        write(f, "MASS".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bm.mass)))
        write(f, bm.mass)
        write(f, Int32(sizeof(bm.mass)))
    end
end




type BlockU <: Block
    u::Array{Float32, 1}
end

function ZeroBlockU(n)
    return BlockU(
        zeros(Float32, n)
    )
end

function ReadBlockU(filename)
    open(filename, "r") do f
        GotoBlock!(f, "U")
        sz = read(f, Int32)
        n = div(sz,sizeof(Float32))
        bu = ZeroBlockU(n)
        read!(f, bu.u)
        @assert read(f, Int32) == sz
        return bu
    end
end

function AppendBlockU(filename, bu::BlockU)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "U   ".data)
        write(f, "U   ".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bu.u)))
        write(f, bu.u)
        write(f, Int32(sizeof(bu.u)))
    end
end



type BlockRho <: Block
    rho::Array{Float32, 1}
end

function ZeroBlockRho(n)
    return BlockRho(
        zeros(Float32, n)
    )
end

function ReadBlockRho(filename)
    open(filename, "r") do f
        GotoBlock!(f, "RHO")
        sz = read(f, Int32)
        n = div(sz,sizeof(Float32))
        br = ZeroBlockRho(n)
        read!(f, br.rho)
        @assert read(f, Int32) == sz
        return br
    end
end

function AppendBlockRho(filename, br::BlockRho)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "RHO ".data)
        write(f, "RHO ".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(br.rho)))
        write(f, br.rho)
        write(f, Int32(sizeof(br.rho)))
    end
end





type BlockHSML <: Block
    hsml::Array{Float32, 1}
end

function ZeroBlockHSML(n)
    return BlockHSML(
        zeros(Float32, n)
    )
end

function ReadBlockHSML(filename)
    open(filename, "r") do f
        GotoBlock!(f, "HSML")
        sz = read(f, Int32)
        n = div(sz,sizeof(Float32))
        bh = ZeroBlockHSML(n)
        read!(f, bh.hsml)
        @assert read(f, Int32) == sz
        return bh
    end
end

function AppendBlockHSML(filename, bh::BlockHSML)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "HSML".data)
        write(f, "HSML".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bh.hsml)))
        write(f, bh.hsml)
        write(f, Int32(sizeof(bh.hsml)))
    end
end



type BlockPOT <: Block
    pot::Array{Float32, 1}
end

function ZeroBlockPOT(n)
    return BlockPOT(
        zeros(Float32, n)
    )
end

function ReadBlockPOT(filename)
    open(filename, "r") do f
        GotoBlock!(f, "POT")
        sz = read(f, Int32)
        n = div(sz,sizeof(Float32))
        bp = ZeroBlockPOT(n)
        read!(f, bp.pot)
        @assert read(f, Int32) == sz
        return bp
    end
end

function AppendBlockPot(filename, bp::BlockPot)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "POT ".data)
        write(f, "POT ".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(bp.pot)))
        write(f, bp.pot)
        write(f, Int32(sizeof(bp.pot)))
    end
end





type BlockAccel <: Block
    accel::Array{Float32, 2}
end

function ZeroBlockAccel(n)
    return BlockAccel(
        zeros(Float32, (3, n))
    )
end

function ReadBlockAccel(filename)
    open(filename, "r") do f
        GotoBlock!(f, "ACCE")
        sz = read(f, Int32)
        n = div(sz,3*sizeof(Float32))
        ba = ZeroBlockAccel(n)
        read!(f, ba.accel)
        @assert read(f, Int32) == sz
        return ba
    end
end

function AppendBlockAccel(filename, ba::BlockAccel)
    open(filename, "a") do f
        write(f, Int32(8))
        write(f, "ACCE".data)
        write(f, "ACCE".data)
        write(f, Int32(8))
        write(f, Int32(sizeof(ba.accel)))
        write(f, ba.accel)
        write(f, Int32(sizeof(ba.accel)))
    end
end
