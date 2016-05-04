type BlockHeader <: Block
    Npart::Array{UInt32, 1}
    Massarr::Array{Float64, 1}
    Time::Float64
    Redshift::Float64
    FlagSfr::Bool
    FlagFeedback::Bool
    Nall::Array{UInt32, 1}
    FlagCooling::Bool
    NumFiles::Int32
    BoxSize::Float64
    Omega0::Float64
    HubbleParam::Float64
    FlagAge::Bool
    FlagMetals::Bool
    NallHW::Array{UInt32, 1}
    flag_entr_ics::Bool
    r::Array{UnitRange{Int32},1}
end

function ZeroBlockHeader()
    return BlockHeader(
        zeros(UInt32, 6),      # Npart::Array{UInt32, 6}
        zeros(Float64, 6),     # Massarr::Array{Float64, 6}
        0.0,                   # Time::Float64
        0.0,                   # Redshift::Float64
        false,                 # FlagSfr::Int32
        false,                 # FlagFeedback::Int32
        zeros(UInt32, 6),      # Nall::Array{UInt32, 6}
        false,                 # FlagCooling::Int32
        0,                     # NumFiles::Int32
        0.0,                   # BoxSize::Float64
        0.0,                   # Omega0::Float64
        0.0,                   # HubbleParam::Float64
        false,                 # FlagAge::Int32
        false,                 # FlagMetals::Int32
        zeros(UInt32, 6),      # NallHW::Array{UInt32, 6}
        false,                 # flag_entr_ics::Int32
        [0:0, 0:0, 0:0, 0:0, 0:0, 0:0]
    )
end

function ReadBlockHeader(filename)
    open(filename, "r") do f
        seek(f, 0)
        @assert read(f, Int32) == 8
        @assert read(f, UInt8, 4) == "HEAD".data
        read(f, UInt8, 4)
        @assert read(f, Int32) == 8
        @assert read(f, Int32) == 256        
        bh = BlockHeader(
                read(f, UInt32, 6),  # Npart
                read(f, Float64, 6), # Massarr     
                read(f, Float64),    # Time
                read(f, Float64),    # Redshift
                read(f, Int32)!=0,   # FlagSfr
                read(f, Int32)!=0,   # FlagFeedback
                read(f, UInt32, 6),  # Nall
                read(f, Int32)!=0,   # FlagCooling
                read(f, Int32),      # NumFiles
                read(f, Float64),    # BoxSize
                read(f, Float64),    # Omega0::Float64
                read(f, Float64),    # HubbleParam::Float64
                read(f, Int32)!=0,   # FlagAge
                read(f, Int32)!=0,   # FlagMetals
                read(f, UInt32, 6),  # NallHW
                read(f, Int32)!=0,   # flag_entr_ics
                [0:0, 0:0, 0:0, 0:0, 0:0, 0:0],
            )    
        cs = cumsum(bh.Nall)
        bh.r[1] = 1:cs[1]
        bh.r[2] = cs[1]:cs[2]
        bh.r[3] = cs[2]:cs[3]
        bh.r[4] = cs[3]:cs[4]
        bh.r[5] = cs[4]:cs[5]
        bh.r[6] = cs[5]:cs[6]
        seek(f,4+8+4+4+256)
        @assert read(f, Int32) == 256
        return bh
    end
end

function WriteBlockHeader(filename, bh::BlockHeader)
    open(filename, "w") do f
        write(f, Int32(8))
        write(f, "HEAD".data)
        write(f, "HEAD".data)
        write(f, Int32(8))
        write(f, Int32(256))        
        write(f, bh.Npart)
        write(f, bh.Massarr)     
        write(f, bh.Time)
        write(f, bh.Redshift)
        write(f, bh.FlagSfr? Int32(1): Int32(0))
        write(f, bh.FlagFeedback? Int32(1): Int32(0))
        write(f, bh.Nall)
        write(f, bh.FlagCooling? Int32(1): Int32(0))
        write(f, bh.NumFiles)
        write(f, bh.BoxSize)
        write(f, bh.Omega0::Float64)
        write(f, bh.HubbleParam::Float64)
        write(f, bh.FlagAge? Int32(1): Int32(0))
        write(f, bh.FlagMetals? Int32(1): Int32(0))
        write(f, bh.NallHW)
        write(f, bh.flag_entr_ics? Int32(1): Int32(0))
        write(f, zeros(UInt8, 4+8+4+4+256 - position(f)))
        write(f, Int32(256))
    end
end