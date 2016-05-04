abstract Block

function GotoBlock!(f, block_name)
    pos = 0
    while true
        seek(f, pos)
        sz = read(f, Int32)
        @assert sz == 8
        if read(f, UInt8, length(block_name)) == block_name.data
            seek(f, pos+16)
            return true
        end
        if eof(f)
            return false
        end
        pos += 16
        seek(f, pos)
        sz = read(f, Int32)
        pos += 8+sz
    end
end

const GAS = 1
const HALO = 2
const DISK = 3
const BULGE = 4
const STARS = 5
const BNDRY = 6

include("./block_header.jl")
include("./block_content.jl")

