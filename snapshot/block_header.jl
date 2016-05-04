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
            )    
        seek(f,4+8+4+4+256)
        @assert read(f, Int32) == 256
        return bh
    end
end